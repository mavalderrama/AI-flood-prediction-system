// Linux user-space driver for the topann inference IP (AXI4-Lite only).
//
// Fixes over the thesis driver:
//  * weights are written at BASE + 4*index (the old code accumulated offsets);
//  * completion is detected with ap_done (the old loop exited while running);
//  * no /dev/mem and no DDR buffers: everything goes through the UIO mapping;
//  * every open/mmap is checked.
#ifndef ANN_H
#define ANN_H

#include <stdint.h>

#include <string>

#include "model_params.h"

// Register access, so the driver can be tested against a simulated device.
class RegisterIO {
public:
    virtual ~RegisterIO() {}
    virtual uint32_t read(uint32_t offset) = 0;
    virtual void write(uint32_t offset, uint32_t value) = 0;
};

// Registers mapped through /dev/uioN (device tree node of the IP).
class UioRegisters : public RegisterIO {
public:
    UioRegisters() : fd_(-1), base_(0), size_(0) {}
    ~UioRegisters();
    // Returns false and fills `error` on failure.
    bool open(const std::string& uio_dev, const std::string& size_path, std::string* error);
    uint32_t read(uint32_t offset);
    void write(uint32_t offset, uint32_t value);

private:
    int fd_;
    volatile uint32_t* base_;
    size_t size_;
};

class ANN {
public:
    explicit ANN(RegisterIO* regs) : regs_(regs) {}

    // Writes the exported model (model_params.h). Must be called again after
    // every bitstream (re)configuration: reprogramming the PL clears the weights.
    void load_weights();
    void load_weights(const int32_t* w1, const int32_t* b1, const int32_t* w2, int32_t b2);

    // One inference. Returns false on timeout (IP did not raise ap_done).
    bool infer_raw(const int32_t x_raw[N_IN], int32_t* out_raw, unsigned max_polls = 1000000);

    bool is_idle();

private:
    RegisterIO* regs_;
};

#endif
