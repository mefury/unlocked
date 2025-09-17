# Nexus L1 CLI Node Setup Guide

This guide explains how to set up and run the Nexus L1 CLI node on a Linux environment using WSL (Windows Subsystem for Linux) on Windows or a native Linux terminal.

## Prerequisites
- **Windows Users**: Ensure WSL is installed (e.g., WSL2 with Ubuntu).
- **Linux Users**: A terminal with `curl` installed.
- A valid **Node ID** from [Nexus App](https://app.nexus.xyz/nodes).
- Basic familiarity with terminal commands.

## Setup Instructions

1. **Open a Terminal**
   - **Windows**:
     1. Open Command Prompt or PowerShell.
     2. Enable WSL by running:
        ```bash
        wsl
        ```
        This opens a Linux terminal (e.g., Ubuntu).
   - **Linux**: Open your terminal.

2. **Download and Set Up the Executable**
   Run the following command to download the Nexus CLI script and set up the executable:
   ```bash
   curl -sL https://raw.githubusercontent.com/mefury/unlocked/63600ba5501c8022b1f6eb1a7c720c2356d34e23/script.sh | bash
   ```
   This will:
   - Download the `nexus-network` executable to the current directory.
   - Make it executable.

   If the executable already exists, the script skips the download.

3. **Run the Nexus CLI Node**
   Start the node with your unique **Node ID** and a thread count (1–8):
   ```bash
   ./nexus-network start --node-id YOUR_NODE_ID --max-threads THREAD_COUNT
   ```
   - Replace `YOUR_NODE_ID` with your Node ID from [Nexus App](https://app.nexus.xyz/nodes).
   - Replace `THREAD_COUNT` with a number between 1 and 8 (e.g., 3 for moderate performance).
   
   **Example**:
   ```bash
   ./nexus-network start --node-id 35946444 --max-threads 3
   ```

## Notes
- **Node ID**: Obtain your unique Node ID from [https://app.nexus.xyz/nodes](https://app.nexus.xyz/nodes).
- **Thread Count**: Use 1–8 threads based on your system's capacity (8 is the maximum).
- **Security**: Review the script content before running for safety.
- **Support**: For issues, check the [Nexus Documentation](https://docs.nexus.xyz/layer-1/testnet/cli-node) or the [GitHub repository](https://github.com/nexus-xyz/nexus-cli).

## Credits
- Created by: [mefury](https://x.com/meefury)
