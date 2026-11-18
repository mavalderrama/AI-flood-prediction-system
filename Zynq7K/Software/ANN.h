// Linux user-space driver for the topann inference IP (AXI4-Lite only).
//
// Fixes over the thesis driver:
//  * weights are written at BASE + 4*index (the old code accumulated offsets);
//  * completion is detected with ap_done (the old loop exited while running);
//  * registers are mapped at the IP's real address (the old code mapped the
//    register *offsets* as physical addresses, i.e. physical page 0);
//  * every open/mmap is checked.
#ifndef ANN_H
#define ANN_H

#include <stdint.h>
#include <sys/types.h>

#include <string>

#include "model_params.h"

// Address of the IP in the PS7 M_AXI_GP0 window. Must match Vivado/build_hw.tcl.
#define TOPANN_PHYS_BASE 0x43C00000u
#define TOPANN_MAP_SIZE  0x10000u

// Register access, so the driver can be tested against a simulated device.
class RegisterIO {
public:
    virtual ~RegisterIO() {}
    virtual uint32_t read(uint32_t offset) = 0;
    virtual void write(uint32_t offset, uint32_t value) = 0;
};

// Registers mapped into this process, either through a UIO device (preferred,
// needs the device-tree node from Yocto/dts/topann-user.dtsi) or /dev/mem
// (fallback for bring-up, needs root and CONFIG_DEVMEM).
class MappedRegisters : public RegisterIO {
public:
    MappedRegisters() : fd_(-1), base_(0), size_(0) {}
    ~MappedRegisters();
    bool open_uio(const std::string& uio_dev, std::string* error);
    bool open_devmem(uint64_t phys_addr, size_t size, std::string* error);
    uint32_t read(uint32_t offset);
    void write(uint32_t offset, uint32_t value);

private:
    bool map(const std::string& path, off_t offset, size_t size, std::string* error);
    int fd_;
    volatile uint32_t* base_;
    size_t size_;
};

// Finds the UIO device of the IP under `sysfs_uio_dir` (normally
// /sys/class/uio): first by map address == phys_addr, else by a name that
// contains "topann". Returns "" if none matches.
std::string find_uio_device(const std::string& sysfs_uio_dir, uint64_t phys_addr);

// Resolves symlinks (e.g. a udev alias for /dev/uioN) and returns "uioN".
std::string uio_name_from_path(const std::string& dev_path);

// True if the PL is configured according to the FPGA Manager. Returns true
// when the sysfs file does not exist (legacy kernels: nothing to check).
// Touching the IP while the PL is unconfigured stalls the AXI bus.
bool pl_is_configured(const std::string& state_path, std::string* state);

class ANN {
public:
    explicit ANN(RegisterIO* regs);

    // Writes the exported model (model_params.h), or explicit weights.
    void load_weights();
    void load_weights(const int32_t* w1, const int32_t* b1, const int32_t* w2, int32_t b2);

    // Reprogramming the PL clears the weight registers. Before and after every
    // inference the driver reads one non-zero weight back; if it changed, the
    // weights are reloaded (and the inference retried), whatever reprogrammed
    // the PL. Returns true if a reload happened.
    bool ensure_weights();

    // One inference. Returns false on timeout (IP did not raise ap_done).
    bool infer_raw(const int32_t x_raw[N_IN], int32_t* out_raw, unsigned max_polls = 1000000);

    bool is_idle();
    unsigned reloads() const { return reloads_; }

private:
    bool run_once(const int32_t x_raw[N_IN], int32_t* out_raw, unsigned max_polls);

    RegisterIO* regs_;
    const int32_t* w1_;
    const int32_t* b1_;
    const int32_t* w2_;
    int32_t b2_;
    uint32_t sentinel_offset_;   // register holding the first non-zero weight
    uint32_t sentinel_value_;
    bool has_sentinel_;          // false only for an all-zero model
    unsigned reloads_;
};

#endif
