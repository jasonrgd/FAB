# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
require File.dirname(__FILE__)+"/scripts/packages"


# @TODO move this to Config File
check_plugins ["vagrant-vbguest", "vagrant-docker-compose"]


Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  # @TODO move this to Config File
  config.vm.box = "ubuntu/bionic64"

  config.vm.network :private_network, ip: "10.9.4.88"
  config.vm.hostname = "FAB"
  config.vm.network "forwarded_port", guest: 7474, host: 7474

  # @TODO move this to Config File
  config.vm.synced_folder "." ,"/vagrant", type: "nfs"


  config.vm.provision :docker
  config.vm.provision :docker_compose, yml: "/vagrant/docker/docker-compose.yml", run: "always"

end
