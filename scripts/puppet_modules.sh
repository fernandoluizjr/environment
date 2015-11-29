#!/bin/bash

module_name=$1

#Install adicional modules from puppet forge
puppet module install -i /etc/puppet/modules $module_name
