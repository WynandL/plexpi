#sudo wget https://raw.githubusercontent.com/WynandL/plexpi/master/plex2026_1.sh
#Enable SSH
sudo systemctl enable ssh
sudo systemctl start ssh
systemctl status ssh

###################################
sudo apt update
sudo apt full-upgrade -y
sudo reboot
