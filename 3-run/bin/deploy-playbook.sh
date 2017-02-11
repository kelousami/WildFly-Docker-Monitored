#!/bin/bash

( [ $# -eq 0 ] || ( [ ! $1 == "staging" ] && [ ! $1 == "production" ] ) )  && { 
echo -e "Usage :\n\t $0 <ENV>" 
echo -e "ENV:\n\t staging | production\n"
exit 1; 
}

echo "Environment: " $1 

ansible-playbook -i $1 site.yml -u root --private-key=~/.ssh/ansible_key -f 8 
