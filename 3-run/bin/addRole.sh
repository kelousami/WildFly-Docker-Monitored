#!/bin/bash

( [ $# -eq 0 ] )  && { 
echo -e "Usage :\n\t $0 <role_name>" 
echo -e "role_name:\n\t the role name for which to create folders/files structure.\n"
exit 1; 
}

cmd=$0
role=$1
chemin=`pwd`

echo "pwd - $chemin"
echo "role - $role"
echo "cmd - $cmd"

touch $role.yml
mkdir roles/$role

tasks=roles/$role/tasks
vars=roles/$role/vars
files=roles/$role/files

mkdir $tasks $vars $files

touch $tasks/install.yml
touch $tasks/configure.yml
touch $tasks/start.yml
touch $tasks/deploy.yml
touch $tasks/main.yml

touch $vars/main.yml

cd roles/$role
tree

exit 0
