#!/bin/bash

sudo apt update
sudo apt install openjdk-8-jdk -y
sudo apt install unzip -y
java -version
javac -version
sudo apt install openssh-server openssh-client -y
sudo echo -e 'Password.1!!\nPassword.1!!' | adduser hdoop

cd /home/hdoop
wget https://dlcdn.apache.org/hadoop/common/hadoop-3.2.2/hadoop-3.2.2.tar.gz -P /home/hdoop
wget https://downloads.apache.org/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz -P /home/hdoop
wget https://downloads.apache.org/hbase/2.4.9/hbase-2.4.9-bin.tar.gz -P /home/hdoop
wget https://downloads.apache.org/oozie/5.2.1/oozie-5.2.1.tar.gz -P /home/hdoop
wget https://downloads.apache.org/spark/spark-3.2.0/spark-3.2.0-bin-hadoop3.2.tgz -P /home/hdoop
wget  https://downloads.apache.org/pig/pig-0.17.0/pig-0.17.0.tar.gz -P /home/hdoop

mkdir tmpdata
mkdir /home/hdoop/dfsdata/namenode -p
mkdir /home/hdoop/dfsdata/datanode -p
chown -R hdoop /home/hdoop/tmpdata
chown -R hdoop /home/hdoop/dfsdata
chown -R hdoop /home/hdoop/tmpdata

## Installing and Configuring MySQL

sudo apt-get install mysql-server   -y
sudo service mysql start
sudo echo -e 'N\nsecurepass\nsecurepass\nN\nN\nN\nY' | /usr/bin/mysql_secure_installation

mysql -u root -psecurepass <<EOF
CREATE DATABASE hue DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE USER 'admin'@'%' IDENTIFIED BY 'securepass';
GRANT ALL ON hue.* TO 'hue'@'%' IDENTIFIED BY 'securepass';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'hue'@'%';
FLUSH PRIVILEGES;
EOF

wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java_8.0.27-1ubuntu18.04_all.deb
sudo dpkg -i mysql-connector-java_8.0.27-1ubuntu18.04_all.deb
cp /usr/share/java/mysql-connector-java-8.0.27.jar /usr/share/java/mysql-connector-java.jar
