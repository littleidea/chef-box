#!/bin/bash -ex

# knife
if [ ! -f ~/.chef/knife.rb ]; then
    usermod -a -G chef vagrant
    chmod g+r /etc/chef/{validation,webui}.pem
    sudo -u vagrant knife configure -i -n -r ~ --defaults
    echo '
dir = File.dirname(__FILE__)
log_level :debug
log_location STDOUT
node_name "vagrant"
client_key "#{dir}/vagrant.pem"
chef_server_url "http://172.16.172.16:4000"
cache_type "BasicFile"
cache_options :path => "#{dir}/checksums"
cookbook_path ["#{dir}/../cookbooks", "/vagrant"]
' | sudo -u vagrant tee ~/.chef/knife.rb
    rsync -r ~/.chef/ /etc/chef/validation.pem /vagrant/.chef/
fi

exit 0
