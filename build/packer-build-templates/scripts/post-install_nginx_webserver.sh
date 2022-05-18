#!/bin/bash
sudo mkdir Helloworld
echo "This Script will install an nginx webserver on Linux"
## Download the Nginx Signing Key
sudo wget http://nginx.org/keys/nginx_signing.key
## Add the key
sudo apt-key add nginx_signing.key
## Change the directory to etc/apt
cd /etc/apt
## Edit sources.list
sudo apt-get -y update
sudo apt-get install -y nginx
sudo systemctl enable nginx.service
## Start Nginx
sudo systemctl start nginx.service
## check the status
sudo systemctl status nginx.service
sudo cp -r /home/vagrant/2022-team10w/code/express-static-app/public/ /home/vagrant/Helloworld/public/
sudo cp -r /home/vagrant/2022-team10w/code/nginx.conf /etc/nginx/nginx.conf
sudo systemctl restart nginx
