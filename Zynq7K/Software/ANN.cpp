#include "ANN.h"

#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>

#include <algorithm>
#include <cctype>
#include <limits>
#include <vector>

#include "ann_regs.h"

// ---------------------------------------------------------------- sysfs helpers
static bool read_sysfs_hex(const std::string& path, unsigned long long* value) {
    FILE* f = fopen(path.c_str(), "r");
    if (!f) return false;
    int n = fscanf(f, "%llx", value);
    fclose(f);
    return n == 1;
}

static std::string read_sysfs_line(const std::string& path) {
    FILE* f = fopen(path.c_str(), "r");
    if (!f) return "";
    char buf[256] = {0};
    if (!fgets(buf, sizeof buf, f)) buf[0] = 0;
    fclose(f);
    std::string s(buf);
    while (!s.empty() && (s[s.size() - 1] == '\n' || s[s.size() - 1] == '\r')) s.erase(s.size() - 1);
    return s;
}

static std::string to_lower(std::string s) {
    std::transform(s.begin(), s.end(), s.begin(),
                   [](unsigned char c) { return static_cast<char>(std::tolower(c)); });
    return s;
}

std::string uio_name_from_path(const std::string& dev_path) {
    char resolved[PATH_MAX];
    std::string p = realpath(dev_path.c_str(), resolved) ? std::string(resolved) : dev_path;
    return p.substr(p.find_last_of('/') + 1);
}

bool pl_is_configured(const std::string& state_path, std::string* state) {
    FILE* f = fopen(state_path.c_str(), "r");
    if (!f) {
        *state = "";
        return true;   // no FPGA Manager: nothing to check
    }
    fclose(f);
    *state = read_sysfs_line(state_path);
    return *state == "operating";
}

std::string find_uio_device(const std::string& sysfs_uio_dir, uint64_t phys_addr) {
    DIR* d = opendir(sysfs_uio_dir.c_str());
    if (!d) return "";
    std::vector<std::string> entries;
    while (struct dirent* e = readdir(d)) {
        if (strncmp(e->d_name, "uio", 3) == 0) entries.push_back(e->d_name);
    }
    closedir(d);
    std::sort(entries.begin(), entries.end());

    std::string by_name;
    for (size_t k = 0; k < entries.size(); k++) {
        const std::string dir = sysfs_uio_dir + "/" + entries[k];
        unsigned long long addr = 0;
        if (read_sysfs_hex(dir + "/maps/map0/addr", &addr) && addr == phys_addr) return "/dev/" + entries[k];
        if (by_name.empty() && to_lower(read_sysfs_line(dir + "/name")).find("topann") != std::string::npos)
            by_name = "/dev/" + entries[k];
    }
    return by_name;
}

// ---------------------------------------------------------------- mapping
MappedRegisters::~MappedRegisters() {
    if (base_) munmap(const_cast<uint32_t*>(base_), size_);
    if (fd_ >= 0) close(fd_);
}

bool MappedRegisters::map(const std::string& path, off_t offset, size_t size, std::string* error) {
    fd_ = ::open(path.c_str(), O_RDWR | O_SYNC);
    if (fd_ < 0) {
        *error = "cannot open " + path + ": " + strerror(errno);
        return false;
    }
    void* p = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd_, offset);
    if (p == MAP_FAILED) {
        *error = "mmap of " + path + " failed: " + strerror(errno);
        return false;
    }
    base_ = static_cast<volatile uint32_t*>(p);
    size_ = size;
    if (size_ <= ANN_ADDR_RESULT) {
        *error = "mapping is smaller than the IP register map";
        return false;
    }
    return true;
}

bool MappedRegisters::open_uio(const std::string& uio_dev, std::string* error) {
    // /dev/uioN (or a symlink to it) -> /sys/class/uio/uioN/maps/map0/size
    const std::string size_path = "/sys/class/uio/" + uio_name_from_path(uio_dev) + "/maps/map0/size";
    unsigned long long size = 0;
    if (!read_sysfs_hex(size_path, &size) || size == 0) {
        *error = "cannot read UIO map size from " + size_path;
        return false;
    }
    return map(uio_dev, 0, static_cast<size_t>(size), error);
}

bool MappedRegisters::open_devmem(uint64_t phys_addr, size_t size, std::string* error) {
    if (phys_addr % static_cast<uint64_t>(sysconf(_SC_PAGESIZE)) != 0) {
        *error = "physical address is not page aligned";
        return false;
    }
    if (phys_addr > static_cast<uint64_t>(std::numeric_limits<off_t>::max())) {
        *error = "physical address does not fit in off_t (build with -D_FILE_OFFSET_BITS=64)";
        return false;
    }
    return map("/dev/mem", static_cast<off_t>(phys_addr), size, error);
}

uint32_t MappedRegisters::read(uint32_t offset) { return base_[offset / 4]; }

void MappedRegisters::write(uint32_t offset, uint32_t value) { base_[offset / 4] = value; }

// ---------------------------------------------------------------- driver
ANN::ANN(RegisterIO* regs)
    : regs_(regs), w1_(W1_RAW), b1_(B1_RAW), w2_(W2_RAW), b2_(B2_RAW),
      sentinel_offset_(0), sentinel_value_(0), has_sentinel_(false), reloads_(0) {}

void ANN::load_weights() { load_weights(W1_RAW, B1_RAW, W2_RAW, B2_RAW); }

void ANN::load_weights(const int32_t* w1, const int32_t* b1, const int32_t* w2, int32_t b2) {
    w1_ = w1;
    b1_ = b1;
    w2_ = w2;
    b2_ = b2;
    has_sentinel_ = false;
    for (int k = 0; k < H_HID * N_IN; k++) {
        regs_->write(ANN_ADDR_W1 + 4 * k, static_cast<uint32_t>(w1[k]));
        if (!has_sentinel_ && w1[k] != 0) {
            sentinel_offset_ = ANN_ADDR_W1 + 4 * k;
            sentinel_value_ = static_cast<uint32_t>(w1[k]);
            has_sentinel_ = true;
        }
    }
    for (int j = 0; j < H_HID; j++) {
        regs_->write(ANN_ADDR_B1 + 4 * j, static_cast<uint32_t>(b1[j]));
        regs_->write(ANN_ADDR_W2 + 4 * j, static_cast<uint32_t>(w2[j]));
    }
    regs_->write(ANN_ADDR_B2, static_cast<uint32_t>(b2));
}

bool ANN::ensure_weights() {
    // An all-zero model cannot be told apart from a freshly configured PL: always reload.
    if (has_sentinel_ && regs_->read(sentinel_offset_) == sentinel_value_) return false;
    load_weights(w1_, b1_, w2_, b2_);
    reloads_++;
    return true;
}

bool ANN::is_idle() { return (regs_->read(ANN_ADDR_AP_CTRL) & ANN_AP_IDLE) != 0; }

bool ANN::run_once(const int32_t x_raw[N_IN], int32_t* out_raw, unsigned max_polls) {
    unsigned polls = 0;
    while (!is_idle()) {
        if (++polls > max_polls) return false;
    }
    for (int i = 0; i < N_IN; i++) regs_->write(ANN_ADDR_INPUTS + 4 * i, static_cast<uint32_t>(x_raw[i]));
    regs_->write(ANN_ADDR_AP_CTRL, ANN_AP_START);
    polls = 0;
    // ap_done is clear-on-read: this read is the one that consumes it.
    while ((regs_->read(ANN_ADDR_AP_CTRL) & ANN_AP_DONE) == 0) {
        if (++polls > max_polls) return false;
    }
    *out_raw = static_cast<int32_t>(regs_->read(ANN_ADDR_RESULT));
    return true;
}

bool ANN::infer_raw(const int32_t x_raw[N_IN], int32_t* out_raw, unsigned max_polls) {
    // Second attempt only if the PL was reprogrammed during the first one
    // (the result would have been computed without weights, or never arrive).
    for (int attempt = 0; attempt < 2; attempt++) {
        ensure_weights();
        bool done = run_once(x_raw, out_raw, max_polls);
        if (!ensure_weights()) return done;
    }
    return false;
}
