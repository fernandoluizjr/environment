#!/bin/bash

ruby_version="2.3.0"

# Remove ruby packages handled by apt
apt-get purge --yes ruby
apt-get autoremove --yes

if which ruby >/dev/null && [ "$(ruby -v | cut -c6-10)" == $ruby_version ]; then
  echo "Ruby is already installed"
else
# install some dependencies before compile
  apt-get install -y libgdbm-dev libssl-dev libreadline-dev zlib1g-dev

# Download ruby and compile it
  echo "Installing ruby"
  wget -qO /tmp/ruby-2.3.0.tar.gz \
	https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.0.tar.gz
  cd /tmp && gunzip -c /tmp/ruby-2.3.0.tar.gz | tar -xf-
  cd /tmp/ruby-2.3.0 && ./configure && make && make install
  echo "Ruby installed!"
fi

# Install puppet as a ruby gem
if which puppet >/dev/null; then
  echo "Puppet is already installed as a ruby gem"
else
  echo "Installing puppet"
  gem install puppet
  echo "Puppet installed!"
fi

exit 0
