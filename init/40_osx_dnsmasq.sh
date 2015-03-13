# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "dnsmasq needs Homebrew to install." && return 1

local brewPrefix="$(brew --prefix)"


# Symlink the config
ln -sf $DOTFILES/conf/osx/dnsmasq/dnsmasq.conf $brewPrefix/etc/dnsmasq.conf

# Start dnsmasq at startup
sudo cp -fv /usr/local/opt/dnsmasq/*.plist /Library/LaunchDaemons
sudo chown root /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist

# Start now
sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist