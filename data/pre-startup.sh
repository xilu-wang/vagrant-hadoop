echo 'Update host configuration'
echo "------------------------"
sudo echo '192.168.1.149       namenode' >> /etc/hosts
sudo echo '192.168.1.150       resourcemanager' >> /etc/hosts
sudo echo '192.168.1.151       secnamenode' >> /etc/hosts

echo 'Configure ssh passwordless'
echo "------------------------"
ssh-keygen -t dsa
echo "admin" | sshpass ssh-copy-id -i ~/.ssh/id_*.pub namenode
echo "admin" | sshpass ssh-copy-id -i ~/.ssh/id_*.pub resourcemanager
echo "admin" | sshpass ssh-copy-id -i ~/.ssh/id_*.pub secnamenode