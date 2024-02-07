#!/usr/bin/env bash

eval "$(/opt/homebrew/bin/brew shellenv)"


# Import Prompt config
source ~/.bash_prompt

# Import NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# Supress warning
export BASH_SILENCE_DEPRECATION_WARNING=1

