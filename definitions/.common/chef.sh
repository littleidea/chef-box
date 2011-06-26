#!/bin/bash -ex

# Java
perl -p -i -e 's/^\# (.*partner)$/$1/g' /etc/apt/sources.list
apt-get update
echo "
sun-java6-bin shared/accepted-sun-dlj-v1-1 boolean true
sun-java6-bin shared/present-sun-dlj-v1-1 note
sun-java6-jdk shared/accepted-sun-dlj-v1-1 boolean true
sun-java6-jdk shared/present-sun-dlj-v1-1 note
sun-java6-jre shared/accepted-sun-dlj-v1-1 boolean true
sun-java6-jre shared/present-sun-dlj-v1-1 note
sun-java6-jre sun-java6-jre/jcepolicy note
sun-java6-jre sun-java6-jre/stopthread boolean true
" | debconf-set-selections
apt-get -y install sun-java6-jdk

# RabbitMQ
echo "rabbitmq-server rabbitmq-server/upgrade_previous note" |\
    debconf-set-selections

# Chef
echo "deb http://apt.opscode.com/ `lsb_release -cs`-0.10 main" |\
    tee /etc/apt/sources.list.d/opscode.list
wget -O - http://apt.opscode.com/packages@opscode.com.gpg.key |\
    apt-key add -
apt-get update
echo "
chef chef/chef_server_url string http://127.0.0.1:4000
chef-server-webui chef-server-webui/admin_password string ub3rs3kr4t
chef-solr chef-solr/amqp_password string ub3rs3kr4t
" | debconf-set-selections
apt-get -y install chef-server

# Cleanup
for x in chef-client chef-server-webui chef-server chef-expander chef-solr \
    rabbitmq-server couchdb ; do
    update-rc.d -f $x remove &
    invoke-rc.d $x stop &
    wait
done
chown -R chef:chef /etc/chef /var/lib/chef /var/log/chef
chown -R rabbitmq:rabbitmq /etc/rabbitmq /var/lib/rabbitmq /var/log/rabbitmq
chown -R couchdb:couchdb /etc/couchdb /var/lib/couchdb /var/log/couchdb
rm -rf /etc/chef/client.pem /var/lib/rabbitmq/* /var/lib/couchdb/*
