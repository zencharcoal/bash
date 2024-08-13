#!/bin/bash

# Check if a file name is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <domain_list_file>"
    exit 1
fi

# Read the file name from the command line argument
domain_list_file="$1"

# Check if the file exists
if [ ! -f "$domain_list_file" ]; then
    echo "File not found: $domain_list_file"
    exit 1
fi

# Iterate through each domain in the file
while read domain; do
    gobuster dns -d "$domain" -w /path/to/wordlist
done < "$domain_list_file"

