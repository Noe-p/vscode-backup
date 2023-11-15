#!/bin/bash

USERNAME=$(whoami)
DATE=$(date +"%Y-%m-%d")
BACKUP_DIR="$PWD/VSCode_$USERNAME-$DATE"

mkdir -p "$BACKUP_DIR"
cp $HOME/Library/Application\ Support/Code/User/settings.json $BACKUP_DIR/settings.json
cp $HOME/Library/Application\ Support/Code/User/keybindings.json $BACKUP_DIR/keybindings.json
cp -r $HOME/Library/Application\ Support/Code/User/snippets $BACKUP_DIR/
code --list-extensions | sed -e 's/^/code --install-extension /' > $BACKUP_DIR/extensions.sh
