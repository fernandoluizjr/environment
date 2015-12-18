#!/bin/bash

# Remove puppet and other gems instaled by vagrant in precise64 box only
if [ -d /opt/vagrant_ruby ]; then
  echo "Removing directory /opt/vagrant_ruby from system and path"
  # TODO: Removing from PATH is not working since vagrant provision put it again
  export PATH=${PATH#/opt/vagrant_ruby/bin:}
  export PATH=${PATH%:/opt/vagrant_ruby/bin}
  rm -rf /opt/vagrant_ruby
fi

if which puppet >/dev/null && [ "$(puppet --version)" == "3.8.4" ]; then
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

# Copy hiera.yaml to avoid warnings
if [ -f /etc/hiera.yaml ] && ! [ -f /etc/puppet/hiera.yaml ]; then
    cp /etc/hiera.yaml /etc/puppet/hiera.yaml
fi

exit 0
