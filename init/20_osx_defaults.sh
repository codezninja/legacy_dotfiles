# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `20_osx_defaults.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

#Turn off keyboard illumination when computer is not used for 5 minutes
defaults write com.apple.BezelServices kDimTime -int 300

#Set Clock
defaults write com.apple.menuextra.clock DateFormat -string 'EEE MMM d h:mm:ss a'

#Enable Dark mode
sudo defaults write /Library/Preferences/.GlobalPreferences.plist _HIEnableThemeSwitchHotKey -bool true

# Show remaining battery percentage
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
defaults write com.apple.menuextra.battery ShowTime -string "YES"

###############################################################################
# Screen                                                                      #
###############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0


###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Automatically illuminate built-in MacBook keyboard in low light
defaults write com.apple.BezelServices kDim -bool true


###############################################################################
# Dock                                                                        #
###############################################################################

#Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36

#Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

#Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true


###############################################################################
# Mail                                                                        #
###############################################################################

# Disable send and reply animations in Mail.app
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
#defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" -string "@\\U21a9"

# Display emails in threaded mode, sorted by date (oldest at the top)
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

# Disable inline attachments (just show the icons)
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true


###############################################################################
# Terminal                                                                    #
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Use a modified version of the Solarized Dark theme by default in Terminal.app
TERM_PROFILE='Homebrew';
CURRENT_PROFILE="$(defaults read com.apple.terminal 'Default Window Settings')";
if [ "${CURRENT_PROFILE}" != "${TERM_PROFILE}" ]; then
    open "${DOTFILES}/conf/terminal/${TERM_PROFILE}";
    sleep 1; # Wait a bit to make sure the theme is loaded
    defaults write com.apple.terminal 'Default Window Settings' -string "${TERM_PROFILE}";
    defaults write com.apple.terminal 'Startup Window Settings' -string "${TERM_PROFILE}";
fi;


###############################################################################
# Time Machine                                                                #
###############################################################################

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true


###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
    "Dock" "Finder" "Mail" "Messages" "Safari" "SizeUp" "SystemUIServer" \
    "Transmission" "Twitter" "iCal"; do
    killall "${app}" > /dev/null 2>&1
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
