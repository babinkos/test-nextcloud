#!/bin/sh
sudo systemctl stop apt-daily.timer
sudo sed -i 's%deb http:\/\/us.archive.ubuntu.com%deb http:\/\/by.archive.ubuntu.com%' /etc/apt/sources.list
sudo sed -i 's%deb http:\/\/archive.ubuntu.com%deb http:\/\/by.archive.ubuntu.com%' /etc/apt/sources.list
sudo sed -i 's%deb-src http:\/\/us.archive.ubuntu.com%deb-src http:\/\/by.archive.ubuntu.com%' /etc/apt/sources.list
sudo sed -i 's%deb-src http:\/\/archive.ubuntu.com%deb-src http:\/\/by.archive.ubuntu.com%' /etc/apt/sources.list
sudo apt update
exit 1
wget -qO /tmp/chef-server-core_12.17.33-1_amd64.deb https://packages.chef.io/files/stable/chef-server/12.17.33/ubuntu/16.04/chef-server-core_12.17.33-1_amd64.deb
sudo apt install git curl -y
sudo dpkg -i /tmp/chef-server-core_12.17.33-1_amd64.deb
sudo systemctl start apt-daily.timer
sudo mkdir /drop
chef-server-ctl reconfigure

echo "Waiting for services..."
until (curl -D - http://localhost:8000/_status) | grep "200 OK"; do sleep 15s; done
while (curl http://localhost:8000/_status) | grep "fail"; do sleep 15s; done

echo "Creating initial user and organization..."
chef-server-ctl user-create chefadmin Chef Admin admin@4thcoffee.com insecurepassword --filename /drop/chefadmin.pem
chef-server-ctl org-create 4thcoffee "Fourth Coffee, Inc." --association_user chefadmin --filename 4thcoffee-validator.pem
