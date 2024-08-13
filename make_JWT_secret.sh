#!/bin/bash

# Generate a 256-bit random value and base64-encode it
jwt_secret=$(openssl rand -base64 32)

# Output the generated JWT secret
echo "Generated JWT Secret: $jwt_secret"
