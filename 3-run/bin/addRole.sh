#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# ----------------------------------------------------------------------------
# Global constnats 
# ----------------------------------------------------------------------------

cmd=$0
role=$1
chemin=`pwd`

echo "pwd - $chemin"
echo "role - $role"
echo "cmd - $cmd"
echo 

# ----------------------------------------------------------------------------
# Functions 
# ----------------------------------------------------------------------------

usage() {
    # TODO use heredoc
    echo -e "Usage :\n\t $0 <role_name> [<template_name>]" 
    echo -e "role_name:\n\t the role name for which to create folders/files \
structure.\n"
    echo -e "template_name: \n\t (optional) a valid and existing role from \
which the new role will be based (copy)"
    echo
    exit 1;

} # end of usage 

create_empty_structure() {
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

} # enf of create_empty_structure

check_template() {
    template=$1
    echo "Checking template $template"

    if [ -f "$template".yml ] && [ -d roles/"$template" ]; then
        echo "Template $template is valid"
        return 0
    else
        # tabs 1
        echo "Template $template is not valid, thus creating role with empty \
yml files"
        # tabs 4
        return 1
    fi
    
} # end of check_empty

create_structure_from_template() {
    template=$1
    
    cp "$template".yml "$role".yml
    sed -i 's/'$template'/'$role'/g' "$role".yml

    cp -R roles/"$template" roles/"$role" 
    find roles/"$role" -type f -exec sed -i 's/'$template'/'$role'/g' {} +

} # end of create_structure_from_template

display_created_role_tree() {
    tree roles/$role

} # end of display_created_role_tree


# ----------------------------------------------------------------------------
# Main function
# ----------------------------------------------------------------------------

main() {
    if [ $# -eq 0 ]; then 
        usage 
    fi

    if [ ! -z "$2" ]  && check_template "$2" ; then
        create_structure_from_template "$2"
    else
        create_empty_structure
    fi

    display_created_role_tree
} # end of main 


main "$@"

exit 0
