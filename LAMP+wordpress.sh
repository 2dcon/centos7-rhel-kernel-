#!/bin/bash

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
yum -y install yum-utils
yum-config-manager --enable remi-php74
