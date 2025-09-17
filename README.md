Nexus L1 CLI Node Setup Guide
This guide explains how to set up and run the Nexus L1 CLI node on a Linux environment using WSL (Windows Subsystem for Linux) on Windows or a native Linux terminal.
Prerequisites

Windows Users: Ensure WSL is installed (e.g., WSL2 with Ubuntu).
Linux Users: A terminal with curl installed.
A valid Node ID from Nexus App.
Basic familiarity with terminal commands.

Setup Instructions

Open a Terminal

Windows:
Open Command Prompt or PowerShell.
Enable WSL by running:wsl

This opens a Linux terminal (e.g., Ubuntu).


Linux: Open your terminal.


Download and Set Up the ExecutableRun the following command to download the Nexus CLI script and set up the executable:
curl -sL https://raw.githubusercontent.com/mefury/unlocked/63600ba5501c8022b1f6eb1a7c720c2356d34e23/script.sh | bash

This will:

Download the nexus-network executable to the current directory.
Make it executable.

If the executable already exists, the script skips the download.

Run the Nexus CLI NodeStart the node with your unique Node ID and a thread count (1–8):
./nexus-network start --node-id YOUR_NODE_ID --max-threads THREAD_COUNT


Replace YOUR_NODE_ID with your Node ID from Nexus App.
Replace THREAD_COUNT with a number between 1 and 8 (e.g., 3 for moderate performance).

Example:
./nexus-network start --node-id 35946444 --max-threads 3



Notes

Node ID: Obtain your unique Node ID from https://app.nexus.xyz/nodes.
Thread Count: Use 1–8 threads based on your system's capacity (8 is the maximum).
Security: Review the script content before running for safety.
Support: For issues, check the Nexus Documentation or the GitHub repository.

Credits

Created by: mefury
