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

echo 'Create new user for hadoop cluster...'
echo "------------------------"
sudo adduser --disabled-password --gecos "" admin
su - admin
mkdir /home/admin/hadoop
sudo chmod 777 -R /home/admin/hadoop

echo 'Download hadoop 3.2.1'
echo "------------------------"
wget https://downloads.apache.org/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz
tar -zxvf hadoop-3.2.1.tar.gz -C /home/admin/hadoop/
rm /home/admin/hadoop/hadoop-3.2.1.tar.gz