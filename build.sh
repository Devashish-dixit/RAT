#!/bin/bash

# Create necessary directories
mkdir -p /opt/render/wkhtmltopdf

# Download wkhtmltopdf
wget -O /opt/render/wkhtmltox.deb https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.buster_amd64.deb

# Extract the .deb package
dpkg-deb -x /opt/render/wkhtmltox.deb /opt/render/wkhtmltopdf

# Set correct permissions
chmod +x /opt/render/wkhtmltopdf/usr/local/bin/wkhtmltopdf

# Debug: Check if the file exists
ls -lah /opt/render/wkhtmltopdf/usr/local/bin/

# Set environment variable so Streamlit can find wkhtmltopdf
echo "export PATH=/opt/render/wkhtmltopdf/usr/local/bin:\$PATH" >> /opt/render/.profile
echo "export WKHTMLTOPDF_PATH=/opt/render/wkhtmltopdf/usr/local/bin/wkhtmltopdf" >> /opt/render/.profile
source /opt/render/.profile
