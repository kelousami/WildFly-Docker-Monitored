#!/bin/bash

# List of container instances to be created
INPUT_FILE=instances.list

# Current user is able to run as root
sudo whoami > /dev/null

echo
echo "About to create containers for this list "
echo
cat $INPUT_FILE
echo

while read instance; do
 instance_name=`awk '{print $1}' <<< $instance`

 echo "Create and run instance : $instance_name "

 ports=`awk '{print $2}' <<< $instance`
 IFS=";"
 port_list=($ports)
 IFS=" "
 
 echo "Ports to open" 
 printf '%s\n' "${port_list[@]}"

 port_to_open=""
 for ((i=0; i<${#port_list[@]}; i++))
  do
  port=${port_list[$i]}

  if [ $port != 'NA' ]
  then
    # We let Docker choose the port on host machine
    port_to_open+="-p $port "
  fi
 
  done

  nohup sudo docker run --cap-add SYS_ADMIN -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /tmp/$(mktemp -d):/run --name $instance_name --hostname $instance_name $port_to_open devops/typical-arch-1:1.0 > /dev/null 2>&1 &

 # we make sure ip are attributed sequentially
 sleep 3 
done < $INPUT_FILE

echo
echo "List of all containers"
echo
./psAll.sh

echo 
echo "All instances are created successfully"
echo

exit 0
