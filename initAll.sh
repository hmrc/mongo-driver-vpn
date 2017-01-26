#!/bin/bash

set -x

START_TIME=`date`

vagrant up --no-provision

./scripts/initHost.sh

vagrant provision mongo > backgroundTask.out &
vagrant provision mongo2
vagrant provision mongo3 > backgroundTask2.out &

# during provision everything is done as root. Created dirs should be owned by user. That is why not all stuff is in the provision script.
vagrant ssh mongo2 -- -t 'git clone https://github.com/hmrc/mongo-driver-vpn.git'

vagrant ssh mongo2 -- -t 'cd mongo-driver-vpn; sbt compile'

vagrant ssh mongo -- -t 'mongo 10.16.30.1 setupMongoCluster.js'

END_TIME=`date`

echo Start time: $START_TIME
echo End time: $END_TIME
