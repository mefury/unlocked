#!/bin/sh
# Nexus L1 CLI Node Download Script for Linux
# Credit: mefury - https://x.com/meefury
# This script downloads the nexus-network executable to the current directory and makes it executable.

# Define environment variables
DOWNLOAD_URL="https://raw.githubusercontent.com/mefury/unlocked/750ea8ad0f74f739d69c599ffc465519e2426821/nexus-network"

# Check if the executable already exists in the current directory
EXECUTABLE="./nexus-network"
if [ -f "$EXECUTABLE" ]; then
    echo "Executable '$EXECUTABLE' already exists. Skipping download."
else
    echo "Downloading executable from: $DOWNLOAD_URL"
    if ! curl -L -o "$EXECUTABLE" "$DOWNLOAD_URL"; then
        echo "Failed to download executable from $DOWNLOAD_URL"
        exit 1
    fi
    chmod +x "$EXECUTABLE"
    echo "Download complete! Executable is ready at '$EXECUTABLE'."
fi
