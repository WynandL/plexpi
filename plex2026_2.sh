# Install dependencies
sudo apt install -y curl gnupg ca-certificates

# Add Plex GPG key (modern method)
curl -fsSL https://downloads.plex.tv/plex-keys/PlexSign.key | \
sudo gpg --dearmor -o /usr/share/keyrings/plex.gpg

# Add Plex repository
echo "deb [signed-by=/usr/share/keyrings/plex.gpg] https://downloads.plex.tv/repo/deb public main" | \
sudo tee /etc/apt/sources.list.d/plexmediaserver.list

# Update and install
sudo apt update
sudo apt install -y plexmediaserver
