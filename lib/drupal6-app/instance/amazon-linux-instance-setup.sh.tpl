#!/bin/bash
yum -y update
yum install -y ruby
cd /home/ec2-user
curl -O https://aws-codedeploy-${region}.s3.amazonaws.com/latest/install
chmod +x ./install
./install auto
sudo service codedeploy-agent start

sudo yum -y install nfs-utils
sudo mkdir /efs
sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 ${efs_dns_name}:/ /efs
