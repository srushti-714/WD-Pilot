#!/bin/bash

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

