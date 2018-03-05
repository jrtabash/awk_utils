#!/usr/bin/awk -f

@include "parse_kvpmsg.awk"

BEGIN {
    sum = 0
    cnt = 0
    max = 0
}

function onKVPMessage(type, fields) {
    msgCnts[type] += 1

    if (type == "Order") {
        actionCnts[fields["action"]] += 1
    }

    size = fields["quantity"]
    sum += size
    cnt += 1
    if (size > max) { max = size }
}

{
    parseKVPMessage($0)
}

END {
    print "Order Size Survey:"
    print "   " cnt "\t Count"
    print "   " int(sum / cnt) "\t Average"
    print "   " max "\t Maximum"

    print "Message Type Survey:"
    for (type in msgCnts) {
        print "   " msgCnts[type] "\t " type
    }

    print "Action Survey:"
    for (type in actionCnts) {
        print "   " actionCnts[type] "\t " type
    }
}
