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
step "[1/9] Installation de Zsh..."
sudo apt install -y zsh
ok "Zsh installé."

step "Configuration de Zsh comme shell par défaut pour $USER..."
sudo usermod -s $(which zsh) $USER
ok "Shell par défaut changé vers Zsh."

# -----------------------------------------------------------------------------
# Étape 2 : Installation de Neofetch (affichage des infos système)
# -----------------------------------------------------------------------------
step "[2/9] Installation de Neofetch..."
sudo apt install -y neofetch
ok "Neofetch installé."

# -----------------------------------------------------------------------------
# Étape 3 : Installation de Tmux (multiplexeur de terminal)
# -----------------------------------------------------------------------------
step "[3/9] Installation de Tmux..."
sudo apt install -y tmux
ok "Tmux installé."

# -----------------------------------------------------------------------------
# Étape 4 : Installation des dépendances pour compiler Neovim
# -----------------------------------------------------------------------------
step "[4/9] Installation des dépendances de compilation (ninja, cmake, curl, etc.)..."
sudo apt-get install -y ninja-build gettext cmake curl build-essential git
ok "Dépendances de compilation installées."

# -----------------------------------------------------------------------------
# Étape 5 : Installation de Lazygit (interface git en terminal)
# -----------------------------------------------------------------------------
step "[5/9] Installation de Lazygit..."

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
step "[6/9] Installation de Tree-sitter..."

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
step "[7/9] Installation de fzf..."
sudo apt install -y fzf
ok "fzf installé."

# -----------------------------------------------------------------------------
# Étape 8 : Installation de ripgrep et fd (outils de recherche rapide)
# -----------------------------------------------------------------------------
step "[8/9] Installation de ripgrep et fd-find..."

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
# Étape 9 : Compilation et installation de Neovim depuis les sources
# -----------------------------------------------------------------------------
step "[9/9] Clonage et compilation de Neovim depuis les sources..."

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
