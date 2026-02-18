#!/bin/bash

set -e # Arrête le script en cas d'erreur

# Couleurs pour les messages
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color (reset)

# Fonction utilitaire pour afficher les étapes
step() {
  echo -e "\n${BLUE}==>${NC} ${YELLOW}$1${NC}"
}

ok() {
  echo -e "${GREEN}✔ $1${NC}"
}

# -----------------------------------------------------------------------------
# Étape 1 : Installation et configuration de Zsh
# -----------------------------------------------------------------------------
step "[1/10] Installation de Zsh..."
sudo apt install -y zsh
ok "Zsh installé."

step "Configuration de Zsh comme shell par défaut pour $USER..."
sudo usermod -s $(which zsh) $USER
ok "Shell par défaut changé vers Zsh."

# -----------------------------------------------------------------------------
# Étape 2 : Installation de Neofetch (affichage des infos système)
# -----------------------------------------------------------------------------
step "[2/10] Installation de Neofetch..."
sudo apt install -y neofetch
ok "Neofetch installé."

# -----------------------------------------------------------------------------
# Étape 3 : Installation de Tmux (multiplexeur de terminal)
# -----------------------------------------------------------------------------
step "[3/10] Installation de Tmux..."
sudo apt install -y tmux
ok "Tmux installé."

# -----------------------------------------------------------------------------
# Étape 4 : Installation des dépendances pour compiler Neovim
# -----------------------------------------------------------------------------
step "[4/10] Installation des dépendances de compilation (ninja, cmake, curl, etc.)..."
sudo apt-get install -y ninja-build gettext cmake curl build-essential git
ok "Dépendances de compilation installées."

# -----------------------------------------------------------------------------
# Étape 5 : Installation de Lazygit (interface git en terminal)
# -----------------------------------------------------------------------------
step "[5/10] Installation de Lazygit..."

# Création du dossier temporaire si nécessaire
mkdir -p $HOME/install-tmp

# Récupération de la dernière version disponible via l'API GitHub
echo "  → Récupération de la dernière version de Lazygit..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
echo "  → Version détectée : v${LAZYGIT_VERSION}"

# Téléchargement de l'archive
echo "  → Téléchargement de l'archive..."
curl -Lo $HOME/install-tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

# Extraction du binaire depuis l'archive
echo "  → Extraction du binaire..."
tar xf $HOME/install-tmp/lazygit.tar.gz -C $HOME/install-tmp lazygit

# Installation du binaire dans /usr/local/bin
echo "  → Installation dans /usr/local/bin..."
sudo install $HOME/install-tmp/lazygit -D -t /usr/local/bin/
ok "Lazygit installé."

# -----------------------------------------------------------------------------
# Étape 6 : Installation de Tree-sitter (parsing incrémental pour Neovim)
# -----------------------------------------------------------------------------
step "[6/10] Installation de Tree-sitter..."

# Téléchargement du binaire compressé depuis GitHub
echo "  → Téléchargement de Tree-sitter v0.26.5..."
wget https://github.com/tree-sitter/tree-sitter/releases/download/v0.26.5/tree-sitter-linux-x64.gz -O $HOME/install-tmp/tree-sitter.gz

# Décompression, déplacement et attribution des droits d'exécution
echo "  → Décompression et installation dans /usr/local/bin..."
sudo gunzip $HOME/install-tmp/tree-sitter.gz
sudo mv $HOME/install-tmp/tree-sitter /usr/local/bin/.
sudo chmod +x /usr/local/bin/tree-sitter
ok "Tree-sitter installé."

# -----------------------------------------------------------------------------
# Étape 7 : Installation de fzf (recherche floue en ligne de commande)
# -----------------------------------------------------------------------------
step "[7/10] Installation de fzf..."
sudo apt install -y fzf
ok "fzf installé."

# -----------------------------------------------------------------------------
# Étape 8 : Installation de ripgrep et fd (outils de recherche rapide)
# -----------------------------------------------------------------------------
step "[8/10] Installation de ripgrep et fd-find..."

# ripgrep : alternative rapide à grep
sudo apt install -y ripgrep

# fd-find : alternative intuitive à find (le binaire s'appelle fdfind sur Debian/Ubuntu)
sudo apt install -y fd-find

# Création d'un lien symbolique pour appeler fd directement (au lieu de fdfind)
echo "  → Création du lien symbolique fd → fdfind..."
mkdir -p ~/.local/bin
ln -sf $(which fdfind) ~/.local/bin/fd
ok "ripgrep et fd installés."

# -----------------------------------------------------------------------------
# Étape 9 : Installation de yazi depuis le binaire précompilé
# -----------------------------------------------------------------------------
step "[9/10] Installation de yazi..."

# Installation des dépendances nécessaires pour yazi (ffmpeg, poppler-utils, imagemagick, etc.)
echo "  → Installation des dépendances..."
sudo apt install ffmpeg 7zip jq poppler-utils imagemagick

# Téléchargement de la dernière version de yazi en binary précompilé depuis GitHub
echo "  → Téléchargement du binary..."
wget -qO $HOME/install-tmp/yazi.zip https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-gnu.zip

# Décompression du binaire et installation dans /usr/local/bin
echo "  → Décompression et installation..."
unzip -q $HOME/install-tmp/yazi.zip -d $HOME/install-tmp/yazi-temp
sudo mv $HOME/install-tmp/yazi-temp/*/{ya,yazi} /usr/local/bin
ok "yazi installé."
# Étape 9 : Installation de NVM + Node.js LTS
# -----------------------------------------------------------------------------
step "[9/10] Installation de NVM..."

# Récupération de la dernière version de NVM via l'API GitHub
NVM_VERSION=$(curl -s "https://api.github.com/repos/nvm-sh/nvm/releases/latest" | \grep -Po '"tag_name": *"\K[^"]*')
echo "  → Version détectée : ${NVM_VERSION}"

# Téléchargement et exécution du script d'installation officiel de NVM
echo "  → Téléchargement et installation de NVM..."
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash
ok "NVM installé."

# Chargement de NVM dans la session courante du script (sans redémarrage)
# NVM n'est pas encore dans le PATH, on le source manuellement
echo "  → Chargement de NVM dans la session courante..."
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Installation de la dernière version LTS de Node.js
echo "  → Installation de la dernière version LTS de Node.js..."
nvm install --lts
nvm use --lts # Active la LTS comme version courante
ok "Node.js LTS installé : $(node --version)"

# -----------------------------------------------------------------------------
# Étape 10 : Compilation et installation de Neovim depuis les sources
# -----------------------------------------------------------------------------
step "[10/10] Clonage et compilation de Neovim depuis les sources..."

# Clonage du dépôt officiel Neovim
echo "  → Clonage du dépôt Neovim..."
git clone https://github.com/neovim/neovim $HOME/install-tmp/neovim

# Compilation dans le dossier cloné
echo "  → Compilation en cours (cela peut prendre plusieurs minutes)..."
cd $HOME/install-tmp/neovim
sudo make install
ok "Neovim compilé et installé."

# -----------------------------------------------------------------------------
# Fin du script
# -----------------------------------------------------------------------------
echo -e "\n${GREEN}=============================================="
echo -e "✔ Installation terminée avec succès !"
echo -e "==============================================\n${NC}"
echo "Note : Redémarre ta session pour que le changement de shell (Zsh) soit pris en compte."
