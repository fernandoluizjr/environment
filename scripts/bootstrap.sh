#!/bin/bash

ruby_major_version="2.3"
ruby_version="2.3.0"

echo "Removing ruby packages handled by apt"
apt-get purge --yes ruby
apt-get autoremove --yes
echo "Done"

if which ruby >/dev/null && [ "$(ruby -v | cut -c6-10)" == $ruby_version ]; then
  echo "Ruby $ruby_version is already compiled and installed"
else
  echo "Installing some library dependencies needed for compile ruby"
  apt-get install -y libgdbm-dev libssl-dev libreadline-dev zlib1g-dev
  echo "Done"

  echo "Downloading ruby $ruby_version sources"
  wget -qO /tmp/ruby-$ruby_version.tar.gz \
	https://cache.ruby-lang.org/pub/ruby/$ruby_major_version/ruby-$ruby_version.tar.gz
  echo "Done"

  echo "Compiling and installing ruby $ruby_version"
  cd /tmp && gunzip -c /tmp/ruby-$ruby_version.tar.gz | tar -xf-
  cd /tmp/ruby-$ruby_version && ./configure && make && make install
  cd /tmp && rm -f ruby-$ruby_version.tar.gz && rm -rf ruby-$ruby_version
  echo "Ruby $ruby_version installed!"
fi

if which bundler >/dev/null; then
  echo "gem bundler is already installed"
else
  echo "Installing gem bundler"
  gem install bundler
  echo "Done"
fi

exit 0
