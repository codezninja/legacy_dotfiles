# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Brew casks need Homebrew to install." && return 1

# Ensure the cask keg and recipe are installed.
kegs=(
  caskroom/cask
  caskroom/versions
  caskroom/fonts
  )
brew_tap_kegs
recipes=(brew-cask)
brew_install_recipes

# Exit if, for some reason, cask is not installed.
[[ ! "$(brew ls --versions brew-cask)" ]] && e_error "Brew-cask failed to install." && return 1

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
  1password-beta
  alfred
  android-file-transfer
  appcleaner
  appdelete
  bartender
  bittorrent-sync
  caffeine
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
  firefox
  flash
  github
  google-chrome
  google-drive
  gopro-studio
  growlnotify
  imageoptim
  jeromelebel-mongohub
  jing
  kaleidoscope
  ksdiff
  launchrocket
  little-snitch
  macdown
  packer
  path-finder
  postbox
  quicklook-csv
  radiant-player
  remote-desktop-connection
  sequel-pro
  skype
  slack
  sourcetree
  spectacle
  ssh-tunnel-manager
  sublime-text3
  teamviewer
  totalfinder
  totals2
  transmission
  transmit
  vagrant
  vagrant-manager
  virtualbox
  viscosity
  vlc
  waltr
  xquartz
  xscope
  xscope3

  #Fonts
  font-source-code-pro
  font-source-code-pro-for-powerline
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
