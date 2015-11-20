# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/precise64"
  config.ssh.insert_key = false
  config.vm.synced_folder "../", "/workspace"

#  config.vm.define :db do |db_config|
#    db_config.vm.network :private_network, :ip => "192.168.33.10"
#    db_config.vm.provision "puppet" do |puppet|
#      puppet.module_path = "modules"
#      puppet.manifest_file = "db.pp"
#    end
#  end

  config.vm.define :web do |web_config|
    web_config.vm.network :private_network, :ip => "192.168.33.12"
    web_config.vm.provision "puppet" do |puppet|
      puppet.module_path = "modules"
      puppet.manifest_file = "web.pp"
    end
  end

#  config.vm.define :mon do |mon_config|
#    mon_config.vm.network :private_network, :ip => "192.168.33.14"
#  end

  config.vm.provision :shell do |s|
    s.path = "scripts/proxy_settings.sh"
    #s.args = "u100218 Epopeia0 proxy.corp.valepresente.local 3128"
  end

  config.vm.provision "shell", path: "scripts/puppet_install.sh"
end
