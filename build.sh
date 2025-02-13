#!/bin/bash

# Create a directory for wkhtmltopdf
mkdir -p $HOME/bin

# Download precompiled static binary
wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox-0.12.6-1-linux-generic-amd64.tar.xz -O $HOME/wkhtmltox.tar.xz

# Extract the tar file
tar -xf $HOME/wkhtmltox.tar.xz -C $HOME/bin --strip-components=1

# Ensure the binary is executable
chmod +x $HOME/bin/bin/wkhtmltopdf

# Set the correct path for wkhtmltopdf
export WKHTMLTOPDF_PATH="$HOME/bin/bin/wkhtmltopdf"

# Add it to the PATH so the app can find it
echo "export PATH=$HOME/bin/bin:\$PATH" >> $HOME/.profile
echo "export WKHTMLTOPDF_PATH=$HOME/bin/bin/wkhtmltopdf" >> $HOME/.profile
