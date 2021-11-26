#!/bin/bash

export HADOOP_HOME=/home/hdoop/hadoop-3.2.2
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
export HIVE_HOME="/home/hdoop/apache-hive-3.1.2-bin"
export PATH=$PATH:$HIVE_HOME/bin
export OOZIE_HOME=/home/hdoop/oozie-5.2.1/distro/target/oozie-5.2.1-distro/oozie-5.2.1
export HBASE_HOME=/home/hdoop/hbase
export PATH=$PATH:$HBASE_HOME/bin
export SPARK_HOME=/home/hdoop/spark
export PIG_HOME=/home/hdoop/pig
export PATH=$PATH:$PIG_HOME/bin
export PIG_CLASSPATH=$HADOOP_HOME/etc/hadoop
export HBASE_DISABLE_HADOOP_CLASSPATH_LOOKUP=true

cd
mkdir tmp
cd tmp
# Update the package and repos
sudo apt update -y
# Install the dependencies 
sudo apt install ant gcc g++ libkrb5-dev *libmysqlclient-dev libssl-dev libsasl2-dev libsasl2-modules-gssapi-mit libsqlite3-dev libtidy*dev libxml2-dev libxslt-dev maven libldap2-dev python-dev python-setuptools git -y
sudo apt update -y
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install -y yarn
sudo apt-get install -y nodejs
sudo apt update -y
npm install --global npm
apt install python3-pip
pip install python-snappy

# Create a user hue
sudo echo -e 'Password.1!!\nPassword.1!!' | adduser hue

# Clone the dependent files for Hue


cd /usr/share/
git clone https://github.com/cloudera/hue.git
chown -R hue:hdoop /usr/share/hue
cd hue
sudo apt update
sudo apt install make
git cherry-pick 7a9100d4a7f38eaef7bd4bd7c715ac1f24a969a8
git cherry-pick e67c1105b85b815346758ef1b9cd714dd91d7ea3
git clean -fdx
make install 2> /home/ubuntu/tmplog005.txt
#rm /usr/share/hue/desktop/conf/pseudo-distributed.ini
#wget -P /usr/share/hue/desktop/conf/ -O pseudo-distributed.ini https://raw.githubusercontent.com/CloudLabs-Samples/WD-Pilot/dev/setup/aws/files/pseudo-distributed.ini

chown -R hue:hdoop /usr/share/hue
cd /usr/share/hue
make apps 2> /home/ubuntu/tmplog006.txt

 sed -i 's/## webhdfs_url=http:/webhdfs_url=http:/' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i 's/localhost:50070/localhost:9870/' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i 's/## default_hdfs_superuser=hdfs/default_hdfs_superuser=hdoop/' /usr/share/hue/desktop/conf/pseudo-distributed.ini
# sed -i 's///' /usr/share/hue/desktop/conf/pseudo-distributed.ini
sed -i 's/## name=mysqldb/[[[mysql]]]\nnice_name=mysqldb\nname=hue\nengine=mysql\nhost=127.0.0.1\nport=3306\nuser=admin\npassword=securepass/' /usr/share/hue/desktop/conf/pseudo-distributed.ini

 sed -i 's/secret_key=/secret_key=122334fgasd/' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '1370 c\
    use_sasl=true' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '671 c\
    host=127.0.0.1' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '672 c\
    engine=mysql' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '673 c\
    port=3306' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '674 c\
    user=admin' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '675 c\
    password=securepass' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '681 c\
    name=hue' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '1267 c\
    hive_server_host=127.0.0.1' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '1270 c\
    hive_server_port=10000' /usr/share/hue/desktop/conf/pseudo-distributed.ini 
 sed -i '1648 c\
    solr_url=http://127.0.0.1:8983/solr/' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '1393 c\
    enable_new_create_table=true' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '1320 c\
    hive_conf_dir=/home/hdoop/apache-hive-3.1.2-bin/conf' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '966 c\
   [[[mysql]]]' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '967 c\
    name=MySQL' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '968 c\
    interface=sqlalchemy' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '969 c\
    engine=mysql' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '970 c\
    options={"url": "mysql://admin:securepass@127.0.0.1:3306/hue"}' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '1366 c\
    auth_username=admin' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '1367 c\
    auth_password=securepass' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '1625 c\
    hbase_clusters=(Cluster|127.0.0.1:9090)' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '1628 c\
    hbase_conf_dir=/home/hdoop/hbase/conf' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '973 c\
    [[[hive]]]' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '974 c\
    name=Hive' /usr/share/hue/desktop/conf/pseudo-distributed.ini
 sed -i '975 c\
    interface=hiveserver2' /usr/share/hue/desktop/conf/pseudo-distributed.ini


