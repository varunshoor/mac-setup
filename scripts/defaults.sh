#!/bin/bash

source utils.sh

# ------------------------------------------------------------------------------
e_message "Running validation checks"
# ------------------------------------------------------------------------------

get_consent "Have you given full disk access to terminal"
if ! has_consent; then
  e_failure "Please give full disk access to terminal and run the script again"
  exit 1
fi

get_consent "Have you given Accessibility access to terminal"
if ! has_consent; then
  e_failure "Please give Accessibility access to terminal and run the script again"
  exit 1
fi

get_consent "Have you manually created three additional desktops in Mission Control"
if ! has_consent; then
  e_failure "Please create three additional desktops in Mission Control and run the script again"
  exit 1
fi

# ------------------------------------------------------------------------------
e_message "Creating defaults"
# ------------------------------------------------------------------------------

# Folders
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

if ! has_path "design"; then
  get_consent "Create ~/design folder"
  if has_consent; then
    e_pending "Creating ~/design folder"
    mkdir -p ~/design
    test_path "design"
  fi
fi

if ! has_path "bottomline"; then
  get_consent "Create ~/bottomline folder"
  if has_consent; then
    e_pending "Creating ~/bottomline folder"
    mkdir -p ~/bottomline
    test_path "bottomline"
  fi
fi

if ! has_path "screenshots"; then
  get_consent "Create ~/screenshots folder"
  if has_consent; then
    e_pending "Creating ~/screenshots folder"
    mkdir -p ~/screenshots
    test_path "screenshots"
  fi
fi

# Dock
get_consent "Autohide Dock"
if has_consent; then
  # VALIDATED
  e_pending "Autohiding Dock"
  defaults write com.apple.dock autohide -boolean true
fi

get_consent "Reduce dock auto hide animation"
if has_consent; then
  # VALIDATED
  e_pending "Reducing Dock auto hide animation"
  defaults write com.apple.dock autohide-time-modifier -float 0.25
fi

get_consent "Remove Dock Delay for Auto Hide & Auto-Show"
if has_consent; then
  # VALIDATED
  e_pending "Removing Dock delay"
  defaults write com.apple.dock autohide-delay -float 0
fi

get_consent "Set the icon size of Dock items to 48 pixels"
if has_consent; then
  # VALIDATED
  e_pending "Setting Dock icon size to 48 pixels"
  defaults write com.apple.dock tilesize -int 48
fi

get_consent "Disable Dock magnification"
if has_consent; then
  e_pending "Disabling Dock magnification"
  defaults write com.apple.dock magnification -boolean false
fi

get_consent "Disable Recent Apps in Dock"
if has_consent; then
  e_pending "Disabling Recent Apps in Dock"
  defaults write com.apple.dock show-recents -boolean false
fi

get_consent "Change App Minimization Effect"
if has_consent; then
  e_pending "Changing App Minimization Effect"
  defaults write com.apple.dock mineffect -string "scale"
fi

get_consent "Dock - Remove all default app icons"
if has_consent; then
  e_pending "Removing all default app icons from Dock"
  defaults write com.apple.dock persistent-apps -array
fi

get_consent "Dock - Don’t animate opening applications"
if has_consent; then
  e_pending "Disabling application opening animation"
  defaults write com.apple.dock launchanim -boolean false
fi

get_consent "Dock - Make icons of hidden applications translucent"
if has_consent; then
  e_pending "Making icons of hidden applications translucent"
  defaults write com.apple.dock showhidden -boolean true
fi

killall Dock

# Finder
get_consent "Display hidden Finder files/folders"
if has_consent; then
  # VALIDATED
  e_pending "Displaying hidden Finder files/folders"
  defaults write com.apple.finder AppleShowAllFiles -boolean true
  killall Finder
fi

get_consent "Finder - Show filename extensions"
if has_consent; then
  e_pending "Showing filename extensions"
  defaults write NSGlobalDomain AppleShowAllExtensions -boolean true
fi

get_consent "Default Finder view is Column"
if has_consent; then
  # VALIDATED
  e_pending "Setting default Finder view to Column"
  defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
fi

get_consent "Finder: disable window animations and Get Info animations"
if has_consent; then
  e_pending "Disabling Finder window animations"
  defaults write com.apple.finder DisableAllAnimations -boolean true
fi

get_consent "Update other Finder settings"
if has_consent; then
  e_pending "Updating other Finder settings"

  # Show items on desktop
  # VALIDATED
  defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
  defaults write com.apple.finder ShowMountedServersOnDesktop -bool true

  # Set new Finder windows to open to Downloads folder
  # VALIDATED
  defaults write com.apple.finder NewWindowTarget -string "PfLo"
  defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Downloads/"

  # Disable iCloud Desktop & Documents sync
  # VALIDATED
  defaults write com.apple.finder FXICloudDriveDesktop -bool false
  defaults write com.apple.finder FXICloudDriveDocuments -bool false

  # Open folders in tabs instead of new windows
  # VALIDATED
  defaults write com.apple.finder FinderSpawnTab -bool true

  # Favorites
  # VALIDATED
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
  defaults write com.apple.sidebarlists favoriteritems -dict-add ShowHome -bool true # NOT WORKING

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

get_consent "Finder - Display full POSIX path as window title"
if has_consent; then
  e_pending "Displaying full POSIX path as window title"
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
fi

get_consent "Finder - Show the ~/Library folder"
if has_consent; then
  e_pending "Showing the ~/Library folder"
  chflags nohidden ~/Library
fi

get_consent "Finder - Show the /Volumes folder"
if has_consent; then
  e_pending "Showing the /Volumes folder"
  sudo chflags nohidden /Volumes
fi

get_consent "Display folders on top in Desktop"
if has_consent; then
  e_pending "Displaying folders on top in Desktop"
  defaults write com.apple.finder "_FXSortFoldersFirstOnDesktop" -bool "true"
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

get_consent "Finder - Display quit option"
if has_consent; then
  e_pending "Displaying quit option"
  defaults write com.apple.finder QuitMenuItem -bool true
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

get_consent "Keep folders on top when sorting by name"
if has_consent; then
  e_pending "Keeping folders on top when sorting by name"
  defaults write com.apple.finder _FXSortFoldersFirst -boolean true
fi

get_consent "Show icon in title bar"
if has_consent; then
  e_pending "Showing icon in title bar"
  defaults write com.apple.universalaccess "showWindowTitlebarIcons" -bool "true"
fi

# Power
get_consent "Enable High Power on Power Adapter"
if has_consent; then
  e_pending "Enabling High Power on Power Adapter"

  # NOTWORKING
  defaults write com.apple.powerprofile -dict AC\ Power -int 2
  sudo killall powerd
fi

get_consent "Set Display to Sleep after 60 minutes on Charger"
if has_consent; then
  e_pending "Setting Display to Sleep after 60 minutes on Charger"
  sudo pmset -c displaysleep 60
fi

get_consent "Set Display to Sleep after 2 minutes on Battery"
if has_consent; then
  e_pending "Setting Display to Sleep after 2 minutes on Battery"
  sudo pmset -b displaysleep 2
fi

get_consent "Start screensaver after 2 minutes"
if has_consent; then
  e_pending "Setting screensaver to 2 minutes"
  defaults -currentHost write com.apple.screensaver idleTime -int 120
fi

get_consent "Restart Automatically on Power Loss"
if has_consent; then
  e_pending "Restarting Automatically on Power Loss"
  sudo pmset -a autorestart 1
fi

get_consent "Restart Automatically if Computer Freezes"
if has_consent; then
  e_pending "Restarting Automatically if Computer Freezes"
  sudo systemsetup -setrestartfreeze on
fi

get_consent "Require password immediately after sleep or screen saver begins"
if has_consent; then
  e_pending "Requiring password immediately after sleep or screen saver begins"
  defaults -currentHost write com.apple.screensaver askForPassword -boolean true
  defaults -currentHost write com.apple.screensaver askForPasswordDelay -int 5
fi

killall SystemUIServer

get_consent "Turn display off on power adapter after 1 hour"
if has_consent; then
  e_pending "Setting display off to 1 hour"
  sudo pmset -c displaysleep 60
fi

# Keyboard
get_consent "Enable Function Keys"
if has_consent; then
  # VALIDATED
  e_pending "Enabling Function Keys"
  defaults write -g com.apple.keyboard.fnState -bool true
fi

get_consent "Enable Keyboard Navigation"
if has_consent; then
  e_pending "Enabling Keyboard Navigation"
  defaults write -g AppleKeyboardUIMode -int 2
fi

get_consent "Keyboard - Automatically illuminate built-in MacBook keyboard in low light"
if has_consent; then
  e_pending "Automatically illuminating built-in MacBook keyboard in low light"
  defaults write com.apple.BezelServices kDim -bool true

  # Turn off keyboard illumination after 5 minutes of inactivity
  defaults write com.apple.BezelServices kDimTime -int 300
fi

# Keyboard Shortcuts
get_consent "Set Custom Screenshot Keyboard Shortcuts"
if has_consent; then
  # VALIDATED
  e_pending "Setting Custom Screenshot Keyboard Shortcuts..."

  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 184 '<dict>
    <key>enabled</key><true/>
    <key>value</key>
    <dict>
        <key>parameters</key>
        <array>
            <integer>53</integer>
            <integer>23</integer>
            <integer>1179648</integer>
        </array>
        <key>type</key><string>standard</string>
    </dict>
</dict>'

  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 28 '<dict>
    <key>enabled</key><true/>
    <key>value</key>
    <dict>
        <key>parameters</key>
        <array>
            <integer>52</integer>
            <integer>21</integer>
            <integer>1441792</integer>
        </array>
        <key>type</key><string>standard</string>
    </dict>
</dict>'

  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 29 '<dict>
    <key>enabled</key><true/>
    <key>value</key>
    <dict>
        <key>parameters</key>
        <array>
            <integer>52</integer>
            <integer>21</integer>
            <integer>1179648</integer>
        </array>
<key>type</key><string>standard</string>
    </dict>
</dict>'

  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 30 '<dict>
    <key>enabled</key><true/>
    <key>value</key>
    <dict>
        <key>parameters</key>
        <array>
            <integer>51</integer>
            <integer>20</integer>
            <integer>1441792</integer>
        </array>
        <key>type</key><string>standard</string>
    </dict>
</dict>'

  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 31 '<dict>
    <key>enabled</key><true/>
    <key>value</key>
    <dict>
        <key>parameters</key>
        <array>
            <integer>51</integer>
            <integer>20</integer>
            <integer>1179648</integer>
        </array>
        <key>type</key><string>standard</string>
    </dict>
</dict>'

  # Restart to apply changes
  killall SystemUIServer
  killall cfprefsd

  e_message "Screenshot shortcuts updated successfully. You may need to log out and back in for changes to take effect."
fi

get_consent "Disable Spotlight Keyboard Shortcuts"
if has_consent; then
  # VALIDATED. REQUIRES RESTART.
  e_pending "Disabling Spotlight Keyboard Shortcuts"
  # Disable Spotlight search shortcut (⌘Space)
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 '<dict><key>enabled</key><false/></dict>'
  # Disable Finder search window shortcut (⌃⌘Space)
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 65 '<dict><key>enabled</key><false/></dict>'
fi

get_consent "Update Mission Control Keyboard Shortcuts"
if has_consent; then
  e_pending "Updating Mission Control Keyboard Shortcuts"
  # Disable Move left/right space shortcuts
  # VALIDATED - REQUIRES RESTART.
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 79 '<dict><key>enabled</key><false/></dict>'
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 81 '<dict><key>enabled</key><false/></dict>'

  # Enable Switch to Desktop shortcuts
  # VALIDATED - REQUIRES RESTART
  # Desktop 1 (^⌥1)
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 118 '<dict>
    <key>enabled</key><true/>
    <key>value</key>
    <dict>
        <key>parameters</key>
        <array>
            <integer>49</integer>
            <integer>18</integer>
            <integer>786432</integer>
        </array>
        <key>type</key><string>standard</string>
    </dict>
</dict>'

  # Desktop 2 (^⌥2)
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 119 '<dict>
    <key>enabled</key><true/>
    <key>value</key>
    <dict>
        <key>parameters</key>
        <array>
            <integer>50</integer>
            <integer>19</integer>
            <integer>786432</integer>
        </array>
        <key>type</key><string>standard</string>
    </dict>
</dict>'

  # Desktop 3 (^⌥3)
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 120 '<dict>
    <key>enabled</key><true/>
    <key>value</key>
    <dict>
        <key>parameters</key>
        <array>
            <integer>51</integer>
            <integer>20</integer>
            <integer>786432</integer>
        </array>
        <key>type</key><string>standard</string>
    </dict>
</dict>'

  # Desktop 4 (^⌥4)
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 121 '<dict>
    <key>enabled</key><true/>
    <key>value</key>
    <dict>
        <key>parameters</key>
        <array>
            <integer>52</integer>
            <integer>21</integer>
            <integer>786432</integer>
        </array>
        <key>type</key><string>standard</string>
    </dict>
</dict>'

  # Restart to apply changes
  killall SystemUIServer

  e_message "Mission Control shortcuts updated successfully. You need to log out and back in for changes to take effect."
fi

# Text Replacements
get_consent "Add custom text replacements"
if has_consent; then
  # VALIDATED
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
  # VALIDATED
  e_pending "Disabling auto-correct"
  defaults write -g NSAutomaticSpellingCorrectionEnabled -boolean false
fi

get_consent "Disable auto-capitalization"
if has_consent; then
  # VALIDATED
  e_pending "Disabling auto-capitalization"
  defaults write -g NSAutomaticCapitalizationEnabled -boolean false
fi

get_consent "Set a fast keyboard repeat rate"
if has_consent; then
  # VALIDATED
  e_pending "Setting fast keyboard repeat rate"
  defaults write -g KeyRepeat -int 2
  defaults write -g InitialKeyRepeat -int 15
fi

get_consent "Allow text selection in Quick Look"
if has_consent; then
  # VALIDATED
  e_pending "Allowing text selection in Quick Look"
  defaults write com.apple.finder QLEnableTextSelection -boolean true
fi

get_consent "Disable smart quotes and smart dashes"
if has_consent; then
  # VALIDATED
  e_pending "Disabling smart quotes and smart dashes"
  defaults write -g NSAutomaticQuoteSubstitutionEnabled -boolean false
  defaults write -g NSAutomaticDashSubstitutionEnabled -boolean false
fi

get_consent "Disable add fullstop with double space"
if has_consent; then
  # VALIDATED
  e_pending "Disabling add fullstop with double space"
  defaults write -g NSAutomaticPeriodSubstitutionEnabled -boolean false
fi

# Screenshots
get_consent "Save screenshots to ~/screenshots"
if has_consent; then
  e_pending "Saving screenshots to ~/screenshots"
  defaults write com.apple.screencapture location -string "${HOME}/screenshots"
  killall SystemUIServer
fi

get_consent "Setting screenshot format to PNG"
if has_consent; then
  e_pending "Setting screenshot format to PNG"
  defaults write com.apple.screencapture type -string "png"
fi

get_consent "Disable shadow in screenshots"
if has_consent; then
  e_pending "Disabling shadow in screenshots"
  defaults write com.apple.screencapture disable-shadow -boolean true
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
  defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
  defaults write com.apple.Safari IncludeDevelopMenu -boolean true
  defaults write com.apple.Safari.SandboxBroker ShowDevelopMenu -bool true
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

  # Set history removal to after one week
  defaults write com.apple.Safari HistoryAgeInDaysLimit -int 7

  # Set new windows and tabs to open with empty page
  # 0 = Top Sites
  # 1 = Homepage
  # 4 = Empty Page
  # 5 = Same Page
  defaults write com.apple.Safari NewWindowBehavior -int 1
  defaults write com.apple.Safari NewTabBehavior -int 1

  # Set Safari to open with windows from last session
  # 1 = New Window
  # 2 = New Private Window
  # 3 = All windows from last session
  defaults write com.apple.Safari AlwaysRestoreSessionAtLaunch -bool true
  defaults write com.apple.Safari OpenPrivateWindowWhenNotRestoringSessionAtLaunch -bool false

  # Prevent Safari from opening 'safe' files automatically after downloading
  defaults write com.apple.Safari AutoOpenSafeDownloads -boolean false

  # Update Safari settings
  defaults write com.apple.Safari ShowFavoritesBar -boolean false
  defaults write com.apple.Safari "ShowFavoritesBar-v2" -boolean false
  defaults write com.apple.Safari ShowSidebarInTopSites -boolean false
  defaults write com.apple.Safari ShowSidebarInNewWindows -boolean false
  defaults write com.apple.Safari ShowSidebar -boolean false
  defaults write com.apple.Safari SendDoNotTrackHTTPHeader -boolean true
  defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -boolean true
  defaults write com.apple.Safari ShowFullURLInSmartSearchField -boolean true
  defaults write com.apple.Safari SuppressSearchSuggestions -boolean true
  defaults write com.apple.Safari UniversalSearchEnabled -boolean false

  # Disable Auto Fill Passwords
  defaults write com.apple.Safari AutoFillPasswords -bool false

  # Disable Safari’s thumbnail cache for History and Top Sites
  defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

  # Don’t allow websites to ask for permission to send push notifications
  defaults write com.apple.Safari CanPromptForPushNotifications -boolean false

  # Restart Safari for changes to take effect
  killall Safari
fi

# Activity Monitor
get_consent "Activity Monitor - Show all processes in Activity Monitor"
if has_consent; then
  e_pending "Showing all processes in Activity Monitor"
  defaults write com.apple.ActivityMonitor ShowCategory -int 0
fi

get_consent "Activity Monitor - Show the main window when launching Activity Monitor"
if has_consent; then
  e_pending "Showing main window when launching Activity Monitor"
  defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
fi

# Photos
get_consent "Photos - Prevent Photos from opening automatically when devices are plugged in"
if has_consent; then
  e_pending "Preventing Photos from opening automatically"
  defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
fi

# Display
get_consent "Display - Reduce Transparency"
if has_consent; then
  e_pending "Reducing Transparency"
  defaults write com.apple.universalaccess reduceTransparency -bool true
fi

get_consent "Display - Disable Window Animation"
if has_consent; then
  e_pending "Disabling Window Animation"
  defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
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
  # VALIDATED
  e_pending "Automatically hiding and showing the menu bar"
  defaults write NSGlobalDomain _HIHideMenuBar -boolean true
fi

get_consent "Show date and time in menu bar"
if has_consent; then
  # VALIDATED

  e_pending "Showing date and time in menu bar"
  # Only add Clock if not already present
  if ! defaults read com.apple.systemuiserver menuExtras | grep -q "Clock.menu"; then
    defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Clock.menu"
  fi

  # Include date in the menu bar (System Preferences | Date & Time | Clock)
  # https://apple.stackexchange.com/questions/180847/wrong-date-format-in-the-menu-bar
  defaults write 'com.apple.menuextra.clock' 'DateFormat' -string 'EEE MMM d  h:mm:ss a'
fi

get_consent "Show Volume in menu bar"
if has_consent; then
  # NOT WORKING
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
  defaults write com.apple.menuextra.battery ShowPercent -string "YES"

  # VALIDATED
  # Show battery in menu bar
  defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool true

  # Show in Control Center
  defaults write com.apple.controlcenter Battery -bool true
fi

get_consent "Disable Spotlight in Menu Bar"
if has_consent; then
  # VALIDATED
  e_pending "Disabling Spotlight in Menu Bar"
  defaults write com.apple.Spotlight MenuItemHidden -int 1
fi

get_consent "Menu Bar - Disable Transparency"
if has_consent; then
  e_pending "Disabling Menu Bar Transparency"
  defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false
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
  # VALIDATED
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

get_consent "Setup Hot Corners"
if has_consent; then
  # VALIDATED
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

  # Bottom Right: Disabled (0)
  defaults write com.apple.dock wvous-br-corner -int 0
  defaults write com.apple.dock wvous-br-modifier -int 0

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
  defaults write com.apple.spaces spans-displays -boolean true
fi

get_consent "Enable switching to space of application"
if has_consent; then
  e_pending "Enabling switching to space of application"
  defaults write -g AppleSpacesSwitchOnActivate -boolean true
fi

get_consent "Enable group windows by application"
if has_consent; then
  e_pending "Enabling group windows by application"
  defaults write com.apple.dock "expose-group-apps" -bool "true"
fi

get_consent "Disable Separate Spaces for Displays"
if has_consent; then
  e_pending "Disabling Separate Spaces for Displays"
  defaults write com.apple.spaces spans-displays -bool false
fi

# Accessibility
get_consent "Enable scroll gesture with modifier key"
if has_consent; then
  e_pending "Enabling scroll gesture with modifier key"
  defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
  defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
  defaults write com.apple.universalaccess closeViewModifierMask -int 262144    # Control key
  defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true # Follow the keyboard focus while zoomed in

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

# Mouse
get_consent "Set Mouse Tracking Speed to Fast"
if has_consent; then
  e_pending "Setting Mouse Tracking Speed to Fast"
  defaults write -g com.apple.mouse.scaling -float 3.0
fi

# Trackpad
get_consent "Enable trackpad for dragging"
if has_consent; then
  e_pending "Enabling trackpad for dragging"
  defaults write com.apple.AppleMultitouchTrackpad Dragging -int 1
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -int 1

  # Set dragging style (without drag lock)
  defaults write com.apple.AppleMultitouchTrackpad DragLock -int 1
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad DragLock -int 1
fi

get_consent "Enable Trackpad Gestures"
if has_consent; then
  e_pending "Enabling Trackpad Gestures"

  # Disabling Three Finger Horizontal Swipe
  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0

  # Disable Three Finger Vertical Swipe
  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 0

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
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
fi

get_consent "Enable Three Finger Drag"
if has_consent; then
  e_pending "Enabling Three Finger Drag"
  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -int 1
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -int 1

  # Restart trackpad driver to apply changes
  killall Dock
fi

get_consent "Set Trackpad Tracking Speed to Fast"
if has_consent; then
  e_pending "Setting Trackpad Tracking Speed to Fast"
  defaults write -g com.apple.trackpad.scaling -float 3.0
fi

get_consent "Check for software updates daily, not just once per week"
if has_consent; then
  e_pending "Checking for software updates daily"
  defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
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

get_consent "Disabling OS X Gate Keeper"
if has_consent; then
  e_pending "Disabling Gate Keeper"
  sudo spctl --master-disable
  defaults write /var/db/SystemPolicy-prefs.plist enabled -string no

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

get_consent "Update Fonts for TextEdit"
if has_consent; then
  e_pending "Setting TextEdit fonts"

  defaults write com.apple.TextEdit NSFixedPitchFont -string "BerkeleyMonoNFM-Regular"
  defaults write com.apple.TextEdit NSFixedPitchFontSize -int 18

  defaults write com.apple.TextEdit NSFont -string "BerkeleyMonoNFM-Regular"
  defaults write com.apple.TextEdit NSFontSize -int 18
fi

get_consent "Disable Spell Check in TextEdit"
if has_consent; then
  e_pending "Disabling Spell Check in TextEdit"
  defaults write com.apple.TextEdit CorrectSpellingAutomatically -boolean false
fi

get_consent "Disable Smart Quotes in TextEdit"
if has_consent; then
  e_pending "Disabling Smart Quotes in TextEdit"
  defaults write com.apple.TextEdit SmartQuotes -boolean false
fi

# Commands
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
else
  # upgrade homebrew to latest version
  e_pending "Homebrew already installed"
  e_pending "Upgrading homebrew..."
  brew update
  brew upgrade
fi

# ------------------------------------------------------------------------------
e_message "Defaults complete"
# ------------------------------------------------------------------------------
