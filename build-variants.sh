#!/bin/bash
# Build both dwm variants: dwm-jnash and dwm-admin
# Run this after editing configs

set -e

DWM_DIR="$HOME/dwm"

echo "Building dwm-jnash..."
cd "$DWM_DIR"
cp config.h config.h.backup 2>/dev/null || true
make clean
make
sudo cp dwm /usr/local/bin/dwm-jnash
echo "✓ dwm-jnash built"

echo ""
echo "Building dwm-admin..."
cp config-admin.h config.h
make clean
make
sudo cp dwm /usr/local/bin/dwm-admin
echo "✓ dwm-admin built"

echo ""
echo "Restoring jnash config..."
cp config.h.backup config.h
make clean
make
sudo cp dwm /usr/local/bin/dwm
echo "✓ dwm (jnash default) restored"

echo ""
echo "Done! Binaries:"
ls -la /usr/local/bin/dwm* | grep -E "(dwm$|dwm-)"
