# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Brew casks need Homebrew to install." && return 1

# Ensure the cask keg and recipe are installed.
kegs=(
  caskroom/cask
  caskroom/versions
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
  # Applications
  appcleaner
  caffeine
  firefox
  google-chrome
  launchrocket
  quicklook-csv
  skype
  vagrant
  charles
  dropbox
  flash
  kaleidoscope
  jeromelebel-mongohub
  radiant-player
  sourcetree
  virtualbox
  chromium
  evernote
  github
  ksdiff
  1password-beta
  sequel-pro
  synergy
  sublime-text3
  vlc
  alfred
  bartender
  clamxav
  cleanmymac
  colorpicker-skalacolor
  fantastical
  google-drive
  imageoptim
  jing
  path-finder
  remote-desktop-connection
  spectacle
  teamviewer
  totals2
  transmission
  transmit
  # tvshows
  virtualhostx
  viscosity
  xscope
  # Quick Look plugins
  # betterzipql
  # qlcolorcode
  # qlmarkdown
  # qlprettypatch
  # qlstephen
  # quicklook-csv
  # quicklook-json
  # quicknfo
  # suspicious-package
  # webp-quicklook
  # Color pickers
  # colorpicker-developer
  colorpicker-skalacolor
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
