#sudo wget https://raw.githubusercontent.com/WynandL/plexpi/master/plex2026_1.sh
#Enable SSH
sudo systemctl enable ssh
sudo systemctl start ssh
systemctl status ssh

###################################
sudo apt update
sudo apt full-upgrade -y
sudo reboot

sudo nmcli con modify "Wired connection 1" \
  ipv4.method manual \
  ipv4.addresses 192.168.0.200/24 \
  ipv4.gateway 192.168.0.1 \
  ipv4.dns "8.8.8.8 8.8.4.4" \
  ipv4.ignore-auto-dns yes

sudo nmcli con down "Wired connection 1"
sudo nmcli con up "Wired connection 1"
