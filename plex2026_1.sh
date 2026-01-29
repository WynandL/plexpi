# sudo wget https://raw.githubusercontent.com/WynandL/plexpi/master/plex2026_1.sh
###################################
sudo systemctl enable ssh
sudo systemctl start ssh
systemctl status ssh

###################################
sudo apt update
sudo apt full-upgrade -y
sudo reboot

###################################
# Current Pi Network Manager is difficult; keep DHCP for now
# Plex on TV don't need a static IP (browser will though...)
#sudo nmcli con modify "Wired connection 1" \
#  ipv4.method manual \
#  ipv4.addresses 192.168.0.200/24 \
#  ipv4.gateway 192.168.0.1 \
#  ipv4.dns "8.8.8.8,8.8.4.4" \
#  ipv4.ignore-auto-dns yes \
#  ipv4.never-default no \
#  connection.autoconnect yes

#sudo nmcli con modify "Wired connection 1" ipv4.route-metric 100

#sudo nmcli con down "Wired connection 1"
#sudo systemctl restart NetworkManager
#sudo nmcli con up "Wired connection 1"
