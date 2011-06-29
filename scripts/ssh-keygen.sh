#!/bin/bash -eux

# ssh keygen
if [ ! -f /home/vagrant/.ssh/id_rsa ]; then
    chown -R vagrant:vagrant /home/vagrant/.ssh
    sudo -u vagrant ssh-keygen -q -N "" -f /home/vagrant/.ssh/id_rsa
    cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
    chmod go-rwsx /home/vagrant/.ssh
    rsync -vauc /home/vagrant/.ssh/ /vagrant/.ssh/
fi
