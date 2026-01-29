# sudo wget https://raw.githubusercontent.com/WynandL/plexpi/master/plex2026_3.sh
###################################
sudo mkdir -p /mnt/mydisk

###################################
lsblk -f

###################################
sudo apt install -y ntfs-3g

###################################
sudo nano /etc/fstab
#Replace the UUID with the one found after lsblk -f
UUID=1234-ABCD  /mnt/mydisk  ntfs  defaults,noatime,nofail  0  0 #Ctrl-O-Enter-Ctrl-X

###################################
sudo mount -a

###################################
#Reboot optional
#sudo reboot
