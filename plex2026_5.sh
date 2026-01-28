#sudo wget https://raw.githubusercontent.com/WynandL/plexpi/master/plex2026_5.sh
###################################
#Only checks to see if everything works - or use http://localhost:32400/web
findmnt /mnt/mydisk
#Expected output: /mnt/mydisk  /dev/sda1  ntfs  rw,noatime

###################################
#See capacities and all disks, including new mount
df -h /mnt/mydisk

###################################
#Ensure these directories exist (no errors)
ls -ld /mnt/mydisk
ls -ld /mnt/mydisk/Videos

###################################
#Can Plex read the files? (THIS is the key test)
sudo -u plex ls /mnt/mydisk/Videos
#Expected output is the list of files

###################################
systemctl status plexmediaserver #(running?)
systemctl status smbd #(running?)
