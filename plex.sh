#ls
#Enable SSH so that PI can be accessed from Putty
echo -e "Enabling ssh..."
sudo systemctl enable ssh
sudo systemctl start ssh

#Update and ugrade distribution before starting
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get update && sudo apt-get dist-upgrade -y

#https://pimylifeup.com/raspberry-pi-plex-server/
sudo apt-get install apt-transport-https
curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list #yes
sudo apt-get update -y
sudo apt-get install plexmediaserver

#Make new directory to be used by samba...
sudo mkdir /mnt/mydisk

#Install samba, required to read and write to PI-attached HDD
#https://pimylifeup.com/raspberry-pi-samba/
sudo apt-get install samba samba-common-bin -y #yes

#Configure the samba config file and create myPi folder (seen by windows if \\ip is accessed)
#HDD will be mounted onto /mnt/mydisk
#Folder structure on HDD will therefore be /mnt/mydisk/folder
#Below, a public connection, for Windows, will be created linking myPi to the Videos folder on HDD
#Ensure that there is a Videos folder on the HDD root
sudo echo -e "[myPi]\npath = /mnt/mydisk/Videos\nwriteable=Yes\ncreate mask=0777\ndirectory mask=0777\npublic=yes" | sudo tee -a /etc/samba/smb.conf
#To add any additional files, such as one for constant iCloud storage backup, again ensure the folder exist on the HDD and repeat above, e.g.
#Windows (at the ip address) will now also see iCloud as a new location, linked to the iCloudAlwaysOn folder on the HDD
sudo echo -e "[iCloud]\npath = /mnt/mydisk/iCloudAlwaysOn\nwriteable=Yes\ncreate mask=0777\ndirectory mask=0777\npublic=yes" | sudo tee -a /etc/samba/smb.conf
#restart samba after all (and any new) changes
sudo systemctl restart smbd

#Change the PI's ip address on ethernet (eth0 assumed) to a static one by configuring the dhcpcd.conf file
#https://thepihut.com/blogs/raspberry-pi-tutorials/how-to-give-your-raspberry-pi-a-static-ip-address-update
#New (strange - Aug 2020) Buster behaviour - need to add static domain name:
#old -> echo -e "interface eth0\nstatic ip_address=192.168.1.200/24\nstatic routers=192.168.1.1" | sudo tee -a /etc/dhcpcd.conf
#new ->
echo -e "interface eth0\nstatic ip_address=192.168.1.200/24\nstatic routers=192.168.1.1\nstatic domain_name_servers=8.8.8.8 8.8.4.4" | sudo tee -a /etc/dhcpcd.conf

#New (strange - Aug 2020) Buster behaviour - need to add these commands else there is no internet connection on the PI
#https://www.raspberrypi.org/forums/viewtopic.php?t=121934
sudo echo -e "auto lo\niface lo inet loopback\nauto eth0\nallow-hotplug eth0\niface eth0 inet manual" | sudo tee -a /etc/network/interfaces

#If WiFi is preferred, uncomment the following lines and comment out the echo -e "interface eth0 line
#echo -e "network={\nssid=lamps\npsk=rockykangaroo288\n}" | sudo tee -a /etc/wpa_supplicant.conf
#echo -e "interface wlan0\nstatic ip_address=192.168.1.200/24\nstatic routers=192.168.1.1\nstatic domain_name_servers=8.8.8.8 8.8.4.4" | sudo tee -a /etc/dhcpcd.conf

#Edit the fstab file so that the HDD (sda1 assumed) is mounted each time the PI reboots
#The manual way to do this is by: sudo mount /dev/sda1 /mnt/mydisk
echo -e "/dev/sda1 /mnt/mydisk ntfs defaults 0 0" | sudo tee -a /etc/fstab

########################################################################################
#install GIT to manage library files for Plex
#sudo apt install git -y

#Create folder where libraries will be backed up
#sudo mkdir /home/pi/plexlib

#Copy library files to this directory - first stop plex...
#sudo service plexmediaserver stop

#wget into plex library folder
#sudo cp /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-in\ Support/Databases/com.plexapp.plugins.library.db /home/pi/plexlib

#retrieve library copy script
#sudo wget https://raw.githubusercontent.com/WynandL/plexpi/master/plexlib.sh

#put this script into crontab, wil execute 00h00 each night
#line="0 0 * * * /home/pi/plexlib.sh"
#(crontab -u pi -l; echo "$line" ) | crontab -u pi -
####################################################################################

#Delete the plex.sh file again so that it cannot be run (bash) again
sudo rm plex.sh

echo -e "Configuration complete. Restarting in 10 seconds."
sleep 10
sudo reboot
