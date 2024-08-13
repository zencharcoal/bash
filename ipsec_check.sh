#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root."
    exit 1
fi

# Define a function to extract certificate file paths and check permissions
function check_cert_permissions {
    grep -E "^[^#]*certfile|^[^#]*cafile" $1 | awk '{print $NF}' | while read certfile; do
        if [ -f "$certfile" ]; then
            ls -l "$certfile"
        else
            echo "Certificate file not found: $certfile"
        fi
    done
}

echo "IPsec Configuration Overview"
echo "========================================"

# List all configurations from typical ipsec config file locations
CONFIG_FILES=("/etc/ipsec.conf" "/etc/ipsec.d/*.conf")

for config in ${CONFIG_FILES[@]}; do
    if [ -f $config ]; then
        echo "Contents of $config:"
        cat $config
        echo
        check_cert_permissions $config
    elif [ -d $config ]; then
        for file in $config/*; do
            echo "Contents of $file:"
            cat $file
            echo
            check_cert_permissions $file
        done
    else
        echo "$config does not exist."
    fi
done

echo "IPsec Status"
echo "========================================"
ipsec statusall

echo "Network Interface Configuration"
echo "========================================"
ip addr

echo "Routing Table"
echo "========================================"
ip route

echo "Firewall Rules (if applicable)"
echo "========================================"
iptables -L -n -v
iptables -t nat -L -n -v

echo "Script completed."

