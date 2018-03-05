# Parse messages with the following format:
#   <type>:<name>=<value>,<name>=<value>...
#
# The function expects the user to define an
# onKVPMessage function which will be called with
# the parsed message:
#   onKVPMessage(type, nameValueMap)
#
# To use this parser with gawk, include
# the file parse_kvpmsg.awk in your awk
# script, and call it with each read
# line:
#   parseKVPMessage($0)
# 
function parseKVPMessage(line)
{
    split(line, typeAndFields, ":")
    
    numberOfFields = split(typeAndFields[2], fields, ",")
    for (i = 1; i <= numberOfFields; i++) {
        split(fields[i], nameValue, "=")
        msgFields[nameValue[1]] = nameValue[2]
    }

    onKVPMessage(typeAndFields[1], msgFields)
}
