#!/bin/bash

module_name=$1

# TODO: Substituir /etc/puppet/modules por $confdir/modules
# Install adicional modules from puppet forge
puppet module install -i /etc/puppet/modules $module_name
