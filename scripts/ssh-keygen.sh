#!/bin/bash -ex

# ssh keygen
chown -R vagrant:vagrant ~/.ssh
sudo -u vagrant ssh-keygen -q -N "" -f ~/.ssh/id_rsa
chmod go-rwsx ~/.ssh
rsync -vauc ~/.ssh/ /vagrant/.ssh/
