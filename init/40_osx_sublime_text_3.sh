# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Ask for the administrator password upfront
sudo -v

# Remove Directories to Symlink
sudo rm -r ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages
sudo rm -r ~/Library/Application\ Support/Sublime\ Text\ 3/Packages

# Symlink the conf files
sudo ln -sf $DOTFILES/conf/sublime-text-3/Installed\ Packages ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages
sudo ln -sf $DOTFILES/conf/sublime-text-3/Packages ~/Library/Application\ Support/Sublime\ Text\ 3/Packages