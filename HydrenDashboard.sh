#!/bin/bash

# Function to display messages
echo_message() {
    echo -e "\033[1;32m$1\033[0m"
}

echo_message "Do you want to install the Skyport HydrenDashboard  ? (yes/no)"

read answer

if [ "$answer" != "yes" ]; then
    echo_message "Installation aborted."
    exit 0
fi

echo_message "* Installed HydrenDashboard"

# The following commands will download the HydrenDash into /etc/hydren and use npm to install the required packages:
curl -O https://ma4z.game-net.site/HYDRENDASH.zip
unzip HYDRENDASH.zip || { echo_message "Failed to change directory to panel"; exit 1; }
mv HydrenDashboard-main hydren
cd hydren/
mv .env_example .env
npm install
clear

echo_message "* Setup Settings"

#Then you need to Setup the .env file Having all Things
nano .env

echo_message "* Starting HydrenDashboard"

# Start the Skyport
node .