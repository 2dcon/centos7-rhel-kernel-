#################################################
# WARNING: make sure to note down the new port! #
#################################################
#!/bin/bash

#Add public ssh key
mkdir ~/.ssh/

echo 'Paste your public key'
read KEY
echo $KEY >> ~/.ssh/authorized_keys

#set a random port for ssh
FILE="/etc/ssh/sshd_config"

sed -i '/^[Port 22]/d' $FILE

yum install policycoreutils-python

PORT=$((1000 + RANDOM % 9000))
semanage port -a -t ssh_port_t -p tcp $PORT
firewall-cmd --permanent --add-port=$PORT/tcp
sudo firewall-cmd --reload

#Disable password login
sed -i '/^[PasswordAuthentication]/d' $FILE
echo "Port $PORT" >> $FILE
echo "PasswordAuthentication no" >> $FILE

systemctl restart sshd

echo "The new ssh port is: $PORT"
