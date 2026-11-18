# Shared helpers for Vivado/HLS/run_hls.tcl and Vivado/build_hw.tcl.

# Recursive search for files matching `pattern` under `dir`. Also descends into
# hidden directories such as .autopilot, because tool releases move generated
# files (component.xml, xtopann_hw.h) around. Symlinked directories are skipped.
proc find_files {dir pattern} {
    set found [glob -nocomplain -directory $dir -types f $pattern]
    set subdirs [concat [glob -nocomplain -directory $dir -types d *] \
                        [glob -nocomplain -directory $dir -types {d hidden} *]]
    foreach sub $subdirs {
        set tail [file tail $sub]
        if {$tail eq "." || $tail eq ".." || [file type $sub] eq "link"} { continue }
        set found [concat $found [find_files $sub $pattern]]
    }
    return $found
}
