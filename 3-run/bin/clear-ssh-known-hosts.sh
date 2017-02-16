#!/bin/bash

function clear-known-hosts
{
    while read line; do
        hostname=`awk '{print $1}' <<< $line`
        ssh-keygen -R $hostname
    done < $1
}

# remove hostnames
clear-known-hosts instances.list

# remove ips
clear-known-hosts ips.list

exit 0
