#!/usr/bin/awk -f

BEGIN {
    show_first = first
    show_col = col
}

{
    if (NF > 1) {
        if (show_first) {
            printf "%s ", $1
        }

        if (show_col) {
            printf "%s ", $show_col
        }
        else {
            printf "%s ", $2
        }
    }
    else {
        printf "%s ", $1
    }
}

END {
    printf "\n"
}
