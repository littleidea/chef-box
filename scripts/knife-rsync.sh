#!/bin/bash -ex

# knife rsync
rsync -vac /vagrant/.chef/ /home/vagrant/.chef/
chown -R vagrant:vagrant /home/vagrant/.chef
chmod -R go-rwsx /home/vagrant/.chef
