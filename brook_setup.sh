#!/bin/bash

#required package
yum -y update
yum -y install wget

#define colors
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
clr=$'\e[0m'

printf "What would you like to do?\n"
printf "$grn\t1.Install Brook\n$clr"
printf "$red\t2.Uninstall Brook$clr"

read OPTION

case $OPTION in
	#install
	1)
		printf "Install Brook?(y/n)"
		read YN
		if [[ $YN != Y && $YN != y ]]; then
		printf "Operation terminated.\n"
		exit 0
		fi

		mkdir /bin/brook
		cd /bin/brook
		wget https://github.com/txthinking/brook/releases/download/v20200201/brook
		cd /etc/systemd/system/
		printf "Which port would you like to use? (Leave blank for random prot)\n"
		read PORT
		if [[ -z $PORT ]]; then
			PORT = $((10000 + RANDOM % 55536))
		fi

		printf "Set the password (default: 2dcon@github): "
		read PW
		if [[ -z $PW ]]; then
			PW = '2dcon@github'
		fi

		echo "[Unit]
Description=Brook VPN

[Service]
ExecStart=/bin/brook server -l :$PORT -p $PW

[Install]
WantedBy=multi-user.target" > brook.service

		systemctl daemon-reload
		systemctl enable brook
		systemctl start brook
		;;

	#uninstall
	2)
		printf "Uninstall Brook(y/n)"
		read YN
		if [[ $YN != Y && $YN != y ]]; then
		printf "Operation terminated.\n"
		exit 0
		fi

	rm -r /bin/brook
	  ;;
	*)
esac

exit 0
