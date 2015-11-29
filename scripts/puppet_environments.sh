#!/bin/bash

directory_environments=$1
active_node_environment=$2

# Enable directory environments
grep -q "environmentpath=" /etc/puppet/puppet.conf
if [ $? -eq 0 ]; then
    sed -i '/environmentpath=/c\environmentpath='"$directory_environments" /etc/puppet/puppet.conf
else
    sed -i 's|\[main\]|&\nenvironmentpath='"$directory_environments"'|' /etc/puppet/puppet.conf
fi

# Setting the environment to node
grep -q "environment=" /etc/puppet/puppet.conf
if [ $? -eq 0 ]; then
    sed -i '/environment=/c\environment='"$active_node_environment" /etc/puppet/puppet.conf
else
    sed -i 's|\[main\]|&\nenvironment='"$active_node_environment"'|' /etc/puppet/puppet.conf
fi
