#!/bin/bash

if [[ -f /etc/*-release ]]; then
	. /etc/*-release
	OS=$ID
	VER=$VERSION_ID
fi

echo $OS
echo $VER

if [[ $OS != centos || $VER != 7 ]]; then
	echo Currently the script only supports Centos 7.
	exit 1
fi

#Install Apache
yum -y install httpd
systemctl start httpd.service
systemctl enable httpd.service

#Install MySQL (MariaDB)
yum -y install mariadb-server mariadb
systemctl start mariadb
mysql_secure_installation

systemctl enable mariadb.service

#Install PHP 7.4
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum -y install php php-mysql
yum -y install yum-utils
yum-config-manager --enable remi-php74

#Wordpress
mysql -u root -p

CREATE DATABASE wordpress;
CREATE USER fmaghi@localhost IDENTIFIED BY 'cloudconen';
GRANT ALL PRIVILEGES ON wordpress.* TO fmaghi@localhost IDENTIFIED BY 'cloudcone';
FLUSH PRIVILEGES;
exit

yum -y install php-gd
service httpd restart

yum -y install wget
yum -y install rsync
cd ~
wget http://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
rsync -avP ~/wordpress/ /var/www/html/
mkdir /var/www/html/wp-content/uploads
chown -R apache:apache /var/www/html/*
cd /var/www/html/wp-config-sample.php wp-config.php
