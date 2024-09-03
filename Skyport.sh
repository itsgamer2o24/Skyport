#!/bin/bash

# Function to display messages
echo_message() {
    echo -e "\033[1;32m$1\033[0m"
}

echo_message "Do you want to install the panel? (yes/no)
   ______                      __                       __
  / __/ /____ _____  ___  ____/ /_  ___  ___ ____  ___ / /
 _\ \/  '_/ // / _ \/ _ \/ __/ __/ / _ \/ _ \` _ \/ -_) / 
/___/_/\_\\_, / .__/\___/_/  \__/ / .__/\_,_/_//_/\__/_/  
         /___/_/                 /_/                      "
read answer

if [ "$answer" != "yes" ]; then
    echo_message "Installation aborted."
    exit 0
fi

echo_message "* Installing Sudo"

# Update package list and install dependencies
sudo apt update
sudo apt install -y nodejs
node -v
clear

echo_message "* Installed Panel"

# Create directory, clone repository, and install files
git clone --branch v0.2.1 https://github.com/skyportlabs/panel
cd panel || { echo_message "Failed to change directory to panel"; exit 1; }
git branch
git switch -c v0.2.1
clear

echo_message "* Installed Skyport"

# Create directory, clone repository, and install files
cd ..
mv panel skyport
cd skyport/
npm install
clear

echo_message "* Create The User"

# Run setup scripts
npm run seed
npm run createUser
clear

echo_message "* Skyport Installed and Started on Port 3001"

echo_message "* Starting Skyport"

# Start the Skyport
node .
