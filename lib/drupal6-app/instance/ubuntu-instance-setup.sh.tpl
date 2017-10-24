#!/bin/bash
apt-get -y update
apt-get -y install ruby
apt-get -y install wget
cd /home/ubuntu
wget https://aws-codedeploy-${region}.s3.amazonaws.com/latest/install
chmod +x ./install
./install auto
sudo service codedeploy-agent start

sudo apt-get -y install nfs-common
sudo mkdir /efs
sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 ${efs_dns_name}:/ /efs
