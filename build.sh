#!/bin/bash

# Ensure directory exists
mkdir -p /opt/render/wkhtmltopdf

# Extract the .deb package from the repository (assuming it's in the root)
dpkg-deb -x wkhtmltox.deb /opt/render/wkhtmltopdf

# Set permissions
chmod +x /opt/render/wkhtmltopdf/usr/local/bin/wkhtmltopdf

# Debugging: Check if extraction worked
ls -lah /opt/render/wkhtmltopdf/usr/local/bin/

# Set environment variables
echo "export PATH=/opt/render/wkhtmltopdf/usr/local/bin:\$PATH" >> /opt/render/.profile
echo "export WKHTMLTOPDF_PATH=/opt/render/wkhtmltopdf/usr/local/bin/wkhtmltopdf" >> /opt/render/.profile
source /opt/render/.profile
