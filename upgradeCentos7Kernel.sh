#!/bin/bash

#check distro version
if [ -f /etc/os-release ]; then
	. /etc/os-release
	OS=$ID
	VER=$VERSION_ID
fi

if [[ $OS == centos && ( $VER == 7 || $VER == 8 ) ]]; then
	echo This is the right system\!
else
	echo The script only works \for CentOS 7 and 8.
	exit 1
fi

#for CentOS 7
if [[ $VER == 7 ]]; then
	rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
	rpm -Uvh https://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
	yum -y update
	yum -y --enablerepo=elrepo-kernel install kernel-ml
	grub2-set-default 0
	reboot
#for CentOS 8
else
	rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
	dnf -y install https://www.elrepo.org/elreporelease-8.0-2.el8.elrepo.noarch.rpm
	dnf -y update
	dnf --enablerepo=elrepo-kernel install kernel-ml
	reboot
fi

exit 0
