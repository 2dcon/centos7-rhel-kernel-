#!/bin/bash

PORT=$((1000 + RANDOM % 10000))
echo "Port $PORT" >> /etc/ssh/sshd_config
echo "The new ssh port is: $PORT"
