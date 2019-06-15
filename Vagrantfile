# Copyright 2019 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2019-06-14

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/bionic64"
  config.ssh.insert_key = false
  config.vm.provision "ansible" do |ansible|
    ansible.compatibility_mode = "2.0"
    ansible.host_key_checking = false
    ansible.playbook = "ansible/playbook.yml"
    ansible.verbose = "v"
  end
end
