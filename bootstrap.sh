#!/usr/bin/env bash

echo 'Update packages list...'
echo "------------------------"
apt-get -y update

echo 'Set Pacific timezone...'
echo "------------------------"
echo "America/Los_Angeles" | sudo tee /etc/timezone
sudo dpkg-reconfigure --frontend noninteractive tzdata

echo 'Set English keyboard layout...'
echo "------------------------"
sudo sed -i 's/XKBLAYOUT="us"/g' /etc/default/keyboard

echo 'Create Development directory...'
echo "------------------------"
mkdir /home/vagrant/Development
mkdir /home/vagrant/Development/git
sudo chmod 777 -R /home/vagrant/Development/

echo 'Install Git and create local repository directory'
echo "------------------------"
sudo apt-get install git -y

echo 'Install Git Flow...'
echo "------------------------"
wget -q – http://github.com/nvie/gitflow/raw/develop/contrib/gitflow-installer.sh –no-check-certificate -P /tmp
sudo chmod a+x /tmp/gitflow-installer.sh
sudo sh /tmp/gitflow-installer.sh