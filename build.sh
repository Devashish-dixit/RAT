#!/bin/bash

# Set up directories
mkdir -p $HOME/wkhtmltopdf

# Download precompiled wkhtmltopdf binary
wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.buster_amd64.deb -O $HOME/wkhtmltox.deb

# Extract the .deb package manually
dpkg-deb -x $HOME/wkhtmltox.deb $HOME/wkhtmltopdf

# Set the correct path for the binary
export WKHTMLTOPDF_PATH="$HOME/wkhtmltopdf/usr/local/bin/wkhtmltopdf"

# Add to PATH
echo "export PATH=$HOME/wkhtmltopdf/usr/local/bin:\$PATH" >> $HOME/.profile
echo "export WKHTMLTOPDF_PATH=$HOME/wkhtmltopdf/usr/local/bin/wkhtmltopdf" >> $HOME/.profile
