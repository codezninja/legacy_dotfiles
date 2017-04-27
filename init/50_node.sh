# Load nave- and npm-related functions.
source $DOTFILES/source/50_node.sh

# Install latest stable Node.js, set as default, install global npm modules.
nave_install stable

alias npm-exec='PATH=$(npm bin):$PATH'