sudo groupadd media
sudo usermod -aG media plex
sudo usermod -aG media pi

sudo chown -R pi:media /mnt/mydisk
sudo chmod -R 775 /mnt/mydisk

sudo apt install -y samba
sudo reboot
