#!/bin/bash

set -x

vagrant plugin install vagrant-scp

vagrant scp mongo1/ipsec.conf mongo:/tmp/ipsec.conf
vagrant scp mongo2/ipsec.conf mongo2:/tmp/ipsec.conf
vagrant scp mongo3/ipsec.conf mongo3:/tmp/ipsec.conf

# copy secrets
vagrant scp mongo1/ipsec.secrets mongo:/tmp/ipsec.secrets
vagrant scp mongo2/ipsec.secrets mongo2:/tmp/ipsec.secrets
vagrant scp mongo3/ipsec.secrets mongo3:/tmp/ipsec.secrets

# update mongo conf
vagrant scp mongo3/mongod.conf mongo3:/tmp/mongod.conf
vagrant scp mongo2/mongod.conf mongo2:/tmp/mongod.conf
vagrant scp mongo1/mongod.conf mongo:/tmp/mongod.conf

vagrant scp scripts/setupMongoCluster.js mongo:/home/vagrant/setupMongoCluster.js
