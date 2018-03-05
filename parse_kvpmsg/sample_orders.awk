#!/usr/bin/awk -f

@include "parse_kvpmsg.awk"

BEGIN {
    orderQuantity = 0
    executedQuantity = 0
    maxExecPrice = 0.0
}

function onKVPMessage(type, msg) {
    switch (type) {
    case "Order":
        orderQuantity += msg["quantity"]
        break

    case "Execute":
        executedQuantity += msg["quantity"]
        price = msg["price"]
        if (price > maxExecPrice) {
            maxExecPrice = price
        }
        break

    default:
        break
    }
}

{
    parseKVPMessage($0)
}

END {
    print "     orderQuantity = " orderQuantity
    print "  executedQuantity = " executedQuantity
    print "      maxExecPrice = " maxExecPrice
}
