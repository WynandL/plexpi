sudo rm com.plexapp.plugins.library.db
sudo service plexmediaserver stop
sudo cp /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-in\ Support/Databases/com.plexapp.plugins.library.db /home/pi
sudo service plexmediaserver start
