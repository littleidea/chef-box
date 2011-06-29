#!/bin/bash -eux

# ssh rsync
rsync -vac /vagrant/.ssh/ /home/vagrant/.ssh/
chown -R vagrant:vagrant /home/vagrant/.ssh
chmod -R go-rwsx /home/vagrant/.ssh
