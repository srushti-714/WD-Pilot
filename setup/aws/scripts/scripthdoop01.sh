#!/bin/bash

cd /home/hdoop
tar xzf hadoop-3.2.2.tar.gz

ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

echo ' 
#Hadoop Related Options
export HADOOP_HOME=/home/hdoop/hadoop-3.2.2
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
' >> /home/hdoop/.bashrc


source /home/hdoop/.bashrc

echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /home/hdoop/hadoop-3.2.2/etc/hadoop/hadoop-env.sh
cd /home/hdoop
head -n -1 hadoop-3.2.2/etc/hadoop/core-site.xml > tmp.txt && mv tmp.txt hadoop-3.2.2/etc/hadoop/core-site.xml


#Edit core-site.xml file
echo '
<property>
  <name>hadoop.tmp.dir</name>
  <value>/home/hdoop/tmpdata</value>
</property>
<property>
  <name>fs.default.name</name>
  <value>hdfs://127.0.0.1:9000</value>
</property>
</configuration> 
' >> /home/hdoop/hadoop-3.2.2/etc/hadoop/core-site.xml

head -n -1 /home/hdoop/hadoop-3.2.2/etc/hadoop/hdfs-site.xml > tmp.txt && mv tmp.txt /home/hdoop/hadoop-3.2.2/etc/hadoop/hdfs-site.xml

## Edit hdfs-site.xml file

echo '
<property>
  <name>dfs.data.dir</name>
  <value>/home/hdoop/dfsdata/namenode</value>
</property>
<property>
  <name>dfs.data.dir</name>
  <value>/home/hdoop/dfsdata/datanode</value>
</property>
<property>
  <name>dfs.replication</name>
  <value>1</value>
</property>
</configuration>
' >> /home/hdoop/hadoop-3.2.2/etc/hadoop/hdfs-site.xml

head -n -1 /home/hdoop/hadoop-3.2.2/etc/hadoop/mapred-site.xml > tmp.txt && mv tmp.txt /home/hdoop/hadoop-3.2.2/etc/hadoop/mapred-site.xml

#Edit mapred-site.xml file
echo '
<property>
  <name>mapreduce.framework.name</name> 
  <value>yarn</value> 
</property> 
</configuration> 
' >> /home/hdoop/hadoop-3.2.2/etc/hadoop/mapred-site.xml


head -n -1 /home/hdoop/hadoop-3.2.2/etc/hadoop/yarn-site.xml > tmp.txt && mv tmp.txt /home/hdoop/hadoop-3.2.2/etc/hadoop/yarn-site.xml

#Edit yarn-site.xml File

echo '
<property>
  <name>yarn.nodemanager.aux-services</name>
  <value>mapreduce_shuffle</value>
</property>
<property>
  <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
  <value>org.apache.hadoop.mapred.ShuffleHandler</value>
</property>
<property>
  <name>yarn.resourcemanager.hostname</name>
  <value>127.0.0.1</value>
</property>
<property>
  <name>yarn.acl.enable</name>
  <value>0</value>
</property>
<property>
  <name>yarn.nodemanager.env-whitelist</name>   
<value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PERPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value>
</property>
</configuration>
' >> /home/hdoop/hadoop-3.2.2/etc/hadoop/yarn-site.xml

