#!/bin/bash

# Function to display messages
echo_message() {
    echo -e "\033[1;32m$1\033[0m"
}

echo_message "Do you want to install the Skyport Daemon (skyportd) ? (yes/no)"
read answer

if [ "$answer" != "yes" ]; then
    echo_message "Installation aborted."
    exit 0
fi

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


echo_message "* Use this first ( cd skyportd/ )"

echo_message "* Get your Panel's access key from the Skyport panel's config.json file and set it as 'remoteKey'. Do the same for the other way, set your skyportd access key and configure it on the Panel."

echo_message "* You done use this ( node . )" 
