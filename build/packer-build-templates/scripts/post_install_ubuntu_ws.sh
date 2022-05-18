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
# Code to use a decision tree to determine the ws IP and changing the hostname 
# accordingly
#################################################################################

IP=$(hostname -I | awk '{print $2}')

if [ $IP == '192.168.56.102' ]
    then
        sudo hostnamectl set-hostname ws1
elif [ $IP == '192.168.56.103' ]
    then
        sudo hostnamectl set-hostname ws2
elif [ $IP == '192.168.56.104' ]
    then
        sudo hostnamectl set-hostname ws3
fi
#################################################################################
# Example how to install NodeJS
#################################################################################
# https://nodejs.org/en/download/
# https://github.com/nodesource/distributions/blob/master/README.md
# Using Ubuntu
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

#################################################################################
# Change the value of XX to be your team GitHub Repo
# Otherwise your clone operation will fail
# The command: su - vagrant -c switches from root to the user vagrant to execute 
# the git clone command
##################################################################################
su - vagrant -c "git clone git@github.com:illinoistech-itm/2022-team10w.git"
cd /home/vagrant/2022-team10w/code/express-static-app

# This will use the package.json files to install all the applcation 
# needed packages and upgrade npm
sudo npm install -y
sudo npm install -g npm@8.5.2
npm install mysql2
npm install cors
npm install express

# This will install pm2 - a javascript process manager -- like systemd for 
# starting and stopping javascript applciations
# https://pm2.io/
sudo npm install pm2 -g 

# Command to create a service handler and start that javascript app at boot time
pm2 startup
# The pm2 startup command generates this command
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u vagrant --hp /home/vagrant
pm2 start server.js
pm2 save
# Change ownership of the .pm2 meta-files after we create them
sudo chown vagrant:vagrant /home/vagrant/.pm2/rpc.sock /home/vagrant/.pm2/pub.sock

#################################################################################
# Enable http in the firewall
# We will be using the systemd-firewalld firewall by default
# https://firewalld.org/
# https://firewalld.org/documentation/
#################################################################################
sudo firewall-cmd --zone=public --add-service=http --permanent
#sudo firewall-cmd --zone=public --add-service=https --permanent
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --zone=public --add-port=8081/tcp --permanent
sudo firewall-cmd --reload
