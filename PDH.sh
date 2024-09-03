#!/bin/bash

# Function to display messages
echo_message() {
    echo -e "\033[1;32m$1\033[0m"
}

echo_message "Do you want to install the Panel,Daemon and HydrenDashboard ? (yes/no)"
read answer

if [ "$answer" != "yes" ]; then
    echo_message "Installation aborted."
    exit 0
fi

echo_message "* Installing Dependencies"

# Update package list and install dependencies
sudo apt update
sudo apt install -y curl software-properties-common
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install nodejs -y 
sudo apt install git -y
clear

echo_message "* Installed Panel"

# Create directory, clone repository, and install files
git clone --branch v0.2.1 https://github.com/skyportlabs/panel
cd panel/ || { echo_message "Failed to change directory to skyport"; exit 1; }
git branch
git switch -c v0.2.1
clear

echo_message "* Installed Skyport"

#create a n6de
cd ..
mv panel skyport
cd skyport/
npm install
clear

echo_message "* Starting Skyport"

# Run setup scripts
npm run seed
npm run createUser
clear

echo_message "* Starting Skyport With PM2"

# Install PM2 and start the application
sudo npm install -g pm2
pm2 start index.js

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

echo_message "* Installed Node"

# Create directory, clone repository, and install files
git clone --branch v0.2.2 https://github.com/skyportlabs/skyportd
cd skyportd/ || { echo_message "Failed to change directory to panel"; exit 1; }
git branch
git switch -c v0.2.2
clear

echo_message "* Installed Daemon"

# Create directory, clone repository, and install files
git branch
vi config.json #:q1
npm install
clear

echo_message "* Use this first { cd skyportd/ }"

echo_message "* Get your Panel's access key from the Skyport panel's config.json file and set it as 'remoteKey'. Do the same for the other way, set your skyportd access key and configure it on the Panel."

echo_message "* You done use this mcd { pm2 start . }"

echo_message "* Skyport Installed and Started on Port 3001"
