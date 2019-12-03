# osx-provisioning
Brewfile and shell script to set up a clean OS-X machine just how I like it.

This is a Brewfile containing my currently installed apps and a shell script that sets a whole slew of OS-X preferences the way I like them. Feel free to steal/modify this for your own needs. You will need to have purchased the app store apps listed in the current Brewfile to install them (sorry, no free lunch there).

# System Restore Notes

Assumptions:

1. You have backed up key files in `~/Libraries/Application Data`. Note that if you're using Box, you'll need to archive the folder as hidden and dotfiles aren't always captured. (Nike's policies forbid the use of external USB drives.)

1. You have backed up critical files in your home folder. I recommend storing your 'global' configuration files in Git following the pattern outlined here: <https://www.atlassian.com/git/tutorials/dotfiles> (or similar). Make sure you also back up 'local' configuration files as well. Again, Box does not play well with hidden/dotfiles. You'll want to Zip everything or rename to not be dotfiles.

1. You are backing up your IDE settings - This tutorial has information for restoring VSCode settings assuming you are using the [code-sync-settings plugin](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync) to store your configuration in a private Gist. Similar tools exist for IntelliJ and Atom as well.

1. You've backed up your latest list of packages installed via Mac App Store and Homebrew. You can do this with the Brew Bundle command: `brew bundle dump --all  --describe`

## Restore disk backup

Pull what you need from `~/Libraries/Application Data`

## Deploy SSH keys

You need to have backed up your SSH keys (you did that, right?). Update your public key in bitbucket/github/etc.

## Log in to Mac App Store

You'll need to have activated your account on the MAS to do the Homebrew restore.

## Homebrew

### Install Homebrew

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## Install packages

This assumes you have a `Brewfile` in the current folder. This will take a long time.

```bash
brew bundle
```

## Install oh-my-zsh

As per the documentation.

```bash
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
Because the included Brewfile installs a newer version of `zsh` in `/usr/local/bin`, you'll need to update `/etc/shells`.

Add `/usr/local/bin/zsh` to `/etc/shells`

Once installed, you'll want to change the shell to the newer version of `zsh` that was installed by `Homebrew`.

```bash
chsh
```

## Install dotfiles

I manage my dotfiles using the process outlined here: <https://www.atlassian.com/git/tutorials/dotfiles>.
The shortened URL below points to a Gist script that deploys my own dotfiles. You will want to use your own Gist/URL.

```bash
curl -Lks https://git.io/fj2B6 | /bin/bash
```

## Finish fzf setup (be sure to include the leading $)
```bash
$(brew --prefix fzf)/install --all
```

## Configure VS Code

The assumption is that you are using the code-sync-settings plugin to store your settings in a Gist. The below will install the plugin from the command line and set the preferences to sync on launch.

### Add VSCode to the path

This allows us to launch from the command line.

```bash
cat << EOF >> ~/.bash_profile
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF
```

### Install the code-settings-sync plugin

```bash
code --install-extension shan.code-settings-sync
```

## Configure for your settings Gist

*This may no longer be required - the latest plugin will capture your info if you log in to github while it's active??*

Create Personal Access Token per: <https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync>

Add the following to settings.json:

```plist
{
    "sync.gist": "[GIST Token]",
    "sync.autoDownload": true
}
```

## Set OS-X Configuration Defaults

Run `preferences.sh`. This will write a whole bunch of plist updates. You'll need to enter your admin password at some point, so don't walk away.

```bash
preferences.sh
```
Then reboot and you should be good to go.

## Items that still need to be done manually

1. Enroll fingerprint and set to login/unlock authentication
1. Map CapsLock to Control - This requires knowing the keyboard ID which could be attached to an external keyboard. TODO: Write loops to do all instantiated keyboards.
1. Launch all the apps and set them to launch at startup, insert your credentials, etc.




# Details

## Plist tweaks

This is a large collection of exposed `.plist` configuration options. Use them as needed. These are all executed from a CLI as the current user.

### References

<https://github.com/rockyluke/osx-cli>
<https://gist.github.com/tylerwalts/9375263>
<https://github.com/donnemartin/dev-setup/blob/master/osx.sh>
<https://github.com/joeyhoer/starter/blob/master/apps/finder.sh>
<https://mosen.github.io/profiledocs/index.html>
<https://www.intego.com/mac-security-blog/unlock-the-macos-docks-hidden-secrets-in-terminal/>
<https://www.defaults-write.com/>
<https://groups.google.com/forum/#!topic/macenterprise/Ks-zHlY3h5I>

```bash
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

# Enable using Ctrl-Cmd-Opt-T to toggle Dark Mode (requires restart to instantiate)
sudo defaults write /Library/Preferences/.GlobalPreferences.plist _HIEnableThemeSwitchHotKey -bool true

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
```

## Install BetterZip QuickLook

There's not a Brewfile for this, so I install it manually. Unzip and copy the qlgenerator file to `~/Library/QuickLook/` then either log out or run `qlmanage -r` to reload the QuickLook plugins.

```bash
https://macitbetter.com/dl/BetterZipQL-1.5.zip
```

# Dock modifications

## Add an item to the dock

Repeat as needed. The below example is for Chrome. To add an item to the Files section of the dock (next to the trash can and folders shortcuts), change `persistent-apps` to `persistant-files`..

```bash
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Google Chrome.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
```

To add a space:

```bash
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
```

## Only display running apps in dock

Basically turns it into a task manager rather than a quick-launch tool. Helpful if you've muscle-memorized using Spotlight to launch apps.

```bash
defaults write com.apple.dock single-app -bool true
```

## Highlight hidden apps in Dock

This will add a highlight to apps that have been Hidden (Apple-H)

```bash
defaults write com.apple.Dock showhidden -bool yes
```

## Restart Dock

```bash
killall Dock;
```

## Restart Finder

Now that you've made all these changes, time to reload Finder and instantiate them.

```bash
sudo killall Finder
```

# Enable fingerprint auth for sudo

You can set up sudo to use fingerprint authentication. CRITICAL!! This will disable sudo if you remote in to the machine since you cant remotely fingerprint authenticate.

Edit `/etc/pam.d/sudo` and add the following line to the top

`auth sufficient pam_tid.so`


~~
