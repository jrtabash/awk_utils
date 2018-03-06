#!/usr/bin/awk -f

function barString(size, maxSize) {
    barSize = size
    if (maxSize > 50) {
        barSize = 50 * size / maxSize
    }
    
    ret = ""
    for (i = 1; i <= barSize; i++) {
        ret = ret "=";
    }
    return ret
}

BEGIN {
    FS = ","
}

{
    if (NF > 1) {
        histo[$1] += $2
    }
    else {
        histo[$1]++
    }
}

END {
    PROCINFO["sorted_in"] = "@val_num_desc"

    max = 0
    for (i in histo) {
        if (histo[i] > max) {
            max = histo[i]
        }
    }

    for (i in histo) {
        print i " \t" histo[i] " \t" barString(histo[i], max)
    }
}
