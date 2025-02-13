#!/bin/bash
# Create a directory for wkhtmltopdf
mkdir -p $HOME/wkhtmltopdf

# Download precompiled wkhtmltopdf binary
wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.buster_amd64.deb -O $HOME/wkhtmltox.deb

# Extract the .deb package manually
dpkg-deb -x $HOME/wkhtmltox.deb $HOME/wkhtmltopdf

# Set executable permissions
chmod +x $HOME/wkhtmltopdf/usr/local/bin/wkhtmltopdf

# Add to PATH
echo "export PATH=\$HOME/wkhtmltopdf/usr/local/bin:\$PATH" >> $HOME/.profile
