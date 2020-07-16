# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "generic/ubuntu1804"
  config.vm.network :public_network
  config.vm.synced_folder "./data", "/synced_data"
  config.vm.provider :virtualbox do |vb|
    vb.gui = true
    vb.customize [
	  "modifyvm", :id,
	  "--memory", "4096",
	  "--cpus", "2",
      "--vram", "256"
	  ]
  end

  config.vm.provision :shell, :path => "bootstrap.sh"

end
