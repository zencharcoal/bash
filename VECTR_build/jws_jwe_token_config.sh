#!/bin/bash

# Define paths and variables
ENV_FILE="/opt/vectr/.env"

# Generate JWS and JWE keys
JWS_KEY=$(openssl rand -base64 32)
JWE_KEY=$(openssl rand -base64 32)

# Update the .env file
echo "VECTR_JWS_SECRET_KEY=$JWS_KEY" >> $ENV_FILE
echo "VECTR_JWE_SECRET_KEY=$JWE_KEY" >> $ENV_FILE

echo "JWS and JWE keys have been generated and added to $ENV_FILE"

