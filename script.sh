#!/bin/bash

# Nexus L1 CLI Node Start Script for Linux
# This script checks if the nexus-network executable exists, downloads it if not,
# and starts the node with user-specified node ID and thread count.

set -e  # Exit on any error

# URL for the raw binary download (GitHub raw content)
DOWNLOAD_URL="https://raw.githubusercontent.com/mefury/unlocked/750ea8ad0f74f739d69c599ffc465519e2426821/nexus-network"
EXECUTABLE="./nexus-network"

echo "=== Nexus L1 CLI Node Start Script ==="
echo "By: mefury - https://x.com/meefury"

# Check if the executable already exists
if [ -f "$EXECUTABLE" ]; then
    echo "Executable '$EXECUTABLE' already exists. Skipping download."
else
    echo "Executable not found. Downloading the nexus-network executable for Linux..."
    curl -L -o "$EXECUTABLE" "$DOWNLOAD_URL"
    chmod +x "$EXECUTABLE"
    echo "Download complete! The executable is now ready at '$EXECUTABLE'."
fi

# Prompt for node ID and thread count
echo ""
echo "Please provide the following details to start the node:"
read -p "Enter your node ID: " node_id
read -p "Enter max threads (default 8): " max_threads
max_threads=${max_threads:-8}

# Validate inputs
if [ -z "$node_id" ]; then
    echo "Error: Node ID cannot be empty."
    exit 1
fi
if ! [[ "$max_threads" =~ ^[0-9]+$ ]]; then
    echo "Error: Max threads must be a number."
    exit 1
fi

# Start the node
echo "Starting the node with node ID: $node_id and max threads: $max_threads..."
"$EXECUTABLE" start --node-id "$node_id" --max-threads "$max_threads" --max-difficulty extra_large

echo "Node started! For more details, check the Nexus documentation or GitHub repo."
