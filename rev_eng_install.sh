#!/bin/bash
# Update system
sudo apt-get update -y
sudo apt-get upgrade -y

 

# Install necessary packages
sudo apt-get install -y build-essential gdb git wget curl python3 python3-pip

 

# Install Radare2 and Iaitō
sudo apt-get install radare2
cd /opt
sudo git clone https://github.com/radareorg/iaito.git
cd iaito
./configure
make
sudo make install

 

# Install Ghidra
wget https://ghidra-sre.org/ghidra_10.0.4_PUBLIC_20210928.zip
unzip ghidra_10.0.4_PUBLIC_20210928.zip
sudo mv ghidra_10.0.4_PUBLIC /opt/ghidra

 

# Install tcpdump
sudo apt-get install tcpdump

 

# Install strace
sudo apt-get install strace

 

# Install hexedit
sudo apt-get install hexedit

 

# Install AFL++
cd /opt
sudo git clone https://github.com/AFLplusplus/AFLplusplus.git
cd AFLplusplus
make
sudo make install

 

# Install Python and necessary libraries for reverse engineering
sudo apt-get install python2.7 python-pip python-dev git libssl-dev libffi-dev build-essential
sudo pip install --upgrade pip
sudo pip install --upgrade pwntools capstone unicorn keystone-engine

 

# Install Wireshark and TShark
sudo apt-get install wireshark tshark

 

# Install Bless hex editor
sudo apt-get install bless

 

# Install Volatility for forensics
sudo apt-get install volatility

 

# Install QEMU for emulation
sudo apt-get install qemu

 

# Install Atom text editor
sudo snap install atom --classic

 

# Install CherryTree for documentation
sudo apt-get install cherrytree
