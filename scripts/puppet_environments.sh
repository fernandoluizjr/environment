#!/bin/bash

confdir=/etc/puppetlabs/puppet
puppet_conf=$confdir/puppet.conf
external_environments_dir=$1
active_node_environment=$2
manifest_file=$external_environments_dir/$active_node_environment/manifests/$3
base_module_path="$external_environments_dir/librarian/modules:$external_environments_dir/modules:/etc/puppetlabs/code/modules:/opt/puppetlabs/puppet/modules"

# create confdir directory
if [ ! -d $confdir ]; then
    mkdir -p $confdir
fi

# create puppet_conf file
if [ ! -f $puppet_conf ]; then
    touch $puppet_conf
fi

# create main section in puppet_conf file
grep -q "\[main\]" $puppet_conf
if ! [ $? -eq 0 ]; then
    echo "[main]" > $puppet_conf
fi

# Enable directory environments
grep -q "environmentpath=" $puppet_conf
if [ $? -eq 0 ]; then
    sed -i '/environmentpath=/c\environmentpath='"${external_environments_dir}" $puppet_conf
else
    sed -i 's|\[main\]|&\nenvironmentpath='"${external_environments_dir}"'|' $puppet_conf
fi

# Setting the environment to node
grep -q "environment=" $puppet_conf
if [ $? -eq 0 ]; then
    sed -i '/environment=/c\environment='"$active_node_environment" $puppet_conf
else
    sed -i 's|\[main\]|&\nenvironment='"$active_node_environment"'|' $puppet_conf
fi

# Echo the basemodulepath variable
puppet config print basemodulepath

# Setting the basemodulepath to global modules for all environments
grep -q "basemodulepath=" $puppet_conf
if [ $? -eq 0 ]; then
    sed -i '/basemodulepath=/c\basemodulepath='"$base_module_path" $puppet_conf
else
    sed -i 's|\[main\]|&\nbasemodulepath='"$base_module_path"'|' $puppet_conf
fi

# Echo the basemodulepath variable
puppet config print basemodulepath

# Apply puppet manifest
puppet apply $manifest_file
