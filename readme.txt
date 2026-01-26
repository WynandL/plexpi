The plex.sh is a script file and must be downloaded to the PI and executed

Before running the script:
1. Ensure there is a Videos folder on the external HDD and it is plugged in (USB)
2. Ensure there is a iCloudAlwaysOn folder on the external HDD - or remove the samba command in the script
3. Ensure that the current network runs on 192.168.0.X
4. Keep the keyboard attached. There will be 2 prompts to answer yes to
5. There are setup lines for Ethernet and wifi so (un)comment as needed

To download the file to the PI, use: 
sudo wget https://raw.githubusercontent.com/WynandL/plexpi/master/plex.sh

It can be downloaded anywhere on the PI, so root is fine (it will be deleted again by the script)
To execute the script, type:
bash plex.sh

When the script has completed, the PI will be restarted and can be accessed remotely from Putty (192.168.1.200)

After the script has completed:
Log in to Plex on the browser (192.168.0.200:32400/web/index.html) and configure the library
The library (TV shows, for example) must point to \mydisk\Videos (it should be accessible when browsing)
Remove any old Raspberry Pi Plex servers (that are not currently connected and have a red exclamation mark)
