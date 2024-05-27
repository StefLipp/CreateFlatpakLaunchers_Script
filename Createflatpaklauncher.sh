#!/bin/bash

# Set directory for launchers
DESKTOP_DIR="$HOME/Links/"
mkdir -p "$DESKTOP_DIR"

# Finding flatpak apps
flatpak list --app --columns=application | sed '1d' | while read -r app; do
    # Get app name
    app_name=$(echo "$app" | cut -d' ' -f1)
    app_name_short=$(echo "$app_name" | awk -F '.' '{print $NF}')

    # Generate launcher file
    cat <<EOF >"$DESKTOP_DIR/$app_name_short.desktop"
[Desktop Entry]
Name=$app_name_short
Exec=flatpak run $app_name
Icon=$app_name
Terminal=false
Type=Application
Categories=Application;
EOF

    echo "Created .desktop file for $app_name_short"
done

echo "All .desktop files created successfully."

