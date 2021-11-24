#!/bin/bash

cd /home/hdoop
tar xzf hadoop-3.2.2.tar.gz
tar xzf apache-hive-3.1.2-bin.tar.gz
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
' >> .bashrc


#source .bashrc

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
<property>
  <name>hadoop.proxyuser.hdoop.groups</name>
  <value>*</value>
</property>
<property>
  <name>hadoop.proxyuser.hdoop.hosts</name>
  <value>*</value>
</property>
<property>
  <name>hadoop.proxyuser.server.hosts</name>
  <value>*</value>
</property>
<property>
  <name>hadoop.proxyuser.server.groups</name>
  <value>*</value>
</property>
<property>
  <name>hadoop.proxyuser.hue.hosts</name>
  <value>*</value>
</property>
<property>
  <name>hadoop.proxyuser.hue.groups</name>
  <value>*</value>
</property>
<property>
  <name>hadoop.proxyuser.hbase.hosts</name>
  <value>*</value>
</property>
<property>
  <name>hadoop.proxyuser.hbase.groups</name>
  <value>*</value>
</property>
</configuration> 
' >> /home/hdoop/hadoop-3.2.2/etc/hadoop/core-site.xml

head -n -1 /home/hdoop/hadoop-3.2.2/etc/hadoop/hdfs-site.xml > tmp.txt && mv tmp.txt /home/hdoop/hadoop-3.2.2/etc/hadoop/hdfs-site.xml

## Edit hdfs-site.xml file

echo '
<property>
  <name>dfs.name.dir</name>
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
<property>
  <name>dfs.webhdfs.enabled</name>
  <value>true</value>
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
<property>
	<name>yarn.app.mapreduce.am.env</name>
	<value>HADOOP_MAPRED_HOME=/home/hdoop/hadoop-3.2.2</value>
</property>
<property>
	<name>mapreduce.map.env</name>
	<value>HADOOP_MAPRED_HOME=/home/hdoop/hadoop-3.2.2</value>
</property>
<property>
	<name>mapreduce.reduce.env</name>
	<value>HADOOP_MAPRED_HOME=/home/hdoop/hadoop-3.2.2</value>
</property>
<property>
	<name>mapreduce.map.memory.mb</name>
	<value>6096</value>
</property>
<property>
	<name>mapreduce.reduce.memory.mb</name>
	<value>6096</value>
</property>
<property>
	<name>mapreduce.map.java.opts</name>
	<value>-Xmx1638m</value>
</property>
<property>
	<name>mapreduce.reduce.java.opts</name>
	<value>-Xmx3278m</value>
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

### Hive configuration
cd /home/hdoop/apache-hive-3.1.2-bin/conf
cp hive-env.sh.template hive-env.sh
echo "export HADOOP_HOME=/home/hdoop/hadoop-3.2.2" >> hive-env.sh

#wget -O hive-site-tmp.xml https://raw.githubusercontent.com/CloudLabs-Samples/WD-Pilot/dev/setup/aws/files/hive-site.xml

cp hive-default.xml.template hive-site.xml
#sed '1 a #This is just a commented line' sedtest.txt

#sed '85 a       </description>' hive-site.xml
sed -i '143 c\
    <value>/tmp/mydir/test</value>' hive-site.xml

sed -i '148 c\
    <value>/tmp/mydir/${hive.session.id}_resources</value>' hive-site.xml

sed -i '444 c\
    <value>mysql</value>' hive-site.xml

sed -i '569 c\
    <value>securepass</value>' hive-site.xml

sed -i '584 c\
    <value>jdbc:mysql://127.0.0.1/hue?createDatabaseIfNotExist=true&amp;useSSL=false</value>' hive-site.xml
    
sed -i '798 c\
    <value>false</value>' hive-site.xml
    
sed -i '1102 c\
    <value>com.mysql.jdbc.Driver</value>' hive-site.xml
    
sed -i '1127 c\
	    <value>admin</value>' hive-site.xml
    
sed -i '1846 c\
    <value>/tmp/mydir/${system:user.name}</value>' hive-site.xml

sed -i '3068 c\
    <value>true</value>' hive-site.xml

sed -i '3215d' hive-site.xml
sed -i '3215d' hive-site.xml

sed -i '4402 c\
    <value>/tmp/mydir/${system:user.name}/operation_logs</value>' hive-site.xml

