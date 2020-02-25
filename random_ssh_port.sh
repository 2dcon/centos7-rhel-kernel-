#!/bin/bash

PORT=$((1000 + RANDOM % 10000))
echo "Port $PORT" >> /etc/ssh/sshd_config
firewall-cmd --permanent --add-port=$PORT/tcp
sudo firewall-cmd --reload
echo "The new ssh port is: $PORT"
