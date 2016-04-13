Some pre-canned commands and files when running a mongo cluster locally, to go with https://gist.github.com/beyond-code-github/0983eb77a5a9913981b9

vagrant plugin install vagrant-scp

#install strongswan-starter
vagrant ssh mongo -- -t 'sudo apt-get install -y strongswan-starter'
vagrant ssh mongo2 -- -t 'sudo apt-get install -y strongswan-starter'
vagrant ssh mongo3 -- -t 'sudo apt-get install -y strongswan-starter'

vagrant scp mongo1/ipsec.conf mongo:/tmp/ipsec.conf && vagrant ssh mongo -- -t 'sudo mv /tmp/ipsec.conf /etc/ipsec.conf'

vagrant scp mongo2/ipsec.conf mongo2:/tmp/ipsec.conf && vagrant ssh mongo2 -- -t 'sudo mv /tmp/ipsec.conf /etc/ipsec.conf'

vagrant scp mongo3/ipsec.conf mongo3:/tmp/ipsec.conf && vagrant ssh mongo3 -- -t 'sudo mv /tmp/ipsec.conf /etc/ipsec.conf'

# copy secrets
vagrant scp mongo1/ipsec.secrets mongo:/tmp/ipsec.secrets && vagrant ssh mongo -- -t 'sudo mv /tmp/ipsec.secrets /etc/ipsec.secrets'

vagrant scp mongo2/ipsec.secrets mongo2:/tmp/ipsec.secrets && vagrant ssh mongo2 -- -t 'sudo mv /tmp/ipsec.secrets /etc/ipsec.secrets'

vagrant scp mongo3/ipsec.secrets mongo3:/tmp/ipsec.secrets && vagrant ssh mongo3 -- -t 'sudo mv /tmp/ipsec.secrets /etc/ipsec.secrets'

# restart boxes
vagrant ssh mongo -- -t 'sudo ipsec restart'
vagrant ssh mongo2 -- -t 'sudo ipsec restart'
vagrant ssh mongo3 -- -t 'sudo ipsec restart'

#install mongo (on each node)
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org=3.0.10 mongodb-org-server=3.0.10 mongodb-org-shell=3.0.10 mongodb-org-mongos=3.0.10 mongodb-org-tools=3.0.10


# update mongo conf
vagrant scp mongo3/mongod.conf mongo3:/tmp/mongod.conf && vagrant ssh mongo3 -- -t 'sudo mv /tmp/mongod.conf /etc/mongod.conf'
vagrant scp mongo2/mongod.conf mongo2:/tmp/mongod.conf && vagrant ssh mongo2 -- -t 'sudo mv /tmp/mongod.conf /etc/mongod.conf'
vagrant scp mongo1/mongod.conf mongo:/tmp/mongod.conf && vagrant ssh mongo -- -t 'sudo mv /tmp/mongod.conf /etc/mongod.conf'

# start mongo
vagrant ssh mongo  -- -t 'sudo mongod -f /etc/mongod.conf --fork'
vagrant ssh mongo2 -- -t 'sudo mongod -f /etc/mongod.conf --fork'
vagrant ssh mongo3 -- -t 'sudo mongod -f /etc/mongod.conf --fork'

# install jdk in arbiter
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
sudo apt-get -y upgrade
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get -y install oracle-java8-installer

# install sbt on arbiter
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
sudo apt-get update
sudo apt-get install -y sbt
