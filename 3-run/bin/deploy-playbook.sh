#!/bin/bash

( [ $# -eq 0 ] || ( [ ! $1 == "staging" ] && [ ! $1 == "production" ] ) )  && { 
echo -e "Usage :\n\t $0 <ENV> [<PLAYBOOK>]" 
echo -e "ENV:\n\t staging | production\n"
echo -e "PLAYBOOK:\n\t a playbook to play, default 'site.yml'\n"
exit 1; 
}

echo "Environment: " $1 


playbook=site.yml

if [ ! -z $2 ] 
then
  playbook=$2
fi

ansible-playbook -i $1 $playbook -u root --private-key=~/.ssh/ansible_key -f 8 
