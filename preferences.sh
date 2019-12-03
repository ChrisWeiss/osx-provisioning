### Apple Dock

# Autohide the Dock right away
defaults write com.apple.Dock autohide -bool true
defaults write com.apple.Dock autohide-time-modifier -float 0

# Disable slow launch animations
defaults write com.apple.Dock launchanim -bool false

# Use faster Genie effect for Window minimize
defaults write com.apple.Dock mineffect -string "genie"

# Minimize all application windows to single icon
defaults write com.apple.Dock minimize-to-application -bool true

# Show progress bars under icons
defaults write com.apple.Dock show-process-indicators -bool true

### Finder Preferences
# TODO: Update contents of sidebar
# Show all files
defaults write com.apple.Finder AppleShowAllFiles -bool true

# Show full path in title bar
defaults write com.apple.Finder _FXShowPosixPathInTitle -bool true

# Show path bar
defaults write com.apple.Finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.Finder ShowStatusBar -bool true

# Spawn Finder windows in new windows, not tabs
defaults weite com.apple.Finder FinderSpawnTab -bool false

# Default search context = current folder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Default new Finder window = home folder
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Default Info panel expanded
defaults write com.apple.finder FXInfoPanesExpanded -dict General -bool true OpenWith -bool true Privileges -bool true

# Default Save Dialog expanded
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Default Print Dialog expanded
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Show item info under icon (IE - disk size)
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Add :FK_StandardViewSettings:IconViewSettings:showItemInfo bool true" "${HOME}/Library/Preferences/com.apple.finder.plist"
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom true" ~/Library/Preferences/com.apple.finder.plist

# Show all extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

### Chrome settings to help w/Logitech Mouse

# Don't go Bck/Fwd with scrollwheel
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

# Dont use Chrome print dialog
defaults write com.google.Chrome DisablePrintPreview -bool true

### Misc OS-X Preferences

# Disable smart-quotes/smart-dashes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Don't put your .DS_store filth on my server
defaults write com.apple.DesktopServices DSDontWriteNetworkStores true
defaults write com.apple.DesktopServices DSDontWriteUSBStores true

# Don't launch Photos when I plug in a camera
defaults write com.apple.ImageCapture disableHotPlug -bool true

# Save screenshots as JPG and disable shadows
defaults write com.apple.ScreenCapture type jpg
defaults write com.apple.ScreenCapture disable-shadow -bool true

# Show Stacks on mouseover
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Faster Expose animation
defaults write com.apple.dock expose-animation-duration -float 0.1

# Exit Print Server when print is done
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# More info on Login screen
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Allow select text in QuickLook
defaults write com.apple.finder QLEnableTextSelection -bool true

# Enable `locate` functionality
launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

# Dont automatically sort Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Replace Siri with Lock Computer on Touchbar
defaults write com.apple.controlstrip "item 3" -string com.apple.system.screen-lock

### Outlook

# Mark as read immediately on selecting message
defaults write ~/Library/Containers/com.microsoft.Outlook/Data/Library/Preferences/com.microsoft.Outlook.plist MarkItemsAsReadPreferencesKey 0
defaults write ~/Library/Containers/com.microsoft.Outlook/Data/Library/Preferences/com.microsoft.Outlook.plist NumberOfSecondsBeforeMarkingAsRead 0

## Misc

# Saner Activity Monitor display defaults
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
defaults write com.apple.ActivityMonitor IconType -int 5
defaults write com.apple.ActivityMonitor ShowCategory -int 0
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# Make TextEdit more generic
defaults write com.apple.TextEdit RichText -int 0
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
defaults write com.apple.TextEdit "TabWidth" '4'

# Expanded DiskUtility functiuonality
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

# Adjust number of items shown in Clipy menu
defaults write com.clipy-app.Clipy.plist kCPYPrefNumberOfItemsPlaceInlineKey -int 10

### iTerm
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.iterm/"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
### Mac App Store

# Expanded Mac App Store functionality
defaults write com.apple.appstore ShowDebugMenu -bool true

