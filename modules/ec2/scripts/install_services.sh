# install nginx

#!/bin/bash

# Update packages
sudo dnf update -y

# Install NGINX
sudo dnf install nginx -y

# Start NGINX
sudo systemctl start nginx

# Enable NGINX to start on boot
sudo systemctl enable nginx

# Optional: Create a test HTML page
echo '<h1>Hello from Amazon Linux 2023 NGINX!</h1>' | sudo tee /usr/share/nginx/html/index.html

