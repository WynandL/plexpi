sudo systemctl enable ssh
sudo systemctl start ssh
systemctl status ssh

sudo apt update
sudo apt full-upgrade -y
#sudo reboot

#Modern Plex install
# Install dependencies
sudo apt install -y curl gnupg ca-certificates

# Add Plex GPG key (modern method)
if [ ! -f /usr/share/keyrings/plex.gpg ]; then
  curl -fsSL https://downloads.plex.tv/plex-keys/PlexSign.key | \
  sudo gpg --dearmor -o /usr/share/keyrings/plex.gpg
fi

# Add Plex repository
echo "deb [signed-by=/usr/share/keyrings/plex.gpg] https://downloads.plex.tv/repo/deb public main" | \
sudo tee /etc/apt/sources.list.d/plexmediaserver.list

# Update and install
sudo apt update
sudo apt install -y plexmediaserver

#systemctl status plexmediaserver

#Create mount point
sudo mkdir -p /mnt/mydisk

#Install filesystem support
sudo apt install -y ntfs-3g

#Use bottom code if manual, else the script part
#sudo nano /etc/fstab
#UUID=1234-ABCD  /mnt/mydisk  ntfs  defaults,noatime,nofail  0  0
#sudo mount -a

# ---- Disk labeling + fstab (label-based, scripted) ----

DISK_DEV="/dev/sda1"
DISK_LABEL="MEDIA"
MOUNT_POINT="/mnt/mydisk"

# Label the disk (safe: overwrites label, not data)
sudo ntfslabel "$DISK_DEV" "$DISK_LABEL"

# Ensure mount point exists
sudo mkdir -p "$MOUNT_POINT"

# fstab entry using /dev/disk/by-label (no UUID needed)
FSTAB_LINE="/dev/disk/by-label/$DISK_LABEL  $MOUNT_POINT  ntfs  defaults,noatime,nofail  0  0"

# Add only if not already present
if ! grep -qs "/dev/disk/by-label/$DISK_LABEL" /etc/fstab; then
  echo "$FSTAB_LINE" | sudo tee -a /etc/fstab
fi

# Mount all
sudo mount -a


# ---- Ensure Plex waits for the media disk ----

PLEX_OVERRIDE_DIR="/etc/systemd/system/plexmediaserver.service.d"
PLEX_OVERRIDE_FILE="$PLEX_OVERRIDE_DIR/override.conf"

# Create override directory if missing
sudo mkdir -p "$PLEX_OVERRIDE_DIR"

# Write override (idempotent)
sudo tee "$PLEX_OVERRIDE_FILE" > /dev/null <<EOF
[Unit]
RequiresMountsFor=/mnt/mydisk
EOF

# Reload systemd to apply override
sudo systemctl daemon-reload

# Restart Plex to apply new dependency
sudo systemctl restart plexmediaserver


#Permissions for Plex + Samba
sudo groupadd media
sudo usermod -aG media plex
sudo usermod -aG media pi

#Set ownership
sudo chown -R pi:media /mnt/mydisk
sudo chmod -R 775 /mnt/mydisk

#Samba
#sudo apt install -y samba

#sudo nano /etc/samba/smb.conf
#[myPi]
#path = /mnt/mydisk/Videos
#browseable = yes
#writeable = yes
#guest ok = yes
#create mask = 0775
#directory mask = 0775

#sudo systemctl restart smbd

# ---- Samba share configuration (scripted) ----

SAMBA_SHARE_NAME="myPi"
SAMBA_SHARE_PATH="/mnt/mydisk/Videos"
SMB_CONF="/etc/samba/smb.conf"

# Ensure media directory exists
sudo mkdir -p "$SAMBA_SHARE_PATH"

# Append Samba share only if it doesn't already exist
if ! grep -qs "^\[$SAMBA_SHARE_NAME\]" "$SMB_CONF"; then
  sudo tee -a "$SMB_CONF" > /dev/null <<EOF

[$SAMBA_SHARE_NAME]
path = $SAMBA_SHARE_PATH
browseable = yes
writeable = yes
guest ok = yes
create mask = 0775
directory mask = 0775

EOF
fi

# Restart Samba
sudo systemctl restart smbd

echo -e "Configuration complete. Restarting in 10 seconds."
sleep 10
sudo reboot
