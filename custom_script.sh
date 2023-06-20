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

sudo touch "/etc/nginx/sites-enabled/miniproject-practice"
file_path="/etc/nginx/sites-enabled/miniproject-practice"
ip_address=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
echo "private_ip: $ip_address"
# Define the content
content='server {
    listen 80;
    server_name 20.114.206.65;

    location / {
        proxy_pass http://$ip_address:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}'
echo "$content" > "$file_path"
sudo unlink /etc/nginx/sites-enabled/default
sudo nginx -s reload
sudo service nginx restart
cd miniproject-practice
gunicorn -b $ip_address main:app
