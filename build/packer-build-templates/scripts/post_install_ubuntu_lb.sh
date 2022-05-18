#!/bin/bash 
set -e
set -v

#################################################################################
# Install additional packages and dependencies here
# Make sure to leave the -y flag on the apt-get to auto accept the install
# Firewalld is required
#################################################################################

sudo apt-get install -y nginx firewalld

#################################################################################
# Update /etc/hosts file
#################################################################################

echo "192.168.56.101     lb    lb.class.edu"    | sudo tee -a /etc/hosts
echo "192.168.56.102     ws1   ws1.class.edu"   | sudo tee -a /etc/hosts
echo "192.168.56.103     ws2   ws2.class.edu"   | sudo tee -a /etc/hosts
echo "192.168.56.104     ws3   ws3.class.edu"   | sudo tee -a /etc/hosts
echo "192.168.56.105     db    db.class.edu"    | sudo tee -a /etc/hosts

#################################################################################
# Set hostname
#################################################################################
sudo hostnamectl set-hostname lb

#################################################################################
# Change the value of XX to be your team GitHub Repo
# Otherwise your clone operation will fail
# The command: su - vagrant -c switches from root to the user vagrant to execute 
# the git clone command
##################################################################################
su - vagrant -c "git clone git@github.com:illinoistech-itm/2022-team10w.git"
cd /home/vagrant/2022-team10w/code/express-static-app

#################################################################################
# Documentation for configuring load-balancing in Nginx
#################################################################################
# https://nginx.org/en/docs/http/load_balancing.html
# https://stackoverflow.com/questions/10175812/how-to-create-a-self-signed-certificate-with-openssl
# https://ethitter.com/2016/05/generating-a-csr-with-san-at-the-command-line/


# Nginx configurations
# https://nginx.org/en/docs/beginners_guide.html
# https://dev.to/guimg/how-to-serve-nodejs-applications-with-nginx-on-a-raspberry-jld
sudo cp -v /home/vagrant/2022-team10w/code/default /etc/nginx/sites-enabled
sudo cp -v /home/vagrant/2022-team10w/code/nginx.conf /etc/nginx/

# Restart the Nginx service so it actualizes the updates just made
sudo nginx -t
sudo systemctl daemon-reload
sudo systemctl reload nginx
sudo systemctl restart nginx

# This will use the package.json files to install all the applcation 
# needed packages and upgrade npm
sudo apt install -y nodejs

# This will install pm2 - a javascript process manager -- like systemd for 
# starting and stopping javascript applciations
# https://pm2.io/
#sudo npm install pm2 -g 

# Command to create a service handler and start that javascript app at boot time
#pm2 startup
# The pm2 startup command generates this command
#sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u vagrant --hp /home/vagrant
#pm2 start server.js
#pm2 save
# Change ownership of the .pm2 meta-files after we create them
#sudo chown vagrant:vagrant /home/vagrant/.pm2/rpc.sock /home/vagrant/.pm2/pub.sock
sudo nginx -t
sudo systemctl daemon-reload
sudo systemctl reload nginx
sudo systemctl restart nginx

#################################################################################
# Enable http in the firewall
# We will be using the systemd-firewalld firewall by default
# https://firewalld.org/
# https://firewalld.org/documentation/
# Enable http in the firewall
#################################################################################
sudo firewall-cmd --zone=public --add-service=https --permanent
sudo firewall-cmd --zone=public --add-service=http --permanent
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --reload
cd ~
