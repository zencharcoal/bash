#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <ASCII Key>"
    exit 1
fi

ASCII_KEY="$1"

# Generate Hexadecimal Key for command-line usage
HEX_KEY=$(echo -n "$ASCII_KEY" | xxd -p | tr -d '\n')
echo "Hex Key for OpenSSL: $HEX_KEY"

# Generate C-style Byte Array
BYTE_ARRAY="unsigned char rc4Key[] = {"
for (( i=0; i<${#ASCII_KEY}; i++ )); do
    BYTE=$(printf '0x%02x, ' "'${ASCII_KEY:$i:1}")
    BYTE_ARRAY+="$BYTE"
done
BYTE_ARRAY=${BYTE_ARRAY%, }
BYTE_ARRAY+="};"
echo "Byte Array for C: $BYTE_ARRAY"

