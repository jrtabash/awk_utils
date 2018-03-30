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
        data[$1] += $2
    }
    else {
        data[$1]++
    }
}

END {
    PROCINFO["sorted_in"] = "@val_num_desc"

    max = 0
    for (i in data) {
        if (data[i] > max) {
            max = data[i]
        }
    }

    for (i in data) {
        print i " \t" data[i] " \t" barString(data[i], max)
    }
}
