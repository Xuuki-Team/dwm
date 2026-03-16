#!/bin/sh
# User-specific DWM launcher - picks the right binary based on who logs in

LOG=/tmp/dwm-launcher.log
{
  echo "== $(date) =="
  echo "USER=$USER"
  echo "HOME=$HOME"
} >> "$LOG" 2>&1

# Pick the right DWM binary
case "$USER" in
  admin)
    DWM_BIN="/usr/local/bin/dwm-admin"
    ;;
  jnash)
    DWM_BIN="/usr/local/bin/dwm-jnash"
    ;;
  *)
    # Fallback to default
    DWM_BIN="/usr/local/bin/dwm"
    ;;
esac

if [ ! -x "$DWM_BIN" ]; then
  echo "Warning: $DWM_BIN not found, using default" >> "$LOG"
  DWM_BIN="/usr/local/bin/dwm"
fi

echo "Starting: $DWM_BIN" >> "$LOG"

# DWM exits on restart (Mod+Shift+Q), so loop to keep session alive
while true; do
  "$DWM_BIN" >> "$LOG" 2>&1
  echo "DWM exited with code $?, restarting..." >> "$LOG"
done
