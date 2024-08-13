#!/bin/bash

# List of required libraries
libraries=(
    "libwebkit2gtk-4.0.so.37"
    "libjavascriptcoregtk-4.0.so.18"
    "libwpe-1.0.so.1"
    "libWPEBackend-fdo-1.0.so.1"
)

# Paths to the snap package libraries
snap_paths=(
    "/snap/gnome-42-2204/176/usr/lib/x86_64-linux-gnu"
    "/snap/gnome-42-2204/176/usr/lib"
)

# Path to the system libraries
system_path="/usr/lib/x86_64-linux-gnu"

# Function to create symbolic links
create_symlink() {
    local lib_name=$1
    for snap_path in "${snap_paths[@]}"; do
        if [ -f "${snap_path}/${lib_name}" ]; then
            sudo ln -s "${snap_path}/${lib_name}" "${system_path}/${lib_name}"
            echo "Created symlink for ${lib_name} from ${snap_path}"
            return 0
        fi
    done
    echo "Library ${lib_name} not found in snap paths"
    return 1
}

# Iterate over the list of libraries and create symbolic links
for lib in "${libraries[@]}"; do
    create_symlink "${lib}"
done

# Run Citrix Workspace to identify any other missing libraries
/opt/Citrix/ICAClient/selfservice

