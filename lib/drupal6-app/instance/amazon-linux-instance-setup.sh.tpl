#cloud-config
package_upgrade: true
packages:
- nfs-utils
- ruby
- httpd24
- postgresql96
- php56
- php56-cli
- php56-opcache
- php56-gd
- php56-fpm
- php56-pdo
- php56-pgsql
- php56-xml

runcmd:
- echo "${efs_dns_name}:/ /mnt/efs nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,_netdev 0 0" >> /etc/fstab
- mkdir -p /mnt/efs
- mount -a -t nfs4
- echo MaxRequestWorkers 2 >> /etc/httpd/conf/httpd.conf
- echo -e "[Date]\ndate.timezone = UTC" > /etc/php-5.6.d/timezone.ini
- service httpd restart
- chkconfig httpd on
- cd /home/ec2-user
- curl -O https://aws-codedeploy-${region}.s3.amazonaws.com/latest/install
- chmod +x ./install
- ./install auto
- service codedeploy-agent start
- chkconfig codedeploy-agent on
