#!/bin/bash

# Remove puppet e other gems instaled by vagrant
if [ -d /opt/vagrant_ruby ]; then
  echo "Removing directory /opt/vagrant_ruby from system and path"
  PATH=${PATH#/opt/vagrant_ruby/bin:}
  PATH=${PATH%:/opt/vagrant_ruby/bin}
  rm -rf /opt/vagrant_ruby
fi

if which puppet >/dev/null ; then
  echo "Puppet is already installed"
else
  apt-get update
  wget -qO /tmp/puppetlabs-release-precise.deb \
	https://apt.puppetlabs.com/puppetlabs-release-precise.deb
  dpkg -i /tmp/puppetlabs-release-precise.deb
  rm /tmp/puppetlabs-release-precise.deb
  apt-get update
  echo "Installing puppet"
  apt-get install --yes puppet
  echo "Puppet installed!"
fi

# Remove some variables deprecated to avoid warnings
grep -q "templatedir" /etc/puppet/puppet.conf
if [ $? -eq 0 ]; then
    sed -i '/templatedir/d' /etc/puppet/puppet.conf
fi

exit 0
