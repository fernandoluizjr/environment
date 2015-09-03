Vagrant.configure(2) do |config|
  config.vm.box = "hashicorp/precise64"
  config.ssh.insert_key = false
  config.vm.synced_folder "../", "/workspace"

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
    sudo dpkg -i puppetlabs-release-precise.deb
    sudo apt-get update
    sudo apt-get install --yes puppet
    sudo puppet resource package puppet ensure=latest
  SHELL
end
