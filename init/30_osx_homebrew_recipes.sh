# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Brew recipes need Homebrew to install." && return 1

kegs=(
  liamg/tfsec
  )
brew_tap_kegs

# Homebrew recipes
recipes=(
  ansible
  #ant
  #apr
  #apr-util
  #autoconf
  #automake
  awscli
  bash
  #boost
  #cairo
  cmatrix
  consul
  consul-template
  cowsay
  imagemagick
  #czmq
  #dnsmasq
  docker
  docker-compose
  #docker-machine
  #dvm
  #eot-utils
  ffmpeg
  fontconfig
  fontforge
  freetype
  #gd
  #gdbm
  #gettext
  git
  git-extras
  glib
  go
  gobject-introspection
  gradle
  gpg2
  rbenv/tap/openssl@1.0
  #graphviz
  #harfbuzz
  #highlight
  #hub
  #icu4c
  #id3tool
  jpeg
  jq
  #lame
  lesspipe
  libevent
  libffi
  libpng
  libsodium
  libtiff
  libtool
  libvo-aacenc
  libxml2
  libyaml
  #liquibase
  #lua
  #man2html
  maven
  mysql
  #nmap
  #oniguruma
  openssl
  #p7zip
  #pango
  #pcre
  #php56
  #php56-opcache
  #pixman
  #pkg-config
  #pstree
  python
  readline
  reattach-to-user-namespace
  #sl
  #sqlite
  ssh-copy-id
  terminal-notifier
  tfenv
  #the_silver_searcher
  tmux
  tree
  unar
  unixodbc
  wget
  x264
  xvid
  xz
  #youtube-dl
  #zeromq
  zlib
  vault
  envconsul
  packer
  jenv
  pre-commit
  gawk
  terraform-docs
  tflint
  tfsec
  coreutils
)

brew_install_recipes

# Misc cleanup!

# This is where brew stores its binary symlinks
local binroot="$(brew --config | awk '/HOMEBREW_PREFIX/ {print $2}')"/bin

# htop
if [[ "$(type -P $binroot/htop)" ]] && [[ "$(stat -L -f "%Su:%Sg" "$binroot/htop")" != "root:wheel" || ! "$(($(stat -L -f "%DMp" "$binroot/htop") & 4))" ]]; then
  e_header "Updating htop permissions"
  sudo chown root:wheel "$binroot/htop"
  sudo chmod u+s "$binroot/htop"
fi

# bash
if [[ "$(type -P $binroot/bash)" && "$(cat /etc/shells | grep -q "$binroot/bash")" ]]; then
  e_header "Adding $binroot/bash to the list of acceptable shells"
  echo "$binroot/bash" | sudo tee -a /etc/shells >/dev/null
fi
if [[ "$(dscl . -read ~ UserShell | awk '{print $2}')" != "$binroot/bash" ]]; then
  e_header "Making $binroot/bash your default shell"
  sudo chsh -s "$binroot/bash" "$USER" >/dev/null 2>&1
  e_arrow "Please exit and restart all your shells."
fi
