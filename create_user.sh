#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

if [ $# -ne 1 ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

USERNAME="$1"
SSH_DIR="/home/$USERNAME/.ssh"
SSH_PRIVATE_KEY="$SSH_DIR/id_rsa"
SSH_PUBLIC_KEY="$SSH_DIR/id_rsa.pub"
AUTHORIZED_KEYS_FILE="$SSH_DIR/authorized_keys"

# Check if the user already exists
if id "$USERNAME" &>/dev/null; then
    echo "User $USERNAME already exists."
else
    # Create a new user
    useradd -m "$USERNAME" -s /bin/bash
    echo "User $USERNAME has been created."
fi

# Create the .ssh directory if it doesn't exist
if [ ! -d "$SSH_DIR" ]; then
    mkdir -p "$SSH_DIR"
    chmod 700 "$SSH_DIR"
    chown "$USERNAME:$USERNAME" "$SSH_DIR"
fi

# Generate SSH keys for the user
sudo -u "$USERNAME" ssh-keygen -t rsa -f "$SSH_PRIVATE_KEY" -N ""

# Copy the private key to your home directory for sharing
cp "$SSH_PRIVATE_KEY" "/root/$USERNAME-id_rsa"

# Print the public key
if [ -f "$SSH_PUBLIC_KEY" ]; then
    cat "$SSH_PUBLIC_KEY" >> "$AUTHORIZED_KEYS_FILE"
    chmod 600 "$AUTHORIZED_KEYS_FILE"
    chown "$USERNAME:$USERNAME" "$AUTHORIZED_KEYS_FILE"
else
    echo "SSH Public Key for $USERNAME not found."
fi

echo "SSH keys generated, and private key copied to your home directory."

