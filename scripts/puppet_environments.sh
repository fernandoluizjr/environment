#!/bin/bash

directory_environments=$1
active_node_environment=$2
manifest_file=$directory_environments/$active_node_environment/manifests/$3
base_module_path=\$confdir/modules:$directory_environments/modules

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

# Setting the basemodulepath to global modules for all environments
grep -q "basemodulepath=" /etc/puppet/puppet.conf
if [ $? -eq 0 ]; then
    sed -i '/basemodulepath=/c\basemodulepath='"$base_module_path" /etc/puppet/puppet.conf
else
    sed -i 's|\[main\]|&\nbasemodulepath='"$base_module_path"'|' /etc/puppet/puppet.conf
fi

# Apply puppet manifest
puppet apply $manifest_file
