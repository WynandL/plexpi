# sudo wget https://raw.githubusercontent.com/WynandL/plexpi/master/plex2026_2.sh
###################################
# Install dependencies - entire file can be copied and pasted into CLI
sudo apt install -y curl gnupg ca-certificates

###################################
# Add Plex GPG key (modern method)
curl -fsSL https://downloads.plex.tv/plex-keys/PlexSign.key | \
sudo gpg --dearmor -o /usr/share/keyrings/plex.gpg

###################################
# Add Plex repository
echo "deb [signed-by=/usr/share/keyrings/plex.gpg] https://downloads.plex.tv/repo/deb public main" | \
sudo tee /etc/apt/sources.list.d/plexmediaserver.list

###################################
sudo apt update
sudo apt install -y plexmediaserver

###################################
systemctl status plexmediaserver
