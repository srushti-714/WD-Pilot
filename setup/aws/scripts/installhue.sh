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
make install 2> /home/labuser/tmplog005.txt

chown -R hue:hdoop /usr/share/hue
make apps 2> /home/labuser/tmplog006.txt
# Run the hue server in the background and make it available on port 8000
./build/env/bin/hue runserver 0.0.0.0:8000 &  2> tmplog007.txt
