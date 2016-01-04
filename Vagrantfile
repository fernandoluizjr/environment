# -*- mode: ruby -*-
# vi: set ft=ruby :

# README: Vagrant already has ruby and devkit embedded to install plugins,
# but you have to install vagrant in a directory without spaces to work.
# Also in directory vagrant.d include your generated ssh key vagrant.ppk

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.ssh.insert_key = false
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder ".", "/etc/puppetlabs/code/environments", owner: "root", group: "root"

#  config.vm.provision :shell do |s|
#    s.path = "scripts/proxy_settings.sh"
#    s.args = "user password localhost 3128"
#  end

  config.vm.provision "shell", path: "bootstrap.sh"
  config.vm.provision "shell", inline: "bundle install --gemfile /etc/puppetlabs/code/environments/Gemfile", privileged: false
  config.vm.provision "shell", inline: "cd /etc/puppetlabs/code/environments && librarian-puppet install --path librarian/modules"

#  config.vm.define :mon do |mon_config|
#    mon_config.vm.hostname = "monitoring"
#    mon_config.vm.network :private_network, :ip => "192.168.33.10"
#  end

#  config.vm.define :dev do |dev_config|
#    dev_config.vm.hostname = "development"
#    dev_config.vm.network :private_network, :ip => "192.168.33.12"
#    dev_config.vm.provision :shell do |ss|
#      ss.path = "scripts/puppet_environments.sh"
#      ss.args = "/etc/puppetlabs/code/environments development development.pp"
#    end
#  end

  config.vm.define :ci do |ci_config|
    ci_config.vm.hostname = "ci"
    ci_config.vm.network :private_network, :ip => "192.168.33.14"
    ci_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
    end
    ci_config.vm.provision :shell do |ss|
      ss.path = "scripts/puppet_environments.sh"
      ss.args = "/etc/puppetlabs/code/environments loja_virtual ci.pp"
    end
  end

#  config.vm.define :db do |db_config|
#    db_config.vm.hostname = "lojavirtualdb"
#    db_config.vm.network :private_network, :ip => "192.168.33.16"
#    db_config.vm.provision :shell do |ss|
#      ss.path = "scripts/puppet_environments.sh"
#      ss.args = "/etc/puppetlabs/code/environments loja_virtual db.pp"
#    end
#  end

#  config.vm.define :web do |web_config|
#    web_config.vm.hostname = "lojavirtualwebapp"
#    web_config.vm.network :private_network, :ip => "192.168.33.18"
#    web_config.vm.provision :shell do |ss|
#      ss.path = "scripts/puppet_environments.sh"
#      ss.args = "/etc/puppetlabs/code/environments loja_virtual web.pp"
#    end
#  end

end
