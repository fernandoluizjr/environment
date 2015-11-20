#!/bin/bash

#set -e -x

# Garantir que a versao suporte config de proxy
#if which puppet > /dev/null : them
#  echo "Puppet is already installed"
#  exit 0
#fi

apt-get update
wget -qO /tmp/puppetlabs-release-precise.deb https://apt.puppetlabs.com/puppetlabs-release-precise.deb
dpkg -i /tmp/puppetlabs-release-precise.deb
rm /tmp/puppetlabs-release-precise.deb
apt-get update
echo "Installing puppet"
apt-get install --yes puppet
#puppet resource package puppet ensure=latest
echo "Puppet installed!"

exit 0
