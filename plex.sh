ls
#sudo apt-get update && sudo apt-get upgrade -y
#sudo apt-get update && sudo apt-get dist-upgrade -y

#sudo apt-get install apt-transport-https
#curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
#echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
#sudo apt-get update
#sudo apt-get install plexmediaserver

#sudo apt-get install samba samba-common-bin
#sudo echo -e "[myPi]\npath = /mnt/mydisk/Videos\nwriteable=Yes\ncreate mask=0777\ndirectory mask=0777\npublic=yes" | sudo tee -a /etc/samba/smb.conf
#sudo systemctl restart smbd

#echo -e "interface eth0\nstatic ip_address=192.168.1.200/24\nstatic routers=192.168.1.1" | sudo tee -a /etc/dhcpcd.conf
#sudo reboot

#sudo mkdir /mnt/mydisk
#sudo mount /dev/sda1 /mnt/mydisk