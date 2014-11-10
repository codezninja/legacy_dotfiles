# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Symlink the config
sudo ln -sf $DOTFILES/conf/osx/httpd/httpd.conf /etc/apache2/httpd.conf
sudo ln -sf $DOTFILES/conf/osx/httpd/httpd-vhosts.conf /etc/apache2/extra/httpd-vhosts.conf