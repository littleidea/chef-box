#-*- mode: ruby; -*-

@box = ENV['BOX'] || "natty64"

def ipaddress(n=16) ; "172.16.172.#{n}" ; end

def config(n, ip, &block)
  n.vm.box = @box
  n.vm.network ip
  n.vm.provision :chef_server do |p|
    p.chef_server_url = "http://#{ipaddress}:4000"
    p.validation_key_path = ".chef/validation.pem"
    p.log_level = :debug
    p.json.merge!({ :ip => ip })
    yield p if block
  end
  n.vm.provision :shell, :path => "scripts/chef-client.sh"
  n.vm.provision :shell, :path => "scripts/knife-rsync.sh"
  n.vm.provision :shell, :path => "scripts/ssh-rsync.sh"
end

Vagrant::Config.run do |config|
  config.vm.define "chef.vm" do |n|
    n.vm.host_name = "chef.vm"
    n.vm.provision :shell, :path => "scripts/chef-server.sh"
    n.vm.provision :shell, :path => "scripts/knife-client.sh"
    n.vm.provision :shell, :path => "scripts/knife-upload.sh"
    n.vm.provision :shell, :path => "scripts/ssh-keygen.sh"
    config n, ipaddress
  end
  2.times do |x|
    config.vm.define "node#{x}.vm" do |n|
      n.vm.host_name = "node#{x}.vm"
      config n, ipaddress(x+20)
    end
  end
end

unless File.exist? ".chef/validation.pem"
  File.open(".chef/validation.pem", "w") { |f| f.write("") }
end
