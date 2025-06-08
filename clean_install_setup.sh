#!/bin/bash

sudo apt install -y git python3-dev python3-pip zsh zsh-autosuggestions zsh-syntax-highlighting nano htop python3-vcstool

chsh -s $(which zsh)
sudo chmod 777 ./setup.sh
sudo chmod 777 ./.zshrc
sudo chmod 777 ./.roboguard_aliases