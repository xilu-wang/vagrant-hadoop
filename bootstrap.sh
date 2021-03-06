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

echo 'Install JDK 11 to /usr/lib/jvm/'
echo "------------------------"
sudo mkdir /usr/lib/jvm
sudo wget https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz
sudo tar -zxvf openjdk-11.0.2_linux-x64_bin.tar.gz -C /usr/lib/jvm/
sudo rm openjdk-11.0.2_linux-x64_bin.tar.gz
export JAVA_HOME=/usr/lib/jvm/jdk-11.0.2
export PATH=$JAVA_HOME/bin:$PATH
sudo touch /etc/profile.d/jdk.sh
sudo echo 'export JAVA_HOME=/usr/lib/jvm/jdk-11.0.2' >> /etc/profile.d/jdk.sh
sudo echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile.d/jdk.sh
sudo echo 'export JAVA_HOME=/usr/lib/jvm/jdk-11.0.2' >> /home/admin/.bashrc
sudo echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /home/admin/.bashrc 

echo 'Create new user for hadoop cluster...'
echo "------------------------"
sudo useradd -m -s /bin/bash admin
sudo echo "admin:admin" | chpasswd
sudo mkdir /home/admin/hadoop
sudo chmod 777 -R /home/admin/hadoop

echo 'Download hadoop 2.7.2'
echo "------------------------"
sudo wget https://archive.apache.org/dist/hadoop/common/hadoop-2.7.2/hadoop-2.7.2.tar.gz
sudo tar -zxvf hadoop-2.7.2.tar.gz -C /home/admin/hadoop/
sudo chmod 777 -R /home/admin/hadoop/hadoop-2.7.2
sudo rm hadoop-2.7.2.tar.gz

echo 'Update Hadoop Enviroment'
echo "------------------------"
sudo echo 'export HADOOP_HOME=/home/admin/hadoop/hadoop-2.7.2' >> /home/admin/.bashrc
sudo echo 'export PATH=$PATH:$HADOOP_HOME/bin' >> /home/admin/.bashrc 
echo $HADOOP_HOME

echo 'Update Hadoop Configurations'
echo "------------------------"
sed -i 's/\r$//' /synced_data/hadoop-env.sh
sudo cp -f /synced_data/hadoop-env.sh /home/admin/hadoop/hadoop-2.7.2/etc/hadoop/hadoop-env.sh
sudo cp -f /synced_data/core-site.xml /home/admin/hadoop/hadoop-2.7.2/etc/hadoop/core-site.xml
sudo cp -f /synced_data/hdfs-site.xml /home/admin/hadoop/hadoop-2.7.2/etc/hadoop/hdfs-site.xml
sudo cp -f /synced_data/yarn-site.xml /home/admin/hadoop/hadoop-2.7.2/etc/hadoop/yarn-site.xml
sudo cp -f /synced_data/capacity-scheduler.xml /home/admin/hadoop/hadoop-2.7.2/etc/hadoop/capacity-scheduler.xml
sudo cp -f /synced_data/mapred-site.xml /home/admin/hadoop/hadoop-2.7.2/etc/hadoop/mapred-site.xml
sudo cp -f /synced_data/slaves /home/admin/hadoop/hadoop-2.7.2/etc/hadoop/slaves

ifconfig