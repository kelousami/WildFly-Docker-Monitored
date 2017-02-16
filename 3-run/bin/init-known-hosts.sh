#!/bin/bash

function init-known-hosts
{
    while read line; do
        hostname=`awk '{print $1}' <<< $line`
        ssh-keyscan -t ecdsa $hostname >> ~/.ssh/known_hosts
    done < $1
}

# using hostnames
init-known-hosts instances.list

# using ips
init-known-hosts ips.list

exit 0
