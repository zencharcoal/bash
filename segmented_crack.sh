#!/bin/bash

# Define the hash file and output directory
HASH_FILE="hashes.txt"
OUTPUT_DIR="cracked_hashes"

# Create output directory if it doesn't exist
mkdir -p $OUTPUT_DIR

# Lowercase and Digits
hashcat -m 13100 -a 3 -o $OUTPUT_DIR/lower_digits.txt $HASH_FILE ?l?l?l?l?l?l?l?l?l?l

# Uppercase and Digits
hashcat -m 13100 -a 3 -o $OUTPUT_DIR/upper_digits.txt $HASH_FILE ?u?u?u?u?u?u?u?u?u?u

# Mixed Case and Digits
hashcat -m 13100 -a 3 -o $OUTPUT_DIR/mixed_digits.txt $HASH_FILE ?l?u?l?u?d?d?l?u?d?u

# Including Special Characters
hashcat -m 13100 -a 3 -o $OUTPUT_DIR/special_chars.txt $HASH_FILE ?l?u?d?s?l?u?d?s?l?u

echo "Brute-force attacks completed. Check the $OUTPUT_DIR directory for results."

