#!/bin/bash

# Define certificate and key paths
CERT_DIR="/opt/vectr/certs"
CERT_FILE="$CERT_DIR/vectr.crt"
KEY_FILE="$CERT_DIR/vectr.key"

# Create the certificates directory if it does not exist
mkdir -p $CERT_DIR

# Generate a self-signed certificate and private key
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $KEY_FILE -out $CERT_FILE <<-EOF
US
California
San Francisco
YourOrganization
YourUnit
yourdomain.com
your.email@example.com
EOF

# Set appropriate permissions
chmod 600 $KEY_FILE
chmod 644 $CERT_FILE

# Ensure the directory has appropriate permissions
chmod 700 $CERT_DIR

# Change ownership to root (adjust the group if VECTR runs under a specific user)
chown root:root $KEY_FILE
chown root:root $CERT_FILE

# Update .env file
ENV_FILE="/opt/vectr/.env"
echo "VECTR_CERTPROFILE=usercert" >> $ENV_FILE
echo "VECTR_SSL_CRT_PATH=$CERT_FILE" >> $ENV_FILE
echo "VECTR_SSL_KEY_PATH=$KEY_FILE" >> $ENV_FILE

echo "Certificate and key have been generated and placed in $CERT_DIR"
echo "Permissions have been set. The .env file has been updated."
echo "Please restart your VECTR Docker containers to apply the changes."

