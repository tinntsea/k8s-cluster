# -*- mode: ruby -*-
# vi: set ft=ruby :

private_key_path = File.join(Dir.home, ".ssh", "id_rsa")
public_key_path = File.join(Dir.home, ".ssh", "id_rsa.pub")
insecure_key_path = File.join(Dir.home, ".vagrant.d", "insecure_private_key")

private_key = IO.read(private_key_path)
public_key = IO.read(public_key_path)

Vagrant.configure("2") do |config|
  config.vm.box_check_update = false
  config.vm.provision :shell, :inline => <<-SCRIPT
    set -e
    apt-get update && apt-get install -y swapspace

    echo '#{private_key}' > /home/vagrant/.ssh/id_rsa
    chmod 600 /home/vagrant/.ssh/id_rsa

    echo '#{public_key}' > /home/vagrant/.ssh/authorized_keys
    chmod 600 /home/vagrant/.ssh/authorized_keys

    # kubelet requires swap off
    swapoff -a

    # keep swap off after reboot
    sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
  SCRIPT

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
    v.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
  end

  config.vm.define "master" do |master|
    master.vm.box = "debian/stretch64"
    # master.vm.network "public_network", type: "dhcp", bridge: "en0: Wi-Fi (AirPort)"
    master.vm.network "private_network", ip: "10.1.100.100", :netmask => "255.255.0.0"
    master.vm.hostname = "master"

    master.ssh.insert_key = false
    master.ssh.keys_only = false
    master.ssh.forward_agent = true
    master.ssh.guest_port = 22
    master.ssh.private_key_path = [private_key_path,insecure_key_path]
  end

  config.vm.define "worker1" do |worker1|
    worker1.vm.box = "debian/stretch64"
    # worker1.vm.network "public_network", type: "dhcp", bridge: "en0: Wi-Fi (AirPort)"
    worker1.vm.network "private_network", ip: "10.1.100.101", :netmask => "255.255.0.0"
    worker1.vm.hostname = "worker1"

    worker1.ssh.insert_key = false
    worker1.ssh.keys_only = false
    worker1.ssh.forward_agent = true
    worker1.ssh.guest_port = 22
    worker1.ssh.private_key_path = [private_key_path,insecure_key_path]
  end

  config.vm.define "worker2" do |worker2|
    worker2.vm.box = "debian/stretch64"
    # worker2.vm.network "public_network", type: "dhcp", bridge: "en0: Wi-Fi (AirPort)"
    worker2.vm.network "private_network", ip: "10.1.100.102", :netmask => "255.255.0.0"
    worker2.vm.hostname = "worker2"

    worker2.ssh.insert_key = false
    worker2.ssh.keys_only = false
    worker2.ssh.forward_agent = true
    worker2.ssh.guest_port = 22
    worker2.ssh.private_key_path = [private_key_path,insecure_key_path]
  end
end
