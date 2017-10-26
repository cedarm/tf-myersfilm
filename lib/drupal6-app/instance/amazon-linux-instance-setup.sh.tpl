#cloud-config
package_upgrade: true
packages:
- nfs-utils
- ruby
- httpd
runcmd:
- echo "${efs_dns_name}:/ /var/www/html/efs-mount-point nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,_netdev 0 0" >> /etc/fstab
- mkdir -p /var/www/html/efs-mount-point
- mount -a -t nfs4
- touch /var/www/html/efs-mount-point/test.html
- service httpd start
- chkconfig httpd on
- cd /home/ec2-user
- curl -O https://aws-codedeploy-${region}.s3.amazonaws.com/latest/install
- chmod +x ./install
- ./install auto
- service codedeploy-agent start
- chkconfig codedeploy-agent on
