#!/bin/bash

module_name=$1
globalmodulepath=/opt/puppetlabs/puppet/modules

# Install adicional modules from puppet forge
puppet module install -i $globalmodulepath $module_name
