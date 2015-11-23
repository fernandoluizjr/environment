# -*- mode: ruby -*-
# vi: set ft=ruby :

# README: Vagrant already has ruby and devkit embedded to install plugins,
# but you have to install vagrant in a directory without espaces to work.
# Also in directory vagrant.d include your generated ssh key vagrant.ppk

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/precise64"
  config.ssh.insert_key = false
  config.vm.synced_folder "../", "/workspace"

#  config.vm.provision :shell do |s|
#    s.path = "scripts/proxy_settings.sh"
#    s.args = "user password localhost 3128"
#  end

  config.vm.provision "shell", path: "scripts/puppet_install.sh"

  config.vm.define :dev do |dev_config|
    dev_config.vm.network :private_network, :ip => "192.168.33.10"
  end

#  config.vm.define :db do |db_config|
#    db_config.vm.network :private_network, :ip => "192.168.33.10"
#  end

#  config.vm.define :web do |web_config|
#    web_config.vm.network :private_network, :ip => "192.168.33.12"
#  end

#  config.vm.define :mon do |mon_config|
#    mon_config.vm.network :private_network, :ip => "192.168.33.14"
#  end

end
