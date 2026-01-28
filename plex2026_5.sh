sudo nano /etc/samba/smb.conf

[myPi]
path = /mnt/mydisk/Videos
browseable = yes
writeable = yes
guest ok = yes
create mask = 0775
directory mask = 0775

sudo systemctl restart smbd

sudo reboot
