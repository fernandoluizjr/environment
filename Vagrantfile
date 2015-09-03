# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "hashicorp/precise64"
  config.ssh.insert_key = false
  config.vm.synced_folder "../", "/workspace"

  config.vm.provision :shell do |s|
    s.path = "scripts/proxy_settings.sh"
    s.args = ""
    #s.args = "u100218 Epopeia0 proxy.corp.valepresente.local 3128"
  end

  config.vm.provision "shell", path: "scripts/puppet_install.sh"
end
