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

  config.vm.define @master['vagrant']['name'] do |leader|
    leader.vm.box = @master['vagrant']['box']
    leader.vm.network :private_network, ip:  @master['vagrant']['ip']
    leader.vm.hostname = @master['vagrant']['name']
    leader.vm.network "forwarded_port", guest: 80, host: 80, auto_correct: true

    leader.vm.provision "docker" , run: "always" do |d|
      d.run "rancher",
        image: "rancher/rancher",
        restart: "unless-stopped",
        args: "-p 80:80 -p 443:443"
    end
  end

  if @workers.count() > 0
    for worker in @workers
      config.vm.define worker['vagrant']['name'] do |follower|
        follower.vm.box = worker['vagrant']['box']
        follower.vm.network :private_network, ip:  worker['vagrant']['ip']
        follower.vm.hostname = worker['vagrant']['name']
        follower.vm.provision "docker"
      end
    end
  end

  # @TODO move this to Config File
  config.vm.synced_folder "." ,"/vagrant", type: "nfs"



  #config.vm.provision :docker_compose, yml: "/vagrant/docker/docker-compose.yml", run: "always"

end
#sudo docker run -d --privileged --restart=unless-stopped --net=host -v /etc/kubernetes:/etc/kubernetes -v /var/run:/var/run rancher/rancher-agent:v2.0.6 --server http://10.9.4.88 --token lc7m8vjb98k5dmd58htbd8rmqnfclnmhx85bzv6xtddvjhxfmzh4pr --ca-checksum 1d646b30127e6724f54a0b20ea1af18455c1e036d2bd37828674a4b0cd57b843 --worker
