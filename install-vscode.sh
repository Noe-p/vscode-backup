#!/bin/bash

FOLDER_PATH="$1"

# Vérifier si le dossier a été trouvé
if [ -n "$FOLDER_PATH" ]; then
    echo "Le dossier VSCode_Backup le plus récent a été trouvé à : $FOLDER_PATH"
    echo "Voulez-vous continuer ? (y/n)"
    read -r CONTINUE
    if [ "$CONTINUE" = "y" ]; then
        mkdir $HOME/Library/Application\ Support/Code
        mkdir $HOME/Library/Application\ Support/Code/User

        cp $BACKUP_DIR/settings.json $HOME/Library/Application\ Support/Code/User/
        cp $BACKUP_DIR/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json
        cp -r $BACKUP_DIR/snippets $HOME/Library/Application\ Support/Code/User/
        bash $BACKUP_DIR/extensions.sh
    else
        echo "Annulation."
    fi
else
    echo "Aucun dossier VSCode_Backup n'a été trouvé."
    echo "Ajouter le chemin du dossier en paramètre"
fi
