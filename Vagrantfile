#-*- mode: ruby; -*-

@box = ENV['BOX'] || "natty64"
@chef = "172.16.172.16"

unless File.exist? ".chef/validation.pem"
  File.open(".chef/validation.pem", "w") { |f| f.write("") }
end

Vagrant::Config.run do |config|
  config.vm.define "chef.vm" do |n|
    n.vm.box = @box
    n.vm.host_name = "chef.vm"
    n.vm.network @chef
    n.vm.provision :shell, :path => "scripts/chef-server.sh"
    n.vm.provision :shell, :path => "scripts/knife-client.sh"
    n.vm.provision :shell, :path => "scripts/knife-upload.sh"
    n.vm.provision :chef_server do |p|
      p.chef_server_url = "http://#{@chef}:4000"
      p.validation_key_path = ".chef/validation.pem"
      p.log_level = :debug
    end
    n.vm.provision :shell, :path => "scripts/chef-client.sh"
  end
  2.times do |x|
    config.vm.define "node#{x}.vm" do |n|
      n.vm.box = @box
      n.vm.host_name = "node#{x}.vm"
      n.vm.network "#{@chef}#{x}"
      n.vm.provision :shell, :path => "scripts/knife-rsync.sh"
      n.vm.provision :chef_server do |p|
        p.chef_server_url = "http://#{@chef}:4000"
        p.validation_key_path = ".chef/validation.pem"
        p.log_level = :debug
      end
      n.vm.provision :shell, :path => "scripts/chef-client.sh"
    end
  end
end
