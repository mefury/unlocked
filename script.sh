#!/bin/sh
# Nexus L1 CLI Node Start Script for Linux
# Credit: mefury - https://x.com/meefury
# This script checks if the nexus-network executable exists, downloads it if not,
# and starts the node with user-specified node ID and thread count.

# Define environment variables and colors for terminal output.
NEXUS_HOME="$HOME/.nexus"
BIN_DIR="$NEXUS_HOME/bin"
GREEN='\033[1;32m'
ORANGE='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m' # No Color
DOWNLOAD_URL="https://raw.githubusercontent.com/mefury/unlocked/750ea8ad0f74f739d69c599ffc465519e2426821/nexus-network"

# Ensure the $NEXUS_HOME and $BIN_DIR directories exist.
[ -d "$NEXUS_HOME" ] || mkdir -p "$NEXUS_HOME"
[ -d "$BIN_DIR" ] || mkdir -p "$BIN_DIR"

# Display a message if we're interactive (NONINTERACTIVE is not set) and the
# $NODE_ID is not a 28-character ID. This is for Testnet II info.
if [ -z "$NONINTERACTIVE" ] && [ "${#NODE_ID}" -ne "28" ]; then
    echo ""
    echo "${GREEN}Testnet III is now live!${NC}"
    echo ""
fi

# Prompt the user to agree to the Nexus Beta Terms of Use if we're in an
# interactive mode (i.e., NONINTERACTIVE is not set) and no config.json file exists.
while [ -z "$NONINTERACTIVE" ] && [ ! -f "$NEXUS_HOME/config.json" ]; do
    read -p "Do you agree to the Nexus Beta Terms of Use (https://nexus.xyz/terms-of-use)? (Y/n) " yn </dev/tty
    echo ""
    case $yn in
        [Nn]* )
            echo ""
            exit;;
        [Yy]* )
            echo ""
            break;;
        "" )
            echo ""
            break;;
        * )
            echo "Please answer yes or no."
            echo "";;
    esac
done

# Determine the platform and architecture
case "$(uname -s)" in
    Linux*)
        PLATFORM="linux"
        case "$(uname -m)" in
            x86_64|aarch64|arm64)
                ;;
            *)
                echo "${RED}Unsupported architecture: $(uname -m)${NC}"
                echo "Please build from source:"
                echo " git clone https://github.com/nexus-xyz/nexus-cli.git"
                echo " cd nexus-cli/clients/cli"
                echo " cargo build --release"
                exit 1
                ;;
        esac
        ;;
    *)
        echo "${RED}Unsupported platform: $(uname -s)${NC}"
        echo "This script supports only Linux."
        exit 1
        ;;
esac

# Validate download URL and download the binary
if [ -z "$DOWNLOAD_URL" ]; then
    echo "${RED}No download URL available for $PLATFORM${NC}"
    echo "Please check the script configuration."
    exit 1
fi

# Check if the executable already exists
EXECUTABLE="$BIN_DIR/nexus-network"
if [ -f "$EXECUTABLE" ]; then
    echo "Executable '$EXECUTABLE' already exists. Skipping download."
else
    echo "Downloading latest release for ${GREEN}$PLATFORM${NC}..."
    echo "Downloading from: ${GREEN}$DOWNLOAD_URL${NC}"
    if ! curl -L -o "$EXECUTABLE" "$DOWNLOAD_URL"; then
        echo "${RED}Failed to download binary from $DOWNLOAD_URL${NC}"
        echo "Please try again or build from source:"
        echo " git clone https://github.com/nexus-xyz/nexus-cli.git"
        echo " cd nexus-cli/clients/cli"
        echo " cargo build --release"
        exit 1
    fi
    chmod +x "$EXECUTABLE"
fi

# Add $BIN_DIR to PATH if not already present
case "$SHELL" in
    */bash)
        PROFILE_FILE="$HOME/.bashrc"
        ;;
    */zsh)
        PROFILE_FILE="$HOME/.zshrc"
        ;;
    *)
        PROFILE_FILE="$HOME/.profile"
        ;;
esac
if ! echo "$PATH" | grep -q "$BIN_DIR"; then
    if ! grep -qs "$BIN_DIR" "$PROFILE_FILE"; then
        echo "" >> "$PROFILE_FILE"
        echo "# Add Nexus CLI to PATH" >> "$PROFILE_FILE"
        echo "export PATH=\"$BIN_DIR:\$PATH\"" >> "$PROFILE_FILE"
        echo "${GREEN}Updated PATH in $PROFILE_FILE${NC}"
    fi
fi

# Prompt for node ID and thread count, ensuring input from terminal
echo ""
echo "Please provide the following details to start the node:"
echo -n "Enter your node ID: "
read -r node_id </dev/tty
echo -n "Enter max threads (default 8): "
read -r max_threads </dev/tty
max_threads=${max_threads:-8}

# Validate inputs
if [ -z "$node_id" ]; then
    echo "${RED}Error: Node ID cannot be empty.${NC}"
    exit 1
fi
if ! [[ "$max_threads" =~ ^[0-9]+$ ]]; then
    echo "${RED}Error: Max threads must be a number.${NC}"
    exit 1
fi

# Start the node
echo "Starting the node with node ID: $node_id and max threads: $max_threads..."
"$EXECUTABLE" start --node-id "$node_id" --max-threads "$max_threads" --max-difficulty extra_large

echo ""
echo "${GREEN}Installation complete!${NC}"
echo "Node started! For more details, check the Nexus documentation or GitHub repo."
echo "${ORANGE}To get your node ID, visit: https://app.nexus.xyz/nodes${NC}"
echo "Register your user to begin linked proving with the Nexus CLI by: nexus-cli register-user --wallet-address <WALLET_ADDRESS>"
echo "Or follow the guide at https://docs.nexus.xyz/layer-1/testnet/cli-node"
