#!/bin/bash

USERNAME=$(whoami)
DATE=$(date +"%Y-%m-%d")
BACKUP_DIR="$PWD/VSCode_$USERNAME-$DATE"

mkdir -p "$BACKUP_DIR"
cp $HOME/Library/Application\ Support/Code/User/settings.json $BACKUP_DIR/settings.json
cp $HOME/Library/Application\ Support/Code/User/keybindings.json $BACKUP_DIR/keybindings.json
cp -r $HOME/Library/Application\ Support/Code/User/snippets $BACKUP_DIR/
code --list-extensions | sed -e 's/^/code --install-extension /' > $BACKUP_DIR/extensions.sh

# Supprimer vscode 
rm -fr ~/Library/Preferences/com.microsoft.VSCode.helper.plist 
rm -fr ~/Library/Preferences/com.microsoft.VSCode.plist 
rm -fr ~/Library/Caches/com.microsoft.VSCode
rm -fr ~/Library/Caches/com.microsoft.VSCode.ShipIt/
rm -fr ~/Library/Application\ Support/Code/
rm -fr ~/Library/Saved\ Application\ State/com.microsoft.VSCode.savedState/
rm -fr ~/.vscode/
rm -rf ~/.vscode*

mkdir $HOME/Library/Application\ Support/Code
mkdir $HOME/Library/Application\ Support/Code/User

# Réinstaller vscode
cp $BACKUP_DIR/settings.json $HOME/Library/Application\ Support/Code/User/
cp $BACKUP_DIR/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json
cp -r $BACKUP_DIR/snippets $HOME/Library/Application\ Support/Code/User/
bash $BACKUP_DIR/extensions.sh
