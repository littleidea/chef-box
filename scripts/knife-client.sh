#!/bin/bash -ex

# knife
if [ ! -f /home/vagrant/.chef/knife.rb ]; then
    usermod -a -G chef vagrant
    chmod g+r /etc/chef/{validation,webui}.pem
    sudo -u vagrant knife configure -i -n -r /home/vagrant --defaults
    echo '
dir = File.dirname(__FILE__)
log_level :debug
log_location STDOUT
node_name "vagrant"
client_key "#{dir}/vagrant.pem"
chef_server_url "http://172.16.172.16:4000"
cache_type "BasicFile"
cache_options :path => "#{dir}/checksums"
cookbook_path ["#{dir}/../cookbooks", "/vagrant/cookbooks"]
' | sudo -u vagrant tee /home/vagrant/.chef/knife.rb
    chmod -R o-rwx /home/vagrant/.chef
    rsync -vac /home/vagrant/.chef/ /etc/chef/validation.pem /vagrant/.chef/
fi
