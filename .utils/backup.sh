#!/bin/bash

# Require all three arguments: source, base, name
if [ $# -ne 3 ]; then
    echo "ERROR: Exactly three arguments required"
    echo "Usage: $0 <source> <base> <name>"
    echo "Example: $0 /var/www/nextcloud/data /mnt/backups nextcloud"
    exit 1
fi

SOURCE="$1"
BASE="$2"
NAME="$3"

# Validate source exists
if [ ! -d "$SOURCE" ]; then
    echo "ERROR: Source directory does not exist: $SOURCE"
    exit 1
fi

# Auto-generated values - simpler timestamp format
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
TEMP="$BASE/$NAME."
SNAPSHOT="$BASE/$NAME.$TIMESTAMP"

# Create base directory if needed
mkdir -p "$BASE"

# Find most recent backup - matches pattern: name.YYYYMMDD-HHMMSS
# YYYYMMDD = 8 digits, HHMMSS = 6 digits
PREVIOUS=$(ls -d "$BASE/$NAME".[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9] 2>/dev/null | sort | tail -n1)

# Alternative: simpler pattern (less strict but more readable)
# PREVIOUS=$(ls -d "$BASE/$NAME".[0-9]*-[0-9]* 2>/dev/null | sort | tail -n1)

if [ -n "$PREVIOUS" ]; then
    echo "📁 Backing up '$NAME' from '$SOURCE'"
    echo "🔗 Hardlinking from: $(basename $PREVIOUS)"
    rsync -aAXi --stats --checksum --link-dest="$PREVIOUS" --numeric-ids "$SOURCE/" "$TEMP"
else
    echo "📁 First backup of '$NAME' from '$SOURCE'"
    rsync -aAXi --stats --checksum --numeric-ids "$SOURCE/" "$TEMP"
fi

# Only rename if rsync succeeded
if [ $? -eq 0 ]; then
    mv "$TEMP" "$SNAPSHOT"
    echo "✅ Backup complete: $SNAPSHOT"
else
    echo "❌ Backup failed. Temporary backup remains at: $TEMP"
    exit 1
fi
