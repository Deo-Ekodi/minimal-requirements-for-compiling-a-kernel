# sudo apt install dwarves && sudo apt install jfsutils && sudo apt install pcmciautils && sudo apt install quota && sudo apt install udev && sudo apt install sudo apt install rasdaemon
#  && sudo apt install bc && sudo apt install global

#!/bin/bash

# required packages and their versions
declare -A required_packages=(
    ["gcc"]="5.1"
    ["clang"]="13.0.1"
    ["rust"]="1.75.0"
    ["bindgen"]="0.65.1"
    ["make"]="3.82"
    ["bash"]="4.2"
    ["binutils"]="2.25"
    ["flex"]="2.5.35"
    ["bison"]="2.0"
    ["pahole"]="1.16"
    ["util-linux"]="2.10o"
    ["kmod"]="13"
    ["e2fsprogs"]="1.41.4"
    ["jfsutils"]="1.1.3"
    ["reiserfsprogs"]="3.6.3"
    ["xfsprogs"]="2.6.0"
    ["squashfs-tools"]="4.0"
    ["btrfs-progs"]="0.18"
    ["pcmciautils"]="004"
    ["quota-tools"]="3.09"
    ["PPP"]="2.4.0"
    ["nfs-utils"]="1.0.5"
    ["procps"]="3.2.0"
    ["udev"]="081"
    ["grub"]="0.93"
    ["mcelog"]="0.6"
    ["iptables"]="1.4.2"
    ["openssl"]="1.0.0"
    ["bc"]="1.06.95"
    ["Sphinx1"]="2.4.4"
    ["cpio"]="any"
    ["tar"]="1.28"
    ["gtags"]="6.6.5"
)

# Array to hold missing packages
missing_packages=()

# Checking for each required package
for package in "${!required_packages[@]}"; do
    version_required="${required_packages[$package]}"
    version_installed=$(eval "$package --version 2>/dev/null | head -n 1 | awk '{print \$NF}'")

    if [[ "$version_required" == "any" || "$version_installed" == "$version_required" ]]; then
        echo "$package is installed with the correct version: $version_installed"
    else
        echo "$package is missing or incorrect version (required: $version_required, installed: $version_installed)"
        missing_packages+=("$package")
    fi
done

# Install missing packages
if [[ ${#missing_packages[@]} -gt 0 ]]; then
    read -p "Do you want to install the missing packages? (y/n): " choice
    if [[ "$choice" == "y" ]]; then
        for package in "${missing_packages[@]}"; do
            case "$package" in
                "gcc" | "clang")
                    sudo apt-get install -y $package
                    ;;
                "rust")
                    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
                    ;;
                # Add more installation commands for other packages as needed
                *)
                    echo "Installation for $package is not supported by this script."
                    ;;
            esac
        done
    else
        echo "Installation aborted."
    fi
else
    echo "All required packages are installed."
fi
