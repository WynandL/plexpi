The plex.sh is a script file and must be downloaded to the PI and executed
To download the file to the PI, use: sudo wget 
It can be downloaded anywhere on the PI, so root is fine (it will be deleted again by the script)
To execute the script, type: bash plex.sh
When the script has completed, the PI will be restarted and can be accessed remotely from Putty (192.168.1.200)

Before running the script:
1. Ensure there is a Videos folder on the external HDD and it is plugged in (USB)
2. Ensure that the current network runs on 192.168.1.X
3. Keep the keyboard attached, there will be 2 prompts to answer yes on

After the script has completed:
Log in to Plex on the browser (192.168.1.200:32400/web/index.html) and configure the library
The library (TV shows, for example) must point to \mydisk\Videos (it should be accessible when browsing)
Remove any old raspberry pi plex servers (that are not currently connected and has a red exclamation mark)
