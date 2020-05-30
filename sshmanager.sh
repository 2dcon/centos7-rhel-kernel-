#!/bin/bash
# ssh manager

DIR=$'/home/fmaghi/scripts/vps'
cd $DIR

i=0
declare -a filelist

for filename in *; do
  if [ "$filename" != "template.sh" ]; then
    filelist[$i]=$filename
    ((i++))
  fi
done

for ((j = 0; j < i; j++)); do
  echo $((j+1)). ${filelist[$j]}
done

echo 'Select a script, or enter 0 to add a new script:'

read k

if (( k == 0 )); then
  echo "Enter the host name: "
  read hostname
  echo "Enter the IP address: "
  read ip
  echo "Enter the port number: "
  read port

  printf "Please confirm the information below\n\thostname: $hostname\n\tIP address: $ip\n\tPort: $port\n"
  read -n 1 -r -s -p $'Press enter to continue...\n'

  echo -n $(head template.sh) "root@$ip -p $port" >> $hostname.sh

  echo Script $hostname.sh created!
elif (( k >= i + 1 || k < 0 )); then
  echo 'Invalid number.'
else
  ((k--))
  echo Executing ${filelist[$k]}
  sh $DIR/${filelist[$k]}
fi

exit 0
