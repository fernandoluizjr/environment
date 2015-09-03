#!/bin/bash

apt-get update
wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb -P /tmp
dpkg -i /tmp/puppetlabs-release-precise.deb
apt-get update
apt-get install --yes puppet
puppet resource package puppet ensure=latest
