# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Brew casks need Homebrew to install." && return 1

# Ensure the cask keg and recipe are installed.
kegs=(
  caskroom/cask
  caskroom/versions
  caskroom/fonts
  homebrew/dupes
  )
brew_tap_kegs
# recipes=(brew-cask)
# brew_install_recipes

# # Exit if, for some reason, cask is not installed.
# [[ ! "$(brew ls --versions brew-cask)" ]] && e_error "Brew-cask failed to install." && return 1

# Hack to show the first-run brew-cask password prompt immediately.
brew cask info this-is-somewhat-annoying 2>/dev/null

# adobe-creative-cloud      cleanmymac      google-chrome       launchrocket    skype         transmit
# alfred          colorpicker-skalacolor  google-drive        mongohub (!)    sourcetree        tvshows
# appcleaner        dropbox     gopro-studio        onepassword (!)   spectacle       vagrant
# bartender       evernote      imageoptim        path-finder     sublime-text3       virtualbox
# caffeine        fantastical     java7         quicklook-csv   synergy         virtualhostx
# charles         firefox     jing          radiant-player    teamviewer        viscosity
# chromium        flash     kaleidoscope        remote-desktop-connection totals2         vlc
# clamxav         github      ksdiff          sequel-pro      transmission        xscope

# Homebrew casks
casks=(
  # betterzipql
  # Color pickers
  # colorpicker-developer
  # qlcolorcode
  # qlmarkdown
  # qlprettypatch
  # qlstephen
  # Quick Look plugins
  # quicklook-csv
  # quicklook-json
  # quicknfo
  # suspicious-package
  # tvshows
  # webp-quicklook
  alfred
  android-file-transfer
  android-platform-tools
  android-sdk
  appcleaner
  bartender
  resilio-sync
  # Applications
  1password
  a-better-finder-rename
  aluxian-messenger
  battle-net
  bettertouchtool
  charles
  chromium
  clamxav
  cleanmymac
  codekit
  colorpicker-skalacolor
  cornerstone
  dash
  dropbox
  dropzone
  evernote
  fantastical
  fastscripts
  firefox
  github
  google-chrome
  google-drive-file-stream
  growlnotify
  handbrake
  hipchat
  imageoptim
  intellij-idea
  iterm2
  java
  jeromelebel-mongohub
  kaleidoscope
  keepingyouawake
  launchrocket
  little-snitch
  macdown
  path-finder
  postbox
  quicklook-csv
  radiant-player
  sequel-pro
  skype
  slack
  sourcetree
  spectacle
  ssh-tunnel-manager
  sublime-text
  suspicious-package
  teamviewer
  totals2
  transmission
  transmit
  vagrant
  vagrant-manager
  virtualbox
  viscosity
  vlc
  waltr
  whatsapp
  xquartz
  xscope

  #Fonts
  font-source-code-pro
  font-source-code-pro-for-powerline
  gyazo
  hermes
  hex-fiend
  karabiner
  launchbar
  macvim
  midi-monitor
  moom
  omnidisksweeper
  race-for-the-galaxy
  reaper
  spotify
  steam
  the-unarchiver
  tower
  transmission-remote-gui
  tunnelblick
  ynab
  # Drivers
  qlcolorcode
  qlmarkdown
  qlprettypatch
  qlstephen
  quicklook-json
  quicknfo
  webpquicklook
  colorpicker-developer
  divvy
)

# Install Homebrew casks.
casks=($(setdiff "${casks[*]}" "$(brew cask list 2>/dev/null)"))
if (( ${#casks[@]} > 0 )); then
  e_header "Installing Homebrew casks: ${casks[*]}"
  for cask in "${casks[@]}"; do
    brew cask install $cask
  done
  brew cask cleanup
fi

# Work around colorPicker symlink issue.
# https://github.com/caskroom/homebrew-cask/issues/7004
cps=()
for f in ~/Library/ColorPickers/*.colorPicker; do
  [[ -L "$f" ]] && cps=("${cps[@]}" "$f")
done

if (( ${#cps[@]} > 0 )); then
  e_header "Fixing colorPicker symlinks"
  for f in "${cps[@]}"; do
    target="$(readlink "$f")"
    e_arrow "$(basename "$f")"
    rm "$f"
    cp -R "$target" ~/Library/ColorPickers/
  done
fi
