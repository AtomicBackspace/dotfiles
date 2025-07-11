#!/bin/bash

LOG="$HOME/kdbx_sync.log"
SRC="$HOME/Nextcloud"
DEST="$HOME/Library/CloudStorage/ProtonDrive-markus@langenoja.se-folder"
PIDFILE="$HOME/.kdbx_sync.pid"
FSWATCH="/opt/homebrew/bin/fswatch"

if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    echo "$(date): Script already running (PID $(cat "$PIDFILE"))" >> "$LOG"
    exit 1
fi

echo $$ > "$PIDFILE"
trap "rm -f '$PIDFILE'" EXIT

echo "$(date): Starting sync watcher on $SRC" >> "$LOG"

sync_kdbx_files() {
    echo "$(date): Triggered sync" >> "$LOG"
    find "$SRC" -type f -name "*.kdbx" -print0 2>>"$LOG" | \
        xargs -0 -I {} /opt/homebrew/bin/rsync -a "{}" "$DEST/" >/dev/null 2>>"$LOG"

    if [[ $? -ne 0 ]]; then
        echo "$(date): Error occurred during rsync" >> "$LOG"
    fi
}

debounce_timer=0
DEBOUNCE_DELAY=2  # seconds

"$FSWATCH" -0 -r --include=".*\.kdbx$" --exclude=".*" "$SRC" 2>/dev/null | while read -d "" event; do
    now=$(date +%s)
    if (( now - debounce_timer >= DEBOUNCE_DELAY )); then
        debounce_timer=$now
        sync_kdbx_files
    else
        echo "$(date): Ignored redundant event: $event" >> "$LOG"
    fi
done
