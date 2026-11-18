// Host tests for the topann driver against a simulated AXI-Lite device.
// Build/run: make host-test  (from Zynq7K/Software)
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ftw.h>
#include <sys/stat.h>
#include <unistd.h>

#include <map>
#include <set>
#include <string>
#include <utility>
#include <vector>

#include "../ANN.h"
#include "../ann_ref.h"
#include "../ann_regs.h"
#include "golden_vectors.h"

static int failures = 0;
#define CHECK(cond, ...)                                  \
    do {                                                  \
        if (!(cond)) {                                    \
            failures++;                                   \
            printf("FAIL %s:%d: ", __FILE__, __LINE__);   \
            printf(__VA_ARGS__);                          \
            printf("\n");                                 \
        }                                                 \
    } while (0)

// Behaves like the HLS IP: reads its operands from the register map defined
// by the macros, computes with the bit-exact reference, raises ap_done.
class FakeTopann : public RegisterIO {
public:
    explicit FakeTopann(int latency_polls)
        : latency_(latency_polls), running_(false), polls_(0), done_(false), reconfig_at_poll_(0) {}

    // A new bitstream: every register back to 0, IP idle.
    void reconfigure() {
        mem_.clear();
        running_ = false;
        done_ = false;
    }
    // Reprogram the PL while an inference is running, at the n-th status poll.
    void reconfigure_during_next_run(int at_poll) { reconfig_at_poll_ = at_poll; }

    uint32_t read(uint32_t off) {
        if (off == ANN_ADDR_AP_CTRL) {
            if (running_ && reconfig_at_poll_ > 0 && polls_ + 1 == reconfig_at_poll_) {
                reconfig_at_poll_ = 0;
                reconfigure();
            }
            if (running_ && latency_ >= 0 && ++polls_ >= latency_) finish();
            uint32_t v = (running_ ? ANN_AP_START : ANN_AP_IDLE) | (done_ ? ANN_AP_DONE : 0);
            done_ = false;   // clear on read
            return v;
        }
        return mem_[off];
    }

    void write(uint32_t off, uint32_t value) {
        writes_.insert(off);
        if (off == ANN_ADDR_AP_CTRL) {
            if (value & ANN_AP_START) {
                running_ = true;
                polls_ = 0;
            }
            return;
        }
        CHECK(off < XTOPANN_SIM_MAP_SIZE && off % 4 == 0, "write outside the register map: 0x%x", off);
        mem_[off] = value;
    }

    int32_t reg(uint32_t off) { return static_cast<int32_t>(mem_[off]); }
    std::set<uint32_t> writes_;

private:
    void finish() {
        int32_t x[N_IN], w1[H_HID * N_IN], b1[H_HID], w2[H_HID];
        for (int i = 0; i < N_IN; i++) x[i] = reg(ANN_ADDR_INPUTS + 4 * i);
        for (int k = 0; k < H_HID * N_IN; k++) w1[k] = reg(ANN_ADDR_W1 + 4 * k);
        for (int j = 0; j < H_HID; j++) {
            b1[j] = reg(ANN_ADDR_B1 + 4 * j);
            w2[j] = reg(ANN_ADDR_W2 + 4 * j);
        }
        mem_[ANN_ADDR_RESULT] = static_cast<uint32_t>(annref::infer(x, w1, b1, w2, reg(ANN_ADDR_B2)));
        running_ = false;
        done_ = true;
    }

    int latency_;   // polls until done; < 0 = never finishes
    bool running_;
    int polls_;
    bool done_;
    int reconfig_at_poll_;
    std::map<uint32_t, uint32_t> mem_;
};

static void test_reference_matches_python_golden() {
    int bad = 0;
    for (int n = 0; n < GOLDEN_N; n++)
        if (annref::infer(GOLDEN_X_RAW[n]) != GOLDEN_Y_RAW[n]) bad++;
    CHECK(bad == 0, "C++ reference differs from Python on %d of %d golden vectors", bad, GOLDEN_N);
    int bad_z = 0;
    for (int n = 0; n < GOLDEN_N; n++)
        for (int j = 0; j < H_HID; j++)
            if (annref::hidden_preact(GOLDEN_X_RAW[n], j) != GOLDEN_Z_RAW[n][j]) bad_z++;
    CHECK(bad_z == 0, "C++ pre-activation rounding differs from Python in %d cases", bad_z);
}

static void test_weights_land_at_their_registers() {
    FakeTopann dev(3);
    ANN ann(&dev);
    ann.load_weights();
    for (int k = 0; k < H_HID * N_IN; k++)
        CHECK(dev.reg(ANN_ADDR_W1 + 4 * k) == W1_RAW[k], "W1[%d] not at its register", k);
    for (int j = 0; j < H_HID; j++) {
        CHECK(dev.reg(ANN_ADDR_B1 + 4 * j) == B1_RAW[j], "B1[%d] not at its register", j);
        CHECK(dev.reg(ANN_ADDR_W2 + 4 * j) == W2_RAW[j], "W2[%d] not at its register", j);
    }
    CHECK(dev.reg(ANN_ADDR_B2) == B2_RAW, "B2 not at its register");
    size_t expected_writes = H_HID * N_IN + 2 * H_HID + 1;
    CHECK(dev.writes_.size() == expected_writes, "expected %zu distinct register writes, got %zu",
          expected_writes, dev.writes_.size());
}

static void test_inference_through_driver_is_bit_exact() {
    FakeTopann dev(5);   // done only after a few status polls
    ANN ann(&dev);
    ann.load_weights();
    int bad = 0;
    for (int n = 0; n < GOLDEN_N; n++) {
        int32_t y;
        bool ok = ann.infer_raw(GOLDEN_X_RAW[n], &y);
        if (!ok || y != GOLDEN_Y_RAW[n]) bad++;
    }
    CHECK(bad == 0, "driver + simulated IP differ from golden on %d of %d vectors", bad, GOLDEN_N);
}

static void test_waits_for_ap_done() {
    // With a long latency the result register is only valid after ap_done;
    // the thesis driver returned before that.
    FakeTopann dev(1000);
    ANN ann(&dev);
    ann.load_weights();
    int32_t y = 0;
    CHECK(ann.infer_raw(GOLDEN_X_RAW[0], &y), "inference should complete");
    CHECK(y == GOLDEN_Y_RAW[0], "result read before ap_done");
}

static void test_timeout() {
    FakeTopann dev(-1);   // never finishes
    ANN ann(&dev);
    int32_t y;
    CHECK(!ann.infer_raw(GOLDEN_X_RAW[0], &y, 1000), "a hung accelerator must time out");
}

static void test_reload_after_reconfiguration() {
    // Any reprogramming path (topann-load, fpgautil, JTAG) clears the weights;
    // the driver must notice by itself.
    FakeTopann dev(3);
    ANN ann(&dev);
    ann.load_weights();
    int32_t y = 0;
    CHECK(ann.infer_raw(GOLDEN_X_RAW[0], &y) && y == GOLDEN_Y_RAW[0], "first inference");
    dev.reconfigure();
    CHECK(ann.infer_raw(GOLDEN_X_RAW[1], &y) && y == GOLDEN_Y_RAW[1], "inference after reprogramming");
    CHECK(ann.reloads() == 1, "expected exactly one automatic reload, got %u", ann.reloads());
}

static void test_reconfiguration_during_inference() {
    // The PL is reprogrammed while the IP is running: the result never comes,
    // or would be computed without weights. The driver must retry once.
    FakeTopann dev(10);
    ANN ann(&dev);
    ann.load_weights();
    dev.reconfigure_during_next_run(4);
    int32_t y = 0;
    bool ok = ann.infer_raw(GOLDEN_X_RAW[2], &y, 1000);
    CHECK(ok && y == GOLDEN_Y_RAW[2], "inference interrupted by reprogramming must be retried");
    CHECK(ann.reloads() == 1, "expected one reload, got %u", ann.reloads());
}

// ------------------------------------------------------------------ sysfs helpers
static bool write_file(const std::string& path, const std::string& text) {
    FILE* f = fopen(path.c_str(), "w");
    if (!f) return false;
    fprintf(f, "%s\n", text.c_str());
    fclose(f);
    return true;
}

static int remove_entry(const char* path, const struct stat*, int, struct FTW*) { return remove(path); }

static void remove_tree(const std::string& root) {
    if (!root.empty()) nftw(root.c_str(), remove_entry, 16, FTW_DEPTH | FTW_PHYS);
}

static std::string make_temp_dir() {
    char tmpl[] = "/tmp/topann_test_XXXXXX";
    const char* d = mkdtemp(tmpl);
    CHECK(d != NULL, "mkdtemp failed");
    return d ? std::string(d) : std::string();
}

// Builds a fake /sys/class/uio tree; returns "" on failure.
static std::string make_fake_sysfs(const std::vector<std::pair<std::string, std::string> >& devs) {
    std::string root = make_temp_dir();
    if (root.empty()) return root;
    for (size_t k = 0; k < devs.size(); k++) {
        std::string dir = root + "/uio" + std::to_string(k);
        bool ok = mkdir(dir.c_str(), 0755) == 0 && mkdir((dir + "/maps").c_str(), 0755) == 0 &&
                  mkdir((dir + "/maps/map0").c_str(), 0755) == 0 &&
                  write_file(dir + "/name", devs[k].first) &&
                  write_file(dir + "/maps/map0/addr", devs[k].second);
        CHECK(ok, "cannot build fake sysfs in %s", root.c_str());
    }
    return root;
}

static void test_uio_discovery() {
    std::vector<std::pair<std::string, std::string> > devs;
    devs.push_back(std::make_pair("axi-pmon", "0xf8891000"));
    devs.push_back(std::make_pair("ip-block", "0x43c00000"));   // matched by address
    std::string root = make_fake_sysfs(devs);
    CHECK(find_uio_device(root, TOPANN_PHYS_BASE) == "/dev/uio1", "should match uio1 by address");
    remove_tree(root);

    devs.clear();
    devs.push_back(std::make_pair("other", "0x41200000"));
    devs.push_back(std::make_pair("TOPANN", "0x80000000"));     // matched by name only
    root = make_fake_sysfs(devs);
    CHECK(find_uio_device(root, TOPANN_PHYS_BASE) == "/dev/uio1", "should match uio1 by name");
    remove_tree(root);

    devs.clear();
    devs.push_back(std::make_pair("other", "0x41200000"));
    root = make_fake_sysfs(devs);
    CHECK(find_uio_device(root, TOPANN_PHYS_BASE).empty(), "no device should match");
    remove_tree(root);
    CHECK(find_uio_device("/nonexistent", TOPANN_PHYS_BASE).empty(), "missing sysfs dir");
}

static void test_uio_symlink_resolution() {
    std::string root = make_temp_dir();
    if (root.empty()) return;
    write_file(root + "/uio7", "");
    CHECK(symlink((root + "/uio7").c_str(), (root + "/topann").c_str()) == 0, "symlink failed");
    CHECK(uio_name_from_path(root + "/topann") == "uio7", "a udev alias must resolve to uio7");
    CHECK(uio_name_from_path("/dev/uio3") == "uio3", "plain device path");
    remove_tree(root);
}

static void test_pl_state_check() {
    std::string root = make_temp_dir();
    if (root.empty()) return;
    std::string state;
    CHECK(pl_is_configured(root + "/missing", &state), "no FPGA Manager: nothing to check");
    write_file(root + "/state", "operating");
    CHECK(pl_is_configured(root + "/state", &state) && state == "operating", "operating PL");
    write_file(root + "/state", "unknown");
    CHECK(!pl_is_configured(root + "/state", &state) && state == "unknown", "unconfigured PL must be refused");
    remove_tree(root);
}

int main() {
    test_uio_discovery();
    test_uio_symlink_resolution();
    test_pl_state_check();
    test_reference_matches_python_golden();
    test_weights_land_at_their_registers();
    test_inference_through_driver_is_bit_exact();
    test_waits_for_ap_done();
    test_timeout();
    test_reload_after_reconfiguration();
    test_reconfiguration_during_inference();
    printf("driver tests: %s (%d failure(s))\n", failures ? "FAILED" : "OK", failures);
    return failures ? 1 : 0;
}
