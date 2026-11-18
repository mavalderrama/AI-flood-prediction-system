// Daily flood forecaster for the Mississippi River at Baton Rouge.
//
// Reads one CSV row per day (date + the N_COLS input columns of
// model_params.h), computes the causal features, runs the MLP on the FPGA
// (topann IP via UIO) and on the CPU reference, and prints the forecast:
// "flood (stage > FLOOD_STAGE_FT) within the next HORIZON_DAYS days".
//
//   flood-predictor [--replay FILE] [--cpu-only] [--check] [--quiet]
//                   [--uio auto|/dev/uioN] [--devmem]
//
// --uio auto (default) finds the UIO device mapped at TOPANN_PHYS_BASE.
// --devmem maps the IP through /dev/mem instead (root; for bring-up when the
//          device-tree node is missing).
// --check compares against the expected_raw / expected_alarm columns of
// data/processed/golden_replay.csv and exits non-zero on any mismatch.
// --skip-pl-check skips the FPGA Manager "operating" check (see below).
//
// A new bitstream starts with empty weight registers. The driver detects that
// by itself (ANN::ensure_weights) and reloads, whatever reprogrammed the PL.
// SIGHUP forces a reload too; it is handled in every mode, so tools that
// signal flood-predictor never kill it.
//
// Before touching the IP the predictor checks that the PL is configured:
// an AXI access to an unconfigured PL stalls the bus instead of failing.
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include <cmath>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

#include "ANN.h"
#include "ann_ref.h"
#include "features.h"

static volatile sig_atomic_t g_reload = 0;
static void on_sighup(int) { g_reload = 1; }

static double now_us() {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec * 1e6 + ts.tv_nsec / 1e3;
}

static std::vector<std::string> split_csv(const std::string& line) {
    std::vector<std::string> out;
    std::stringstream ss(line);
    std::string item;
    while (std::getline(ss, item, ',')) out.push_back(item);
    return out;
}

static double parse_value(const std::string& s) {
    if (s.empty() || s == "nan" || s == "NaN" || s == "NA") return NAN;
    return strtod(s.c_str(), NULL);
}

static const char* const FPGA_STATE = "/sys/class/fpga_manager/fpga0/state";

int main(int argc, char** argv) {
    signal(SIGHUP, on_sighup);   // first, so a HUP can never terminate the process

    std::string replay, uio = "auto";
    bool cpu_only = false, check = false, quiet = false, devmem = false, skip_pl_check = false;
    for (int i = 1; i < argc; i++) {
        std::string a = argv[i];
        if (a == "--replay" && i + 1 < argc) replay = argv[++i];
        else if (a == "--uio" && i + 1 < argc) uio = argv[++i];
        else if (a == "--devmem") devmem = true;
        else if (a == "--skip-pl-check") skip_pl_check = true;
        else if (a == "--cpu-only") cpu_only = true;
        else if (a == "--check") check = true;
        else if (a == "--quiet") quiet = true;
        else {
            std::cerr << "unknown argument: " << a << "\n";
            return 2;
        }
    }

    MappedRegisters regs;
    ANN* accel = NULL;
    if (!cpu_only) {
        std::string err, state;
        if (!skip_pl_check && !pl_is_configured(FPGA_STATE, &state)) {
            std::cerr << "[ERROR] the PL is not configured (" << FPGA_STATE << " = '" << state
                      << "'). Program it first, e.g. `topann-load WO-OPT` "
                         "(--skip-pl-check to override, --cpu-only to run without the FPGA)\n";
            return 1;
        }
        bool ok;
        if (devmem) {
            ok = regs.open_devmem(TOPANN_PHYS_BASE, TOPANN_MAP_SIZE, &err);
        } else {
            if (uio == "auto") uio = find_uio_device("/sys/class/uio", TOPANN_PHYS_BASE);
            if (uio.empty()) {
                err = "no UIO device for the topann IP (check the device-tree node and the "
                      "uio_pdrv_genirq of_id=generic-uio module option, or use --devmem)";
                ok = false;
            } else {
                ok = regs.open_uio(uio, &err);
            }
        }
        if (!ok) {
            std::cerr << "[ERROR] " << err << " (use --cpu-only to run without the FPGA)\n";
            return 1;
        }
        accel = new ANN(&regs);
        accel->load_weights();
    }

    std::ifstream file;
    if (!replay.empty()) {
        file.open(replay.c_str());
        if (!file) {
            std::cerr << "[ERROR] cannot open " << replay << "\n";
            return 1;
        }
    }
    std::istream& in = replay.empty() ? std::cin : file;

    std::string line;
    if (!std::getline(in, line)) return 1;
    std::vector<std::string> header = split_csv(line);
    for (int c = 0; c < N_COLS; c++) {
        if (static_cast<int>(header.size()) <= c + 1 || header[c + 1] != INPUT_COLUMN_NAMES[c]) {
            std::cerr << "[ERROR] column " << c + 1 << " must be " << INPUT_COLUMN_NAMES[c] << "\n";
            return 1;
        }
    }
    int col_expected_raw = -1, col_expected_alarm = -1;
    for (size_t c = 0; c < header.size(); c++) {
        if (header[c] == "expected_raw") col_expected_raw = static_cast<int>(c);
        if (header[c] == "expected_alarm") col_expected_alarm = static_cast<int>(c);
    }
    if (check && (col_expected_raw < 0 || col_expected_alarm < 0)) {
        std::cerr << "[ERROR] --check needs expected_raw and expected_alarm columns\n";
        return 1;
    }

    FeatureExtractor fx;
    long rows = 0, predictions = 0, alarms = 0, hw_cpu_mismatch = 0, expected_mismatch = 0, hw_timeouts = 0;
    double hw_time_us = 0.0;
    while (std::getline(in, line)) {
        if (line.empty()) continue;
        std::vector<std::string> f = split_csv(line);
        if (static_cast<int>(f.size()) < N_COLS + 1) continue;
        rows++;
        DailyReading r;
        for (int c = 0; c < N_COLS; c++) r.v[c] = parse_value(f[c + 1]);
        fx.push(r);

        if (g_reload) {
            g_reload = 0;
            if (accel) {
                accel->load_weights();
                std::cerr << "[INFO] weights reloaded (SIGHUP)\n";
            }
        }

        double feats[N_IN];
        bool ok = fx.compute(feats);
        std::string exp_raw = col_expected_raw >= 0 ? f[col_expected_raw] : "";
        if (!ok) {
            if (check && exp_raw != "NA") expected_mismatch++;
            if (!quiet) std::cout << f[0] << ",NA,sin datos suficientes\n";
            continue;
        }
        int32_t x[N_IN];
        normalize_and_quantize(feats, x);
        int32_t y_cpu = annref::infer(x);
        int32_t y = y_cpu;
        if (accel) {
            double t0 = now_us();
            int32_t y_hw;
            if (!accel->infer_raw(x, &y_hw)) {
                hw_timeouts++;
                std::cerr << "[ERROR] " << f[0] << ": accelerator timeout (ap_done never set). "
                          << "Is a topann bitstream loaded (topann-load) and is FCLK0 running?\n";
                continue;
            }
            hw_time_us += now_us() - t0;
            if (y_hw != y_cpu) hw_cpu_mismatch++;
            y = y_hw;
        }
        predictions++;
        bool alarm = y > DECISION_THRESHOLD_RAW;
        alarms += alarm;
        if (check) {
            bool raw_ok = exp_raw == std::to_string(y);
            bool alarm_ok = f[col_expected_alarm] == (alarm ? "1" : "0");
            if (!raw_ok || !alarm_ok) {
                if (expected_mismatch < 10)
                    std::cerr << "[MISMATCH] " << f[0] << ": got " << y << " expected " << exp_raw << "\n";
                expected_mismatch++;
            }
        }
        if (!quiet) {
            std::cout << f[0] << "," << annref::from_raw(y) << ","
                      << (alarm ? "ALERTA: inundacion probable en los proximos " : "sin alerta (")
                      << (alarm ? std::to_string(HORIZON_DAYS) + " dias" : std::string("horizonte ") + std::to_string(HORIZON_DAYS) + " d)")
                      << "\n";
        }
    }

    std::cerr << "rows=" << rows << " predictions=" << predictions << " alarms=" << alarms;
    if (accel)
        std::cerr << " hw_cpu_mismatch=" << hw_cpu_mismatch << " hw_timeouts=" << hw_timeouts
                  << " weight_reloads=" << accel->reloads()
                  << " avg_hw_latency_us=" << (predictions ? hw_time_us / predictions : 0.0);
    if (check) std::cerr << " expected_mismatch=" << expected_mismatch;
    std::cerr << "\n";
    delete accel;
    return (hw_cpu_mismatch || hw_timeouts || (check && expected_mismatch)) ? 1 : 0;
}
