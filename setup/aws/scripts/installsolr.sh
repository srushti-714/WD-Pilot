#!/bin/bash
export LATEST_VER="8.10.1"
cd /usr/share/hue
curl -O https://downloads.apache.org/lucene/solr/${LATEST_VER}/solr-${LATEST_VER}.tgz
tar xvf solr-${LATEST_VER}.tgz
cd solr-${LATEST_VER}/bin/
nohup ./install_solr_service.sh /usr/share/hue/solr-${LATEST_VER}.tgz  > /dev/null 2>&1 &


# Run the hue server in the background and make it available on port 8000
cd /usr/share/hue
chown -R hue:hdoop /usr/share/hue
build/env/bin/pip install git+https://github.com/gethue/PyHive
build/env/bin/pip install thrift-sasl
build/env/bin/pip install pyodbc
#build/env/bin/pip install pymssql
build/env/bin/pip install PyAthena
build/env/bin/pip install snowflake-sqlalchemy
build/env/bin/pip install sqlalchemy-solr
nohup ./build/env/bin/hue runserver 0.0.0.0:8000   > /dev/null 2>/home/ubuntu/tmplog007.txt &
source build/env/bin/activate
hue syncdb --noinput
hue migrate
deactivate
