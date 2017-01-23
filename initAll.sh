#!/bin/bash

set -x

START_TIME=`date`

vagrant up --no-provision

./scripts/initHost.sh

vagrant provision mongo3 > backgroundTask3.out &

vagrant provision mongo2 > backgroundTask2.out &

# last one completes ussually as the last one.
vagrant provision mongo

# during provision everything is done as root. Created dirs should be owned by user.
vagrant ssh mongo -- -t 'sbt version'

vagrant ssh mongo -- -t 'mongo 10.16.30.1 setupMongoCluster.js'

END_TIME=`date`

echo $START_TIME
echo $END_TIME
