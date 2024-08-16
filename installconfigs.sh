#!/bin/bash

# Mount the 1TB drive
#mount /dev/sda1 /mnt/my1tbdrive

# Copy configurations
sudo cp -r /home/abaddon/Configs/grub /etc/default/
sudo cp -r /home/abaddon/Configs/hypr /home/abaddon/.config/
sudo cp -r /home/abaddon/Configs/kitty /home/abaddon/.config/
sudo cp /home/abaddon/Configs/limits.conf /etc/security/limits.conf
sudo usermod -a -G audio abaddon
sudo usermod -a -G video abaddon
sudo usermod -a -G storage abaddon

# Install packages
yay -S cpupower


sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo cpupower frequency-set -g performance && echo "high" | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level

# Copy Steam files
#cp -r /mnt/my1tbdrive/Steam ~/.
#cp -r /mnt/my1tbdrive/SteamLibrary ~/.

# Copy Samples
#cp -r /mnt/my1tbdrive/Samples ~/.

# Unmount the drive
#umount /mnt/my1tbdrive
#!/bin/bash

# Variables
HDD_MOUNT_POINT="/mnt/my1tbdrive"
HOME_DIR="/home/abaddon"
DIRECTORIES=("Samples" "Video" "Games")

# Create directories on the HDD
echo "Creating directories on the HDD..."
for dir in "${DIRECTORIES[@]}"; do
    if [ ! -d "$HDD_MOUNT_POINT/$dir" ]; then
        sudo mkdir -p "$HDD_MOUNT_POINT/$dir"
        echo "Created $HDD_MOUNT_POINT/$dir"
    else
        echo "$HDD_MOUNT_POINT/$dir already exists."
    fi
done

# Create symbolic links in the home directory
echo "Creating symbolic links in $HOME_DIR..."
for dir in "${DIRECTORIES[@]}"; do
    if [ ! -L "$HOME_DIR/$dir" ]; then
        ln -s "$HDD_MOUNT_POINT/$dir" "$HOME_DIR/$dir"
        echo "Linked $HDD_MOUNT_POINT/$dir to $HOME_DIR/$dir"
    else
        echo "Symbolic link $HOME_DIR/$dir already exists."
    fi
done

echo "Setup complete!"

echo "Files have been copied successfully!"

