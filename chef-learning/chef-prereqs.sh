#!/bin/sh
sudo systemctl stop apt-daily.timer
sudo sed -i 's%deb http:\/\/us.archive.ubuntu.com%deb http:\/\/by.archive.ubuntu.com%' /etc/apt/sources.list
sudo sed -i 's%deb http:\/\/archive.ubuntu.com%deb http:\/\/by.archive.ubuntu.com%' /etc/apt/sources.list
sudo sed -i 's%deb-src http:\/\/us.archive.ubuntu.com%deb-src http:\/\/by.archive.ubuntu.com%' /etc/apt/sources.list
sudo sed -i 's%deb-src http:\/\/archive.ubuntu.com%deb-src http:\/\/by.archive.ubuntu.com%' /etc/apt/sources.list
sudo apt update
#exit 1

if [ -e "/tmp/chef-server-core_12.17.33-1_amd64.deb" ]; then
  echo "using provisioned deb from /tmp"
  #statements
else
  echo "downloading deb to /tmp"
  wget "https://packages.chef.io/files/stable/chef-server/12.17.33/ubuntu/16.04/chef-server-core_12.17.33-1_amd64.deb" -qO "/tmp/chef-server-core_12.17.33-1_amd64.deb"
fi

#2800962092ead67747ed2cd2087b0e254eb5e1a1b169cdc162c384598e4caed5
if [ "$(cat /tmp/chef-server-core_12.17.33-1_amd64.deb | sha256sum | head -c 64)" = "2800962092ead67747ed2cd2087b0e254eb5e1a1b169cdc162c384598e4caed5" ]; then
    echo "Success:  matches provided sha256sum"
else
    echo " doesn't match provided sha256sum"
    exit 1
fi
sudo apt install git curl -y
sudo dpkg -i /tmp/chef-server-core_12.17.33-1_amd64.deb
sudo systemctl start apt-daily.timer
sudo mkdir /drop
chef-server-ctl reconfigure

echo "Waiting for services..."
until (curl -sSD - http://localhost:8000/_status) | grep "200 OK"; do sleep 15s; done
while (curl -sS http://localhost:8000/_status) | grep "fail"; do sleep 15s; done

echo "Creating initial user and organization..."
sudo chef-server-ctl user-create chefadmin Chef Admin admin@4thcoffee.com insecurepassword --filename /drop/chefadmin.pem
sudo chef-server-ctl org-create 4thcoffee "Fourth Coffee, Inc." --association_user chefadmin --filename 4thcoffee-validator.pem
