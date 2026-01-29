# sudo wget https://raw.githubusercontent.com/WynandL/plexpi/master/plex2026_4.sh
###################################
# Permissions for Plex + Samba (CRITICAL)
sudo groupadd media
sudo usermod -aG media plex
sudo usermod -aG media pi

###################################
sudo chown -R pi:media /mnt/mydisk
sudo chmod -R 775 /mnt/mydisk

###################################
sudo apt install -y samba

###################################
sudo nano /etc/samba/smb.conf

###################################
# Copy at the bottom of smb.conf
[myPi]
path = /mnt/mydisk/Videos
browseable = yes
writeable = yes
guest ok = yes
create mask = 0775
directory mask = 0775

###################################
sudo systemctl restart smbd

###################################
sudo reboot
