#!/bin/bash

cd /home/hdoop
#source .bashrc
export HADOOP_HOME=/home/hdoop/hadoop-3.3.4
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
#echo -e 'yes' | ssh localhost
ssh-keyscan -H localhost >> ~/.ssh/known_hosts
#exit
echo -e 'Y' | hdfs namenode -format
/home/hdoop/hadoop-3.3.4/sbin/start-dfs.sh
/home/hdoop/hadoop-3.3.4/sbin/start-yarn.sh
