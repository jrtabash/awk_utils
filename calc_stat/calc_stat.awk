#!/usr/bin/awk -f

BEGIN {
    count = 0
    sum = 0
    average = 0
    median = 0
    min = 0
    max = 0
}

{
    count++
    values[count] = $1
    sum += $1
    if ($1 < min || count == 1) { min = $1 }
    if ($1 > max) { max = $1 }
}

END {
    if (count > 0) {
        n = asort(values)
        
        if (n % 2 == 0) {
            idx = n / 2
            median = (values[idx] + values[idx + 1]) / 2
        }
        else {
            idx = int(n / 2)
            median = values[idx + 1]
        }

        average = sum / count
    }

    print "cnt: " count
    print "sum: " sum
    print "avg: " average
    print "med: " median
    print "min: " min
    print "max: " max
}
