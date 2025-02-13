#!/bin/bash

# Set up directories
mkdir -p /opt/render/wkhtmltopdf

# Download precompiled wkhtmltopdf binary
wget -O /opt/render/wkhtmltox.deb https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.buster_amd64.deb

# Extract the .deb package
dpkg-deb -x /opt/render/wkhtmltox.deb /opt/render/wkhtmltopdf

# Set permissions
chmod +x /opt/render/wkhtmltopdf/usr/local/bin/wkhtmltopdf

# Export path so Streamlit can find it
echo "export PATH=/opt/render/wkhtmltopdf/usr/local/bin:\$PATH" >> /opt/render/.profile
echo "export WKHTMLTOPDF_PATH=/opt/render/wkhtmltopdf/usr/local/bin/wkhtmltopdf" >> /opt/render/.profile
