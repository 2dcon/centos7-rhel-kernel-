#!/bin/bash

FILE="/etc/ssh/sshd_config"

sed -i '/^[Port 22]/d' $FILE

PORT=$((1000 + RANDOM % 9000))
echo "Port $PORT" >> $FILE
firewall-cmd --permanent --add-port=$PORT/tcp
sudo firewall-cmd --reload

#Add public ssh key
mkdir ~/.ssh/

echo 'Paste your public key'
read KEY
echo $KEY >> ~/.ssh/authorized_keys

#Disable password login
sed -i '/^[PasswordAuthentication]/d' $FILE
echo "PasswordAuthentication no" >> $FILE

echo "The new ssh port is: $PORT"
