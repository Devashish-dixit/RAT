#!/bin/bash

# Download precompiled wkhtmltopdf binary
wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.buster_amd64.deb

# Extract the binary manually
dpkg-deb -x wkhtmltox_0.12.6-1.buster_amd64.deb $HOME/wkhtmltopdf

# Set the environment variable for wkhtmltopdf
echo "export PATH=\$HOME/wkhtmltopdf/usr/local/bin:\$PATH" >> $HOME/.profile
