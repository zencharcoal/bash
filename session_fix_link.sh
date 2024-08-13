\#!/bin/bash

# This bash script creates a clickable hyperlink to manually set the web server URL and set the JSESSIONID cookie to a desired setting.

echo "Please enter the web server URL:"
read url

echo "Please enter the desired JSESSIONID cookie value:"
read jsessionid

echo "<a href=\"$url\" onclick=\"Set-\Cookie='JSESSIONID=$jsessionid';\">Click ME</a>"

