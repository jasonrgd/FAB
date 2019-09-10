# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

require 'yaml'

require File.dirname(__FILE__)+"/scripts/packages"

# @TODO move this to Config File
check_plugins ["vagrant-vbguest", "vagrant-hostsupdater","vagrant-docker-compose","vagrant-proxyconf"]
# exit

Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.

  config.proxy.http = "http://"+@master['vagrant']['proxy']
  config.proxy.https = "https://10.0.2.2:3128"
  config.proxy.no_proxy = "localhost,127.0.0.1"
  config.vm.define @master['vagrant']['name'] do |leader|
    leader.vm.box = @master['vagrant']['box']
    leader.vm.guest = :ubuntu
    leader.vm.network :private_network, ip:  @master['vagrant']['ip']
    leader.vm.hostname = @master['vagrant']['name']
    leader.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
    leader.vm.network "forwarded_port", guest: 443, host: 8443, auto_correct: true
    leader.vm.provision "shell", inline: "touch /etc/environment"
    leader.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 1
    end
    leader.vm.synced_folder "." ,"/vagrant", type: "nfs"
  end

  if @workers.count() > 0
    for worker in @workers
      config.vm.guest = :linux
      config.vm.define worker['vagrant']['name'] do |follower|
        follower.vm.box = worker['vagrant']['box']
        follower.vm.network :private_network, ip:  worker['vagrant']['ip']
        follower.vm.hostname = worker['vagrant']['name']
        follower.vm.provider "virtualbox" do |v|
          v.memory = 2048
          v.cpus = 1
        end
      end
    end
  end
end
