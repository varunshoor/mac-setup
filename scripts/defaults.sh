#!/bin/bash

source utils.sh

# ------------------------------------------------------------------------------
e_message "Creating defaults"
# ------------------------------------------------------------------------------

# Dock
get_consent "Autohide Dock"
if has_consent; then
  e_pending "Autohiding Dock"
  defaults write com.apple.dock autohide -boolean true
  killall Dock
fi

get_consent "Reduce dock auto hide animation"
if has_consent; then
  e_pending "Reducing Dock auto hide animation"
  defaults write com.apple.dock autohide-time-modifier -float 0.25
  killall Dock
fi

get_consent "Remove Dock Delay for Auto Hide & Auto-Show"
if has_consent; then
  e_pending "Removing Dock delay"
  defaults write com.apple.dock autohide-delay -float 0
  killall Dock
fi

get_consent "Set the icon size of Dock items to 63 pixels"
if has_consent; then
  e_pending "Setting Dock icon size to 63 pixels"
  defaults write com.apple.dock tilesize -int 63
  killall Dock
fi

# Finder
get_consent "Display hidden Finder files/folders"
if has_consent; then
  e_pending "Displaying hidden Finder files/folders"
  defaults write com.apple.finder AppleShowAllFiles -boolean true
  killall Finder
fi

get_consent "Update other Finder settings"
if has_consent; then
  e_pending "Updating other Finder settings"

  # Show items on desktop
  defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
  defaults write com.apple.finder ShowMountedServersOnDesktop -bool true

  # Set new Finder windows to open to Downloads folder
  defaults write com.apple.finder NewWindowTarget -string "PfLo"
  defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Downloads/"

  # Disable iCloud Desktop & Documents sync
  defaults write com.apple.finder FXICloudDriveDesktop -bool false
  defaults write com.apple.finder FXICloudDriveDocuments -bool false

  # Open folders in tabs instead of new windows
  defaults write com.apple.finder FinderSpawnTab -bool true

  # Favorites
  defaults write com.apple.sidebarlists systemitems -dict-add ShowRecentTags -bool true
  defaults write com.apple.sidebarlists favoriteritems -dict-add ShowRecents -bool true
  defaults write com.apple.sidebarlists favoriteritems -dict-add ShowAirDrop -bool true
  defaults write com.apple.sidebarlists favoriteritems -dict-add ShowApplications -bool true
  defaults write com.apple.sidebarlists favoriteritems -dict-add ShowDesktop -bool true
  defaults write com.apple.sidebarlists favoriteritems -dict-add ShowDocuments -bool true
  defaults write com.apple.sidebarlists favoriteritems -dict-add ShowDownloads -bool true
  defaults write com.apple.sidebarlists favoriteritems -dict-add ShowMovies -bool false
  defaults write com.apple.sidebarlists favoriteritems -dict-add ShowMusic -bool false
  defaults write com.apple.sidebarlists favoriteritems -dict-add ShowPictures -bool false
  defaults write com.apple.sidebarlists favoriteritems -dict-add ShowHome -bool true

  # iCloud
  defaults write com.apple.sidebarlists clouditems -dict-add ShowiCloudDrive -bool true
  defaults write com.apple.sidebarlists clouditems -dict-add ShowShared -bool true

  # Locations
  defaults write com.apple.sidebarlists networkitems -dict-add ShowHardDisks -bool false
  defaults write com.apple.sidebarlists networkitems -dict-add ShowExternalDisks -bool true
  defaults write com.apple.sidebarlists networkitems -dict-add ShowRemovableMedia -bool true
  defaults write com.apple.sidebarlists networkitems -dict-add ShowCloudStorage -bool true
  defaults write com.apple.sidebarlists networkitems -dict-add ShowBonjour -bool true
  defaults write com.apple.sidebarlists networkitems -dict-add ShowConnectedServers -bool true

  # Restart Finder to apply changes
  killall Finder
fi

# Keyboard
get_consent "Enabling full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
if has_consent; then
  e_pending "Enabling full keyboard access"
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
fi

get_consent "Enable Function Keys"
if has_consent; then
  e_pending "Enabling Function Keys"
  defaults write -g com.apple.keyboard.fnState -bool true
fi

# Keyboard Shortcuts
get_consent "Set Custom Screenshot Keyboard Shortcuts"
if has_consent; then
  e_pending "Setting Custom Screenshot Keyboard Shortcuts"

  # Configure screenshot keyboard shortcuts
  defaults write com.apple.screencapture "kb-screenshot-file" -string "^⇧$4"          # Save picture of screen as a file
  defaults write com.apple.screencapture "kb-screenshot-clipboard" -string "⇧$4"      # Copy picture of screen to clipboard
  defaults write com.apple.screencapture "kb-screenshot-area-file" -string "^⇧$3"     # Save picture of selected area as a file
  defaults write com.apple.screencapture "kb-screenshot-area-clipboard" -string "⇧$3" # Copy picture of selected area to clipboard
  defaults write com.apple.screencapture "kb-screenshot-options" -string "⇧$5"        # Screenshot and recording options

  # Restart SystemUIServer to apply changes
  killall SystemUIServer
fi

get_consent "Disable Spotlight Keyboard Shortcuts"
if has_consent; then
  e_pending "Disabling Spotlight Keyboard Shortcuts"
  # Disable Spotlight search shortcut (⌘Space)
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "{ enabled = 0; value = { parameters = (32, 49, 1048576); type = standard; }; }"

  # Disable Finder search window shortcut (⌃⌘Space)
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 65 "{ enabled = 0; value = { parameters = (32, 49, 1572864); type = standard; }; }"

  # Restart SystemUIServer to apply changes
  killall SystemUIServer
fi

get_consent "Update Mission Control Keyboard Shortcuts"
if has_consent; then
  e_pending "Updating Mission Control Keyboard Shortcuts"

  # Disable Move left/right space shortcuts
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 79 "{ enabled = 0; value = { parameters = (65535, 123, 11796480); type = standard; }; }"
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 81 "{ enabled = 0; value = { parameters = (65535, 124, 11796480); type = standard; }; }"

  # Enable Switch to Desktop shortcuts
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 118 "{ enabled = 1; value = { parameters = (49, 18, 11796480); type = standard; }; }" # Desktop 1 (^⌥1)
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 119 "{ enabled = 1; value = { parameters = (50, 19, 11796480); type = standard; }; }" # Desktop 2 (^⌥2)
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 120 "{ enabled = 1; value = { parameters = (51, 20, 11796480); type = standard; }; }" # Desktop 3 (^⌥3)
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 121 "{ enabled = 1; value = { parameters = (52, 21, 11796480); type = standard; }; }" # Desktop 4 (^⌥4)

  # Restart SystemUIServer to apply changes
  killall SystemUIServer
fi

# Text Replacements
get_consent "Add custom text replacements"
if has_consent; then
  e_pending "Adding custom text replacements"

  # Check if text replacement exists before adding
  if ! defaults read -g NSUserDictionaryReplacementItems | grep -q "varun.shoor@gmail.com"; then
    defaults write -g NSUserDictionaryReplacementItems -array-add '{
      on = 1;
      replace = "@@";
      with = "varun.shoor@gmail.com";
    }'
  fi

  # Force text replacement database to update
  killall cfprefsd
fi

# Keyboard Misc
get_consent "Disable auto-correct"
if has_consent; then
  e_pending "Disabling auto-correct"
  defaults write -g NSAutomaticSpellingCorrectionEnabled -boolean false
fi

get_consent "Disable auto-capitalization"
if has_consent; then
  e_pending "Disabling auto-capitalization"
  defaults write -g NSAutomaticCapitalizationEnabled -boolean false
fi

get_consent "Set a fast keyboard repeat rate"
if has_consent; then
  e_pending "Setting fast keyboard repeat rate"
  defaults write -g KeyRepeat -int 2
  defaults write -g InitialKeyRepeat -int 15
fi

get_consent "Allow text selection in Quick Look"
if has_consent; then
  e_pending "Allowing text selection in Quick Look"
  defaults write com.apple.finder QLEnableTextSelection -boolean true
fi

get_consent "Disable add fullstop with double space"
if has_consent; then
  e_pending "Disabling add fullstop with double space"
  defaults write -g NSAutomaticPeriodSubstitutionEnabled -boolean false
fi

# Safari
get_consent "Don't open files in Safari after downloading"
if has_consent; then
  e_pending "Disabling auto-open in Safari"
  defaults write com.apple.Safari AutoOpenSafeDownloads -boolean false
fi

get_consent "Don't prompt for confirmation before downloading"
if has_consent; then
  e_pending "Disabling download confirmation in Safari"
  defaults write com.apple.Safari SuppressPromptForDownload -boolean true
fi

get_consent "Show Develop menu in Safari"
if has_consent; then
  e_pending "Showing Develop menu in Safari"
  defaults write com.apple.Safari IncludeDevelopMenu -boolean true
  defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
  defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
fi

get_consent "Adding a context menu item for showing the Web Inspector in web views"
if has_consent; then
  e_pending "Adding Web Inspector context menu item"
  defaults write NSGlobalDomain WebKitDeveloperExtras -boolean true
fi

get_consent "Making Safari's search banners default to Contains instead of Starts With"
if has_consent; then
  e_pending "Setting Safari search banners to Contains"
  defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -boolean false
fi

get_consent "Removing useless icons from Safari's bookmarks bar"
if has_consent; then
  e_pending "Removing useless icons from Safari's bookmarks bar"
  defaults write com.apple.Safari ProxiesInBookmarksBar "()"
fi

get_consent "Update other Safari Settings"
if has_consent; then
  e_pending "Updating other Safari settings"

  # Set Safari's home page to `about:blank` for faster loading
  defaults write com.apple.Safari HomePage -string "about:blank"
  # Set homepage to about:blank
  defaults write com.apple.Safari HomePage -string "about:blank"

  # Set history removal to after two weeks (1209600 seconds)
  defaults write com.apple.Safari HistoryAgeInDaysLimit -int 14

  # Set new windows and tabs to open with empty page
  # 0 = Top Sites
  # 1 = Homepage
  # 4 = Empty Page
  # 5 = Same Page
  defaults write com.apple.Safari NewWindowBehavior -int 4
  defaults write com.apple.Safari NewTabBehavior -int 4

  # Set Safari to open with windows from last session
  # 1 = New Window
  # 2 = New Private Window
  # 3 = All windows from last session
  defaults write com.apple.Safari AlwaysRestoreSessionAtLaunch -bool true

  # Prevent Safari from opening 'safe' files automatically after downloading
  defaults write com.apple.Safari AutoOpenSafeDownloads -boolean false

  # Enable the Develop menu and the Web Inspector in Safari
  defaults write com.apple.Safari IncludeDevelopMenu -boolean true
  defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -boolean true
  defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -boolean true

  # Add a context menu item for showing the Web Inspector in web views
  defaults write NSGlobalDomain WebKitDeveloperExtras -boolean true

  # Update Safari settings
  defaults write com.apple.Safari ShowFavoritesBar -boolean false
  defaults write com.apple.Safari ShowSidebarInTopSites -boolean false
  defaults write com.apple.Safari ShowSidebarInNewWindows -boolean false
  defaults write com.apple.Safari ShowSidebar -boolean false
  defaults write com.apple.Safari SendDoNotTrackHTTPHeader -boolean true
  defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -boolean true
  defaults write com.apple.Safari ShowFullURLInSmartSearchField -boolean true
  defaults write com.apple.Safari SuppressSearchSuggestions -boolean true
  defaults write com.apple.Safari UniversalSearchEnabled -boolean false
  # Restart Safari for changes to take effect
  killall Safari
fi

get_consent "Disable the warning when changing a file extension"
if has_consent; then
  e_pending "Disabling file extension warning"
  defaults write com.apple.finder FXEnableExtensionChangeWarning -boolean false
fi

get_consent "Finder Search always searches current folder by default"
if has_consent; then
  e_pending "Setting Finder search to current folder"
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
fi

get_consent "Finder Show Status Bar"
if has_consent; then
  e_pending "Showing Finder status bar"
  defaults write com.apple.finder ShowStatusBar -boolean true
fi

get_consent "Finder Show Path Bar"
if has_consent; then
  e_pending "Showing Finder path bar"
  defaults write com.apple.finder ShowPathbar -boolean true
fi

get_consent "Finder Show Tab Bar"
if has_consent; then
  e_pending "Showing Finder tab bar"
  defaults write com.apple.finder ShowTabView -boolean true
fi

get_consent "Always expand Save Panel by default"
if has_consent; then
  e_pending "Expanding Save Panel by default"
  defaults write -g NSNavPanelExpandedStateForSaveMode -boolean true
fi

get_consent "Default save location is Disk, not iCloud"
if has_consent; then
  e_pending "Setting default save location to Disk"
  defaults write -g NSDocumentSaveNewDocumentsToCloud -boolean false
fi

get_consent "Disable the warning before emptying the Trash"
if has_consent; then
  e_pending "Disabling Trash empty warning"
  defaults write com.apple.finder WarnOnEmptyTrash -boolean false
fi

# Printer
get_consent "Always expand print panel by default"
if has_consent; then
  e_pending "Expanding print panel by default"
  defaults write -g PMPrintingExpandedStateForPrint -boolean true
  defaults write -g PMPrintingExpandedStateForPrint2 -boolean true
fi

get_consent "Automatically quit printer app once the print jobs complete"
if has_consent; then
  e_pending "Automatically quitting printer app"
  defaults write com.apple.print.PrintingPrefs "Quit When Finished" -boolean true
fi

get_consent "Play user interface sound effects OFF"
if has_consent; then
  e_pending "Disabling user interface sound effects"
  defaults write -g com.apple.sound.uiaudio.enabled -boolean false
fi

get_consent "Disable feedback when volume is changed"
if has_consent; then
  e_pending "Disabling volume feedback"
  defaults write -g com.apple.sound.beep.feedback -boolean false
fi

# Menu Bar
get_consent "Automatically hide and show the menu bar"
if has_consent; then
  e_pending "Automatically hiding and showing the menu bar"
  defaults write NSGlobalDomain _HIHideMenuBar -boolean true
fi

get_consent "Show date and time in menu bar"
if has_consent; then
  e_pending "Showing date and time in menu bar"
  # Only add Clock if not already present
  if ! defaults read com.apple.systemuiserver menuExtras | grep -q "Clock.menu"; then
    defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Clock.menu"
  fi

  # Include date in the menu bar (System Preferences | Date & Time | Clock)
  # https://apple.stackexchange.com/questions/180847/wrong-date-format-in-the-menu-bar
  defaults write com.apple.menuextra.clock "DateFormat" 'EEE MMM d  h:mm a'
fi

get_consent "Show Volume in menu bar"
if has_consent; then
  e_pending "Showing Volume in menu bar"
  # Only add Volume if not already present
  if ! defaults read com.apple.systemuiserver menuExtras | grep -q "Volume.menu"; then
    defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Volume.menu"
  fi
fi

get_consent "Update battery settings in menu bar"
if has_consent; then
  e_pending "Updating battery settings in menu bar"
  # Show battery percentage in menu bar
  defaults write com.apple.menuextra.battery ShowPercent -bool true

  # Show battery in menu bar
  defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool true

  # Show in Control Center
  defaults write com.apple.controlcenter Battery -bool true
fi

get_consent "Disable Spotlight in Menu Bar"
if has_consent; then
  e_pending "Disabling Spotlight in Menu Bar"
  defaults write com.apple.Spotlight MenuItemHidden -int 1
fi

get_consent "Restart menu bar"
if has_consent; then
  e_pending "Restarting menu bar"
  killall SystemUIServer
  killall ControlCenter
fi

# Time and Date
get_consent "Disable 24 Hour Time"
if has_consent; then
  e_pending "Disabling 24 Hour Time"
  defaults write NSGlobalDomain AppleICUForce12HourTime -bool true
fi

get_consent "Enable Night Shift"
if has_consent; then
  e_pending "Enabling Night Shift"
  defaults write /Library/Preferences/com.apple.CoreDisplay nightShift -boolean true
fi

get_consent "Disable Stage Manager"
if has_consent; then
  e_pending "Disabling Stage Manager"
  defaults write com.apple.dock mcx-expose-disabled -boolean true
fi

get_consent "Default Finder view is Column"
if has_consent; then
  e_pending "Setting default Finder view to Column"
  defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
fi

get_consent "Setup Hot Corners"
if has_consent; then
  e_pending "Setting up Hot Corners"

  # Set Top Left (position 0) to Start Screen Saver (5)
  defaults write com.apple.dock wvous-tl-corner -int 5
  defaults write com.apple.dock wvous-tl-modifier -int 0

  # Set Top Right (position 1) to Disable Screen Saver (6)
  defaults write com.apple.dock wvous-tr-corner -int 6
  defaults write com.apple.dock wvous-tr-modifier -int 0

  # Bottom Left: Desktop
  defaults write com.apple.dock wvous-bl-corner -int 4
  defaults write com.apple.dock wvous-bl-modifier -int 0
  killall Dock
fi

get_consent "Disable Dock magnification"
if has_consent; then
  e_pending "Disabling Dock magnification"
  defaults write com.apple.dock magnification -boolean false
  killall Dock
fi

get_consent "Don't load remote content in Mail by default"
if has_consent; then
  e_pending "Disabling remote content in Mail"
  defaults write com.apple.mail-shared DisableURLLoading -boolean true
fi

get_consent "Don’t automatically rearrange Spaces based on most recent use"
if has_consent; then
  e_pending "Disabling Spaces rearrangement"
  defaults write com.apple.dock mru-spaces -boolean false
  killall Dock
fi

get_consent "Disable displays have separate spaces"
if has_consent; then
  e_pending "Disabling displays have separate spaces"
  defaults write com.apple.spaces spans-displays -boolean false
fi

get_consent "Enable switching to space of application"
if has_consent; then
  e_pending "Enabling switching to space of application"
  defaults write -g AppleSpacesSwitchOnActivate -boolean true
fi

get_consent "Enable group windows by application"
if has_consent; then
  e_pending "Enabling group windows by application"
  defaults write -g AppleWindowTabbingMode -string "always"
fi

get_consent "Start screensaver after 2 minutes"
if has_consent; then
  e_pending "Setting screensaver to 2 minutes"
  defaults -currentHost write com.apple.screensaver idleTime -int 120
fi

get_consent "Turn display off on battery when inactive after 2 minutes"
if has_consent; then
  e_pending "Setting display off to 2 minutes"
  sudo pmset -b displaysleep 2
fi

get_consent "Require password immediately after sleep or screen saver begins"
if has_consent; then
  e_pending "Requiring password immediately after sleep or screen saver begins"
  defaults write com.apple.screensaver askForPassword -int 1
  defaults write com.apple.screensaver askForPasswordDelay -int 0
fi

get_consent "Turn display off on power adapter after 1 hour"
if has_consent; then
  e_pending "Setting display off to 1 hour"
  sudo pmset -c displaysleep 60
fi

get_consent "Enable scroll gesture with modifier key"
if has_consent; then
  e_pending "Enabling scroll gesture with modifier key"
  defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
  defaults write com.apple.universalaccess closeViewModifierMask -int 262144 # Control key

  # Set zoom style to full screen
  defaults write com.apple.universalaccess closeViewZoomMode -int 0
fi

get_consent "Enable Reduce Motion"
if has_consent; then
  e_pending "Enabling Reduce Motion"
  defaults write com.apple.universalaccess reduceMotion -boolean true
fi

get_consent "Disable wallpaper tinting in windows"
if has_consent; then
  e_pending "Disabling wallpaper tinting in windows"
  defaults write -g AppleReduceDesktopTinting -bool true
fi

# Trackpad
get_consent "Enable trackpad for dragging"
if has_consent; then
  e_pending "Enabling trackpad for dragging"
  defaults write com.apple.AppleMultitouchTrackpad Dragging -bool true
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool true

  # Set dragging style (without drag lock)
  defaults write com.apple.AppleMultitouchTrackpad DragLock -bool false
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad DragLock -bool false
fi

get_consent "Enable Trackpad Gestures"
if has_consent; then
  e_pending "Enabling Trackpad Gestures"

  # Enable Show Desktop gesture (Spread with thumb and three fingers)
  defaults write com.apple.dock showDesktopGestureEnabled -bool true
  defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerSpreadGesture -int 2
  # Configure Mission Control gesture (Swipe Up with Four Fingers)
  defaults write com.apple.dock showMissionControlGestureEnabled -bool true
  defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 2

  killall Dock
fi

get_consent "Tap to click"
if has_consent; then
  e_pending "Enabling tap to click in the trackpad"
  defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
  sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  sudo defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  sudo defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
fi

get_consent "Enable Three Finger Drag"
if has_consent; then
  e_pending "Enabling Three Finger Drag"
  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

  # Also need to enable dragging itself
  defaults write com.apple.AppleMultitouchTrackpad Dragging -bool true
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool true

  # Restart trackpad driver to apply changes
  killall Dock
fi

get_consent "Disable local Time Machine backups"
if has_consent; then
  e_pending "Disabling local Time Machine backups"
  sudo tmutil disablelocal
fi

get_consent "Check for software updates daily, not just once per week"
if has_consent; then
  e_pending "Checking for software updates daily"
  defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
fi

get_consent "Disable smart quotes and smart dashes"
if has_consent; then
  e_pending "Disabling smart quotes and smart dashes"
  defaults write -g NSAutomaticQuoteSubstitutionEnabled -boolean false
  defaults write -g NSAutomaticDashSubstitutionEnabled -boolean false
fi

get_consent "Set Mouse Tracking Speed to Fast"
if has_consent; then
  e_pending "Setting Mouse Tracking Speed to Fast"
  defaults write -g com.apple.mouse.scaling -float 3.0
fi

get_consent "Set Trackpad Tracking Speed to Fast"
if has_consent; then
  e_pending "Setting Trackpad Tracking Speed to Fast"
  defaults write -g com.apple.trackpad.scaling -float 3.0
fi

get_consent "Enabling subpixel font rendering on non-Apple LCDs"
if has_consent; then
  e_pending "Enabling subpixel font rendering"
  defaults write -g AppleFontSmoothing -int 2
fi

get_consent "Avoiding the creation of .DS_Store files on network volumes"
if has_consent; then
  e_pending "Avoiding the creation of .DS_Store files on network volumes"
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -boolean true
fi

get_consent "Prevent Time Machine from prompting to use new hard drives as backup volume"
if has_consent; then
  e_pending "Preventing Time Machine from prompting to use new hard drives as backup volume"
  defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -boolean true
fi

get_consent "Setting screenshot format to PNG"
if has_consent; then
  e_pending "Setting screenshot format to PNG"
  defaults write com.apple.screencapture type -string "png"
fi

get_consent "Disabling OS X Gate Keeper"
if has_consent; then
  e_pending "Disabling Gate Keeper"
  sudo spctl --master-disable
  sudo defaults write /var/db/SystemPolicy-prefs.plist enabled -string no

  # Disable the are you sure you want to open this application dialog
  defaults write com.apple.LaunchServices LSQuarantine -bool false
fi

# TextEdit
get_consent "Use plain text mode for new TextEdit documents"
if has_consent; then
  e_pending "Setting TextEdit to plain text mode"
  defaults write com.apple.TextEdit RichText -boolean false
fi

get_consent "Open and save files as UTF-8 in TextEdit"
if has_consent; then
  e_pending "Setting TextEdit to UTF-8"
  defaults write com.apple.TextEdit PlainTextEncoding -int 4
  defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
fi

if ! has_path "dev"; then
  get_consent "Create ~/dev folder"
  if has_consent; then
    e_pending "Creating ~/dev folder"
    mkdir -p ~/dev
    test_path "dev"
  fi
fi

if ! has_path "sandbox"; then
  get_consent "Create ~/sandbox folder"
  if has_consent; then
    e_pending "Creating ~/sandbox folder"
    mkdir -p ~/sandbox
    test_path "sandbox"
  fi
fi

if ! has_command "xcode-select"; then
  e_pending "Installing xcode-select (CLI tools)"
  xcode-select --install
  test_command "xcode-select"
fi

if ! has_command "brew"; then
  e_pending "Installing brew (Homebrew)"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if has_arm; then
    if ! grep -q "brew shellenv" "$HOME/.zprofile"; then
      echo "eval \"\$(/opt/homebrew/bin/brew shellenv)\"" >>"$HOME/.zprofile"
    fi
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  brew doctor
  brew tap homebrew/cask-fonts
  test_command "brew"
fi

# ------------------------------------------------------------------------------
e_message "Defaults complete"
# ------------------------------------------------------------------------------
