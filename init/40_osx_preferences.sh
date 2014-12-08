# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Dropbox is not installed.
# PROCESS=Dropbox
# number=$(ps aux | grep $PROCESS | wc -l)
# if [ $number -lt 1 ]
#     then
#         e_error "Not Running"
#         return 1
# fi

e_header 'Symlinking MAX OSX Preferences'

DROPBOX_PREFERENCES="$HOME/Dropbox/MacPreferences/plists";
PREFERENCE_LOCATION="Library/Preferences"
MAC_PREFERENCES_LOCATION="$HOME/$PREFERENCE_LOCATION"
# echo $DROPBOX_PREFERENCES
if [[ -d "${DROPBOX_PREFERENCES}" && ! -L "${DROPBOX_PREFERENCES}" ]] ; then
    e_arrow "Looping through ${DROPBOX_PREFERENCES}"
    for file in "$DROPBOX_PREFERENCES/*"
    do
        filename=$(basename $file)
        #Check if preference file exists in ~/Library/Preferences.
        #If not copy file over from Dropbox location
        #If it does backup file if different and copy over
        if [ -f "$MAC_PREFERENCES_LOCATION/$filename" ]
        then
            e_arrow "Comparing $DROPBOX_PREFERENCES/$filename to $MAC_PREFERENCES_LOCATION/$filename"
            if ! diff "$DROPBOX_PREFERENCES/$filename" "$MAC_PREFERENCES_LOCATION/$filename" >/dev/null ; then
                e_arrow "Backing up $MAC_PREFERENCES_LOCATION/$filename"
                # Set backup flag, so a nice message can be shown at the end.
                backup=1
                # Create backup dir if it doesn't already exist.
                [[ -e "$backup_dir" ]] || mkdir -p "$backup_dir/$PREFERENCE_LOCATION/"
                # Backup file / link / whatever.
                mv "$MAC_PREFERENCES_LOCATION/$filename" "$backup_dir/$PREFERENCE_LOCATION/"
                if [ $? -eq 0 ]; then
                    cp "$DROPBOX_PREFERENCES/$filename" "$MAC_PREFERENCES_LOCATION/$filename"
                fi
            fi
        else
           cp "$DROPBOX_PREFERENCES/$filename" "$MAC_PREFERENCES_LOCATION/$filename"
        fi
    done
fi