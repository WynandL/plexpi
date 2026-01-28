sudo mkdir -p /mnt/mydisk
lsblk -f
sudo apt install -y ntfs-3g
sudo nano /etc/fstab
UUID=1234-ABCD  /mnt/mydisk  ntfs  defaults,noatime,nofail  0  0
sudo mount -a
sudo reboot
