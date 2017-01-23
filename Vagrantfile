# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # set to false, if you do NOT want to check the correct VirtualBox Guest Additions version when booting this box
  #if defined?(VagrantVbguest::Middleware)
  #  config.vbguest.auto_update = true
  #end

  hosts = {
    'mongo'  => { 'ip_address' => '10.16.0.1', 'ip_address2' => '10.16.30.1'},
    'mongo2' => { 'ip_address' => '10.16.0.2', 'ip_address2' => '10.16.31.1'},
    'mongo3' => { 'ip_address' => '10.16.0.3', 'ip_address2' => '10.16.32.1'},
    }

  hosts.each do |host, host_config|
    config.vm.define host do |node|
      node.vm.box = "ubuntu/trusty64"
      node.vm.hostname = host
      node.vm.network :private_network, ip: host_config['ip_address']
      node.vm.network "private_network", ip: host_config['ip_address2'],
        virtualbox__intnet: host
      node.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--cpus", "2", "--memory", "6144"]
      end
      node.vm.synced_folder "..", "/home/vagrant/workspace"
      node.vm.provision "shell", path: "scripts/provision.sh"
    end
  end
end
