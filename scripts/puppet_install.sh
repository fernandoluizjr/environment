#!/bin/bash

# Remove puppet e outras gemas ruby instaladas pelo vagrant
if [ -d /opt/vagrant_ruby ]; then
  echo "Removing directory /opt/vagrant_ruby from system and PATH"
  PATH=${PATH#/opt/vagrant_ruby/bin:}
  PATH=${PATH%:/opt/vagrant_ruby/bin}
  rm -rf /opt/vagrant_ruby
fi

if which puppet >/dev/null ; then
  echo "Puppet is already installed"
  exit 0
fi

apt-get update
wget -qO /tmp/puppetlabs-release-precise.deb \
	https://apt.puppetlabs.com/puppetlabs-release-precise.deb
dpkg -i /tmp/puppetlabs-release-precise.deb
rm /tmp/puppetlabs-release-precise.deb
apt-get update
echo "Installing puppet"
apt-get install --yes puppet
echo "Puppet installed!"

exit 0
