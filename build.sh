#!/bin/bash

# Ensure directory exists
mkdir -p /opt/render/wkhtmltopdf

# Extract the .deb package (assuming it's in the repo root)
dpkg-deb -x wkhtmltox.deb /opt/render/wkhtmltopdf

# Move binary to a more accessible location
mv /opt/render/wkhtmltopdf/usr/local/bin/wkhtmltopdf /opt/render/wkhtmltopdf/wkhtmltopdf

# Set permissions
chmod +x /opt/render/wkhtmltopdf/wkhtmltopdf

# Debugging: Check if extraction worked
ls -lah /opt/render/wkhtmltopdf/

# Set environment variables
echo "export PATH=/opt/render/wkhtmltopdf:\$PATH" >> /opt/render/.profile
echo "export WKHTMLTOPDF_PATH=/opt/render/wkhtmltopdf/wkhtmltopdf" >> /opt/render/.profile
source /opt/render/.profile
