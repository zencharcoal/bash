#!/bin/bash

# Prompt for username and password
read -p "Enter the username for the new user: " username
read -s -p "Enter the password for the new user: " password
echo

# Create new user
useradd -m -s /bin/bash $username

# Set the password for the new user
echo "$username:$password" | chpasswd

# Add user to the sudo group
usermod -aG sudo $username

# Create .ssh directory for the new user
mkdir -p /home/$username/.ssh
chmod 700 /home/$username/.ssh
chown $username:$username /home/$username/.ssh

# Generate SSH key pair for the new user
sudo -u $username ssh-keygen -t rsa -b 4096 -C "$username@$(hostname)" -f "/home/$username/.ssh/id_rsa" -N ''

# Create authorized_keys file
touch /home/$username/.ssh/authorized_keys
chmod 600 /home/$username/.ssh/authorized_keys
chown $username:$username /home/$username/.ssh/authorized_keys

# Append the generated SSH public key to the authorized_keys
cat "/home/$username/.ssh/id_rsa.pub" >> "/home/$username/.ssh/authorized_keys"

echo "User '$username' created successfully."
echo "SSH key pair generated for user '$username'."

