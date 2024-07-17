#!/bin/bash
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install net-tools
sudo apt-get -y install python3 python3-pip
sudo pip install flask
sudo pip install pymssql
sudo apt-get -y install gunicorn
sudo apt-get -y install nginx
sudo apt-get -y install git
git clone https://github.com/jagruthi35/miniproject-practice.git
private_ip_address=$(hostname -I | awk '{print $1}')
sudo tee /etc/nginx/sites-enabled/miniproject-practice >/dev/null <<EOT
server {
    listen 80;
    server_name 20.114.206.65;

    location / {
        proxy_pass http://$private_ip_address:8000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOT

# Remove the default NGINX configuration
sudo rm -f /etc/nginx/sites-enabled/default

# Restart NGINX
sudo systemctl restart nginx

# Navigate to the cloned repository
cd miniproject-practice

# Start the Flask application using Gunicorn
gunicorn -b $private_ip_address:8000 main:app


##
