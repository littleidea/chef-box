#!/bin/bash -ex

# ssh rsync
chown -R vagrant:vagrant ~/.ssh
sudo -u vagrant rsync -vauc /vagrant/.ssh/ ~/.ssh/
