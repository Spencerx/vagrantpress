# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "precise64"
  config.vm.box_url = "https://oss-binaries.phusionpassenger.com/vagrant/boxes/ubuntu-12.04.3-amd64-vmwarefusion.box"

  config.vm.hostname = "vagrantpress"
  config.dns.tld = "wpdev"
  config.dns.patterns = [/^.*\.wpdev$/]

  config.vm.network :private_network, ip: "172.16.23.16"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = "puppet/modules"
    puppet.manifest_file  = "init.pp"
    puppet.options="--verbose --debug"
  end

  # This is a temporary workaround for Vagrant bug #2756
  #
  #   https://github.com/mitchellh/vagrant/issues/2756
  #
  # Hopefully this can be removed once Vagrant >= 1.4.4 is out.
  VagrantDNS::Config.auto_run = false
end
