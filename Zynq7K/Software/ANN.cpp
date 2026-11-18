#include "ANN.h"

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>

#include "ann_regs.h"

// ---------------------------------------------------------------- UIO mapping
UioRegisters::~UioRegisters() {
    if (base_) munmap(const_cast<uint32_t*>(base_), size_);
    if (fd_ >= 0) close(fd_);
}

bool UioRegisters::open(const std::string& uio_dev, const std::string& size_path, std::string* error) {
    FILE* f = fopen(size_path.c_str(), "r");
    if (!f) {
        *error = "cannot open " + size_path + ": " + strerror(errno);
        return false;
    }
    unsigned long size = 0;
    int n = fscanf(f, "%lx", &size);
    fclose(f);
    if (n != 1 || size == 0) {
        *error = "cannot parse UIO map size from " + size_path;
        return false;
    }
    fd_ = ::open(uio_dev.c_str(), O_RDWR | O_SYNC);
    if (fd_ < 0) {
        *error = "cannot open " + uio_dev + ": " + strerror(errno);
        return false;
    }
    void* p = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd_, 0);
    if (p == MAP_FAILED) {
        *error = "mmap of " + uio_dev + " failed: " + strerror(errno);
        return false;
    }
    base_ = static_cast<volatile uint32_t*>(p);
    size_ = size;
    if (size_ <= ANN_ADDR_RESULT) {
        *error = "UIO map is smaller than the IP register map";
        return false;
    }
    return true;
}

uint32_t UioRegisters::read(uint32_t offset) { return base_[offset / 4]; }

void UioRegisters::write(uint32_t offset, uint32_t value) { base_[offset / 4] = value; }

// ---------------------------------------------------------------- driver
void ANN::load_weights() { load_weights(W1_RAW, B1_RAW, W2_RAW, B2_RAW); }

void ANN::load_weights(const int32_t* w1, const int32_t* b1, const int32_t* w2, int32_t b2) {
    for (int k = 0; k < H_HID * N_IN; k++) regs_->write(ANN_ADDR_W1 + 4 * k, static_cast<uint32_t>(w1[k]));
    for (int j = 0; j < H_HID; j++) {
        regs_->write(ANN_ADDR_B1 + 4 * j, static_cast<uint32_t>(b1[j]));
        regs_->write(ANN_ADDR_W2 + 4 * j, static_cast<uint32_t>(w2[j]));
    }
    regs_->write(ANN_ADDR_B2, static_cast<uint32_t>(b2));
}

bool ANN::is_idle() { return (regs_->read(ANN_ADDR_AP_CTRL) & ANN_AP_IDLE) != 0; }

bool ANN::infer_raw(const int32_t x_raw[N_IN], int32_t* out_raw, unsigned max_polls) {
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
