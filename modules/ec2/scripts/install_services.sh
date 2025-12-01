#!/bin/bash

# Update packages
apt update -y

# Install NGINX
apt install nginx -y

# Start NGINX
systemctl start nginx

# Enable NGINX to start on boot
systemctl enable nginx

# Optional: Create a test HTML page
echo '<h1>Hello from Ubuntu Linux 2023 NGINX!</h1>' | sudo tee /var/www/html/index.html

