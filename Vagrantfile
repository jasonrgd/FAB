# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

require 'yaml'

require File.dirname(__FILE__)+"/scripts/packages"

# @TODO move this to Config File
check_plugins ["vagrant-vbguest", "vagrant-docker-compose"]
# exit

Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = @master['vagrant']['box']

  # @TODO move this to Config File
  config.vm.network :private_network, ip: "10.9.4.88"
  config.vm.hostname = "FAB"
  config.vm.network "forwarded_port", guest: 80, host: 80, auto_correct: true

  # @TODO move this to Config File
  config.vm.synced_folder "." ,"/vagrant", type: "nfs"


  config.vm.provision "docker" , run: "always" do |d|
    d.run "rancher",
      image: "rancher/rancher",
      restart: "unless-stopped",
      args: "-p 80:80 -p 443:443"
  end
  #config.vm.provision :docker_compose, yml: "/vagrant/docker/docker-compose.yml", run: "always"

end
#sudo docker run -d --privileged --restart=unless-stopped --net=host -v /etc/kubernetes:/etc/kubernetes -v /var/run:/var/run rancher/rancher-agent:v2.0.6 --server https://10.9.4.88 --token cwjzw7582mzd4fs2t64ht59dccljdxcc96fvzdsqpjm9hwggwhlsb8 --ca-checksum 97f9a3cca00e1a539a84c396ad49ed550b4c9f50bb977e2d2b3e6aef009c9641 --worker
