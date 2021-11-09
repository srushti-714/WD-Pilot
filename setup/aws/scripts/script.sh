#!/bin/bash

sudo apt update
sudo apt install openjdk-8-jdk -y
java -version
javac -version
sudo apt install openssh-server openssh-client -y
sudo echo -e 'Password.1!!\nPassword.1!!' | adduser hdoop

cd /home/hdoop
wget https://dlcdn.apache.org/hadoop/common/hadoop-3.2.2/hadoop-3.2.2.tar.gz -P /home/hdoop
wget https://downloads.apache.org/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz -P /home/hdoop

mkdir tmpdata
mkdir /home/hdoop/dfsdata/namenode -p
mkdir /home/hdoop/dfsdata/datanode -p
chown -R hdoop /home/hdoop/tmpdata
chown -R hdoop /home/hdoop/dfsdata
chown -R hdoop /home/hdoop/tmpdata



