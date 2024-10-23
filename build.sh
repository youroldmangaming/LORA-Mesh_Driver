#!/bin/bash
# setup_lora_env.sh: Setup environment for building SX1276 LoRa mesh driver

# Exit script on any error
set -e

# Function to print messages
function info {
    echo -e "\033[1;32m[INFO]\033[0m $1"
}

# Function to print error messages
function error {
    echo -e "\033[1;31m[ERROR]\033[0m $1"
}

# Step 1: Update system packages
info "Updating system packages..."
sudo apt-get update -y
sudo apt-get upgrade -y

# Step 2: Install required tools and headers
info "Installing required packages (build-essential, kernel headers, SPI support)..."
sudo apt-get install -y build-essential raspberrypi-kernel-headers git spi-tools

# Step 3: Enable SPI (required for LoRa SX1276 communication)
info "Enabling SPI interface..."
sudo raspi-config nonint do_spi 0

# Step 4: Clone the driver repository (if hosted on a repository)
info "Cloning the driver repository..."
# Replace with your actual repository URL if hosted, otherwise skip
# git clone https://github.com/youroldmangaming/LORA-Mesh_Driver/sx1276_mesh_driver.git
# cd sx1276_mesh_driver

# Step 5: Build the SX1276 mesh driver
info "Building the SX1276 mesh driver..."
make

# Step 6: Install the driver
info "Installing the SX1276 mesh driver..."
sudo make install

# Step 7: Load the driver
info "Loading the SX1276 mesh driver..."
sudo modprobe sx1276_mesh_driver

# Step 8: Verify if the driver is loaded
info "Verifying if the SX1276 driver is loaded..."
if lsmod | grep -q "sx1276_mesh_driver"; then
    info "SX1276 mesh driver loaded successfully!"
else
    error "Failed to load SX1276 mesh driver."
    exit 1
fi

# Step 9: Display instructions for debugging and testing
info "Setup complete. To view kernel logs for debugging, run the following command:"
echo "dmesg | grep 'sx1276'"
info "To unload the driver, use:"
echo "sudo rmmod sx1276_mesh_driver"
info "To reload the driver, use:"
echo "sudo modprobe sx1276_mesh_driver"

info "Environment setup is complete!"
