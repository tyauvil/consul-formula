# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.network "forwarded_port", guest: 8400, host: 8400
  config.vm.network "forwarded_port", guest: 8500, host: 8500
  config.vm.network "forwarded_port", guest: 8600, host: 8600
  config.vm.box = "ubuntu/xenial64"
  config.vm.provision :saltdeps do |deps|
    deps.base_vagrantfile = "git@github.com:Ubiquiti-Cloud/salt-vagrant-base.git"
    deps.checkout_path =  "./.vagrant-salt/deps"
  end
end
