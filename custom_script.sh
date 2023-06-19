#!/bin/bash
echo "yes"|sudo apt-get update
sudo apt-get upgrade
echo "yes"|sudo apt install python3 python3-pip
echo "yes"|sudo pip install flask
echo "yes"|sudo pip install pymssql
echo "yes"|sudo apt-get install gunicorn
echo "yes"|sudo apt install -y nginx
echo "yes"|sudo apt-get install git
git clone https://github.com/jagruthi35/miniproject-practice.git

sudo touch "/etc/nginx/sites-enabled/miniproject-practice"
file_path="/etc/nginx/sites-enabled/miniproject-practice"

# Define the content
content='server {
    listen 80;
    server_name your_domain_or_public_IP_address;

    location / {
        proxy_pass http://private_ip:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}'
echo "$content" > "$file_path"

sudo service nginx restart
cd miniproject-practice
gunicorn -b $private_ip main:app
