#!/bin/bash

cd /home/hdoop
source .bashrc
echo -e 'yes' | ssh localhost
exit
echo -e 'Y' | hdfs namenode -format
/home/hdoop/hadoop-3.2.2/sbin/start-dfs.sh
/home/hdoop/hadoop-3.2.2/sbin/start-yarn.sh
