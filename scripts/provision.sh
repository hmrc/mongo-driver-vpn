set -x

apt-get install -y strongswan-starter

mv /tmp/ipsec.conf /etc/ipsec.conf
mv /tmp/ipsec.secrets /etc/ipsec.secrets

ipsec restart

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list
apt-get update
apt-get install -y mongodb-org=3.0.10 mongodb-org-server=3.0.10 mongodb-org-shell=3.0.10 mongodb-org-mongos=3.0.10 mongodb-org-tools=3.0.10

mv /tmp/mongod.conf /etc/mongod.conf

mongod -f /etc/mongod.conf --fork

# install jdk
add-apt-repository -y ppa:webupd8team/java
apt-get update
apt-get -y upgrade
echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
apt-get -y install oracle-java8-installer

# install sbt
echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
apt-get update
apt-get install -y sbt git

java -version

