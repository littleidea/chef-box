#!/bin/bash -ex

# ssh keygen
chown -R vagrant:vagrant ~/.ssh
sudo -u vagrant ssh-keygen -q -N "" -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod go-rwsx ~/.ssh
rsync -vauc ~/.ssh/ /vagrant/.ssh/
