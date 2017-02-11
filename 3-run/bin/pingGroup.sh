#!/bin/bash

[ $# -eq 0 ] && { 
echo "Usage : $0 server-group-name"; 
echo "Available groups:"
cat /etc/ansible/hosts | grep "\["
exit 1; 
}

ansible $1 -m ping -u root --private-key=~/.ssh/ansible_key

