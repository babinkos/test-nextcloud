#!/usr/bin/env bash

sudo systemctl stop apt-daily.timer
sudo sed -i 's%deb http:\/\/us.archive.ubuntu.com%deb http:\/\/by.archive.ubuntu.com%' /etc/apt/sources.list
sudo sed -i 's%deb http:\/\/archive.ubuntu.com%deb http:\/\/by.archive.ubuntu.com%' /etc/apt/sources.list
sudo sed -i 's%deb-src http:\/\/us.archive.ubuntu.com%deb-src http:\/\/by.archive.ubuntu.com%' /etc/apt/sources.list
sudo sed -i 's%deb-src http:\/\/archive.ubuntu.com%deb-src http:\/\/by.archive.ubuntu.com%' /etc/apt/sources.list
sudo apt update
sudo apt install wget git curl -y
#exit 1

#https://downloads.chef.io/chef-server/12.17.33#ubuntu
# https://downloads.chef.io/manage
#debs=("https://packages.chef.io/files/stable/chef-server/12.17.33/ubuntu/16.04/chef-server-core_12.17.33-1_amd64.deb" "https://packages.chef.io/files/stable/chef-manage/2.5.15/ubuntu/16.04/chef-manage_2.5.15-1_amd64.deb")
#hashes=("2800962092ead67747ed2cd2087b0e254eb5e1a1b169cdc162c384598e4caed5" "2a7e1a466b954b2744494115315d5f7e0b8435bdd2af83c41587fa3b9e3f0f7e")

SUB_0=("https://packages.chef.io/files/stable/chef-server/12.17.33/ubuntu/16.04/chef-server-core_12.17.33-1_amd64.deb" "2800962092ead67747ed2cd2087b0e254eb5e1a1b169cdc162c384598e4caed5")
SUB_1=("https://packages.chef.io/files/stable/chef-manage/2.5.15/ubuntu/16.04/chef-manage_2.5.15-1_amd64.deb" "2a7e1a466b954b2744494115315d5f7e0b8435bdd2af83c41587fa3b9e3f0f7e")
MAIN_ARRAY=(
  SUB_0[@]
  SUB_1[@]
)

COUNT=${#MAIN_ARRAY[@]}
for ((i=0; i<$COUNT; i++))
do
  NAME=${!MAIN_ARRAY[i]:0:1}
  VALUE=${!MAIN_ARRAY[i]:1:1}
  if [ -e "/tmp/${NAME##*/}" ]; then
    echo "using provisioned deb from /tmp/${NAME##*/}"
    #statements
  else
    echo "downloading deb to /tmp/${NAME##*/}"
    wget $NAME -qP /tmp
  fi
    echo "/tmp/${NAME##*/}"
  if [ "$(cat /tmp/${NAME##*/} | sha256sum | head -c 64)" = "$VALUE" ]; then
        echo "Success:  matches provided sha256sum for /tmp/${NAME##*/}"
        sudo dpkg -i "/tmp/${NAME##*/}"
  else
        echo " doesn't match provided sha256sum for /tmp/${NAME##*/}"
        exit 1
  fi
done

sudo mkdir /drop
sudo chef-server-ctl reconfigure
sleep 2
echo "Waiting for services..."
until (curl -sSD - http://localhost:8000/_status) | grep "200 OK"; do sleep 15s; done
while (curl -sS http://localhost:8000/_status) | grep "fail"; do sleep 15s; done
sleep 2
echo "Creating initial user and organization..."
sudo chef-server-ctl user-create chefadmin Chef Admin admin@4thcoffee.com insecurepassword --filename /drop/chefadmin.pem
sudo chef-server-ctl org-create 4thcoffee "Fourth Coffee, Inc." --association_user chefadmin --filename 4thcoffee-validator.pem

sudo chef-manage-ctl reconfigure --accept-license
echo "chef-server installation finished ! Please use https://localhost:8443/login to access management console"
sudo systemctl start apt-daily.timer
