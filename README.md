# Gestion de la configuration VSCode

Ce dépôt contient un ensemble de scripts Bash pour gérer la configuration de Visual Studio Code (VSCode). Les scripts facilitent la sauvegarde, l'installation et le nettoyage des paramètres, des raccourcis, des extraits de code et des extensions de VSCode. Cela peut être particulièrement utile lors de la migration vers une nouvelle machine ou de la réinitialisation de votre environnement VSCode.

## Scripts

### 1. `backup-vscode.sh`

Ce script crée une sauvegarde de votre configuration actuelle de VSCode, y compris les paramètres, les raccourcis, les extraits de code et les extensions installées. La sauvegarde est organisée par nom d'utilisateur et date.

```bash
#!/bin/bash

USERNAME=$(whoami)
DATE=$(date +"%Y-%m-%d")
BACKUP_DIR="$PWD/VSCode_$USERNAME-$DATE"

mkdir -p "$BACKUP_DIR"
cp $HOME/Library/Application\ Support/Code/User/settings.json $BACKUP_DIR/settings.json
cp $HOME/Library/Application\ Support/Code/User/keybindings.json $BACKUP_DIR/keybindings.json
cp -r $HOME/Library/Application\ Support/Code/User/snippets $BACKUP_DIR/
code --list-extensions | sed -e 's/^/code --install-extension /' > $BACKUP_DIR/extensions.sh
```

### 2. `install-vscode.sh`

Ce script installe une configuration VSCode précédemment sauvegardée. Il demande à l'utilisateur de confirmer l'installation et copie les paramètres, les raccourcis, les extraits de code et les extensions aux répertoires appropriés.

```bash
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
    echo "Ajouter le chemin du dossier en paramètre."
fi
```

### 3. `clean-vscode.sh`

Ce script nettoie l'installation de VSCode, supprimant tous les paramètres, raccourcis, extraits de code et extensions. Ensuite, il réinstalle VSCode en utilisant la configuration sauvegardée précédemment.

```bash
#!/bin/bash

USERNAME=$(whoami)
DATE=$(date +"%Y-%m-%d")
BACKUP_DIR="$PWD/VSCode_$USERNAME-$DATE"

mkdir -p "$BACKUP_DIR"
cp $HOME/Library/Application\ Support/Code/User/settings.json $BACKUP_DIR/settings.json
cp $HOME/Library/Application\ Support/Code/User/keybindings.json $BACKUP_DIR/keybindings.json
cp -r $HOME/Library/Application\ Support/Code/User/snippets $BACKUP_DIR/
code --list-extensions | sed -e 's/^/code --install-extension /' > $BACKUP_DIR/extensions.sh

# Supprimer VSCode
rm -fr ~/Library/Preferences/com.microsoft.VSCode.helper.plist
rm -fr ~/Library/Preferences/com.microsoft.VSCode.plist
rm -fr ~/Library/Caches/com.microsoft.VSCode
rm -fr ~/Library/Caches/com.microsoft.VSCode.ShipIt/
rm -fr ~/Library/Application\ Support/Code/
rm -fr ~/Library/Saved\ Application\ State/com.microsoft.VSCode.savedState/
rm -fr ~/.vscode/
rm -rf ~/.vscode*

# Réinstaller VSCode
mkdir $HOME/Library/Application\ Support/Code
mkdir $HOME/Library/Application\ Support/Code/User
cp $BACKUP_DIR/settings.json $HOME/Library/Application\ Support/Code/User/
cp $BACKUP_DIR/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json
cp -r $BACKUP_DIR/snippets $HOME/Library/Application\ Support/Code/User/
bash $BACKUP_DIR/extensions.sh
```

N'hésitez pas à utiliser et à modifier ces scripts en fonction de vos besoins spécifiques. Profitez de la gestion facile de votre configuration VSCode !
