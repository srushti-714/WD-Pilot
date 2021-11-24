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

export LATEST_VER="8.11.0"
cd /usr/share/hue
curl -O https://downloads.apache.org/lucene/solr/${LATEST_VER}/solr-${LATEST_VER}.tgz
tar xvf solr-${LATEST_VER}.tgz
cd solr-${LATEST_VER}/bin/
nohup ./install_solr_service.sh /usr/share/hue/solr-${LATEST_VER}.tgz  > /dev/null 2>&1 &


# Run the hue server in the background and make it available on port 8000
cd /usr/share/hue
chown -R hue:hdoop /usr/share/hue
build/env/bin/pip install mysql-python
#build/env/bin/pip install git+https://github.com/gethue/PyHive
#build/env/bin/pip install thrift-sasl
#build/env/bin/pip install pyodbc
#build/env/bin/pip install pymssql
#build/env/bin/pip install PyAthena
#build/env/bin/pip install snowflake-sqlalchemy
#build/env/bin/pip install sqlalchemy-solr
nohup ./build/env/bin/hue runserver 0.0.0.0:8000   > /dev/null 2>/home/ubuntu/tmplog007.txt &
source ./build/env/bin/activate
build/env/bin/hue syncdb --noinput
build/env/bin/hue migrate
deactivate
