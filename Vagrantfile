Vagrant.require_version ">= 1.8.0"
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  config.vm.box = "centos/7"
  config.vm.provision "docker"
  config.vm.network :forwarded_port, guest: 22, host: 2223, id: 'ssh'

end



