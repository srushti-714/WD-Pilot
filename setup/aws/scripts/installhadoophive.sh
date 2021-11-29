#!/bin/bash

cd /home/hdoop
#source .bashrc
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

rm /home/hdoop/apache-hive-3.1.2-bin/lib/guava-19.0.jar
cp /home/hdoop/hadoop-3.2.2/share/hadoop/hdfs/lib/guava-27.0-jre.jar /home/hdoop/apache-hive-3.1.2-bin/lib/
#echo -e 'yes' | ssh localhost
ssh-keyscan -H localhost >> ~/.ssh/known_hosts
#exit
echo -e 'Y' | hdfs namenode -format
/home/hdoop/hadoop-3.2.2/sbin/start-dfs.sh
/home/hdoop/hadoop-3.2.2/sbin/start-yarn.sh

hadoop fs -mkdir /tmp
hadoop fs -mkdir /user
hadoop fs -mkdir /user/hive
hadoop fs -mkdir /user/hive/warehouse
hadoop fs -chmod g+w /tmp
hadoop fs -chmod g+w /user/hive/warehouse
hadoop fs -chmod g+w /


ln -s /usr/share/java/mysql-connector-java.jar /home/hdoop/apache-hive-3.1.2-bin/lib/mysql-connector-java.jar
rm /home/hdoop/apache-hive-3.1.2-bin/lib/guava*
cp /home/hdoop/hadoop-3.2.2/share/hadoop/common/lib/guava* /home/hdoop/apache-hive-3.1.2-bin/lib/

/home/hdoop/hadoop-3.2.2/sbin/stop-dfs.sh
/home/hdoop/hadoop-3.2.2/sbin/stop-yarn.sh

##Install Oozie
cd /home/hdoop
tar -xzf oozie-5.2.1.tar.gz

cd oozie-5.2.1/bin
./mkdistro.sh -DskipTests
cd /home/hdoop/oozie-5.2.1/distro/target/oozie-5.2.1-distro/oozie-5.2.1
mkdir libext
cd libext
wget http://archive.cloudera.com/gplextras/misc/ext-2.2.zip

cd /home/hdoop/hadoop-3.2.2/share/hadoop/common
cp *.jar /home/hdoop/oozie-5.2.1/distro/target/oozie-5.2.1-distro/oozie-5.2.1/libext

cd /home/hdoop/hadoop-3.2.2/share/hadoop/common/lib
cp *.jar /home/hdoop/oozie-5.2.1/distro/target/oozie-5.2.1-distro/oozie-5.2.1/libext

cd /home/hdoop/hadoop-3.2.2/share/hadoop/hdfs
cp *.jar /home/hdoop/oozie-5.2.1/distro/target/oozie-5.2.1-distro/oozie-5.2.1/libext

cd /home/hdoop/hadoop-3.2.2/share/hadoop/hdfs/lib
cp *.jar /home/hdoop/oozie-5.2.1/distro/target/oozie-5.2.1-distro/oozie-5.2.1/libext

cd /home/hdoop/hadoop-3.2.2/share/hadoop/mapreduce
cp *.jar /home/hdoop/oozie-5.2.1/distro/target/oozie-5.2.1-distro/oozie-5.2.1/libext

cd /home/hdoop/hadoop-3.2.2/share/hadoop/mapreduce/lib
cp *.jar /home/hdoop/oozie-5.2.1/distro/target/oozie-5.2.1-distro/oozie-5.2.1/libext

cd /home/hdoop/hadoop-3.2.2/share/hadoop/yarn
cp *.jar /home/hdoop/oozie-5.2.1/distro/target/oozie-5.2.1-distro/oozie-5.2.1/libext

cd /home/hdoop/hadoop-3.2.2/share/hadoop/yarn/lib
cp *.jar /home/hdoop/oozie-5.2.1/distro/target/oozie-5.2.1-distro/oozie-5.2.1/libext

export OOZIE_HOME=/home/hdoop/oozie-5.2.1/distro/target/oozie-5.2.1-distro/oozie-5.2.1

cd /home/hdoop/oozie-5.2.1/distro/target/oozie-5.2.1-distro
mv oozie-5.2.1 /home/hdoop/oozie
cd /home/hdoop/oozie
rm lib/guava-11.0.2.jar
#./bin/oozie-setup.sh


##Install HBase
cd /home/hdoop
tar -xzf hbase-2.4.8-bin.tar.gz
mv hbase-2.4.8 hbase
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /home/hdoop/hbase/conf/hbase-env.sh

## Install Spark
tar xzf spark-3.2.0-bin-hadoop3.2.tgz
mv spark-3.2.0-bin-hadoop3.2 spark

## Install Pig
tar -xzf pig-0.17.0.tar.gz
mv pig-0.17.0 pig

## Start HDFS, Yarn, Hbase, Oozie
/home/hdoop/hadoop-3.2.2/sbin/start-dfs.sh
/home/hdoop/hadoop-3.2.2/sbin/start-yarn.sh
/home/hdoop/hbase/bin/start-hbase.sh
#cd /home/hdoop/oozie
#./bin/oozied.sh start

## Start Hive
cd /home/hdoop/apache-hive-3.1.2-bin
bin/schematool -dbType mysql -initSchema
nohup bin/hiveserver2  > /dev/null 2>&1 &
bin/beeline  jdbc:hive2://localhost:10000;transportMode=http
echo "End"

/home/hdoop/hadoop-3.2.2/sbin/start-dfs.sh
/home/hdoop/hadoop-3.2.2/sbin/start-yarn.sh
nohup /home/hdoop/hbase/bin/hbase thrift start > /dev/null 2>&1 &
