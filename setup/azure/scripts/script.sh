#!/bin/bash

mkdir tmp
cd tmp
sudo apt update -y
sudo apt install ant gcc g++ libkrb5-dev *libmysqlclient-dev libssl-dev libsasl2-dev libsasl2-modules-gssapi-mit libsqlite3-dev libtidy*dev libxml2-dev libxslt-dev maven libldap2-dev python-dev python-setuptools git -y
sudo apt update -y

curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -

 curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
     echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
     sudo apt-get update && sudo apt-get install yarn

sudo apt-get install -y nodejs
sudo apt update -y
npm install --global npm
apt-get install python-snappy
sudo echo -e 'Password.1!!\nPassword.1!!' | adduser hue


git clone https://github.com/cloudera/hue.git

mkdir /usr/share/hue

chown -R hue:hadoop /usr/share/hue
cd hue
PREFIX=/usr/share make install 
cd /usr/share/hue
chown -R hue:hadoop /usr/share/hue
make apps
./build/env/bin/hue runserver 0.0.0.0:8000
