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
step "[1/12] Installation de Zsh..."
sudo apt install -y zsh
ok "Zsh installé."

step "Configuration de Zsh comme shell par défaut pour $USER..."
sudo usermod -s $(which zsh) $USER
ok "Shell par défaut changé vers Zsh."

# -----------------------------------------------------------------------------
# Étape 2 : Installation de Neofetch (affichage des infos système)
# -----------------------------------------------------------------------------
step "[2/12] Installation de Neofetch..."
sudo apt install -y neofetch
ok "Neofetch installé."

# -----------------------------------------------------------------------------
# Étape 3 : Installation de Tmux (multiplexeur de terminal)
# -----------------------------------------------------------------------------
step "[3/12] Installation de Tmux..."
sudo apt install -y tmux

step "Clonage de tpm"
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
ok "Tmux installé."

# -----------------------------------------------------------------------------
# Étape 4 : Outils de base + toolchain C (requise par les parsers treesitter)
# -----------------------------------------------------------------------------
step "[4/12] Installation des outils de base (curl, git, compilateur C)..."
sudo apt-get install -y curl build-essential git unzip
ok "Outils de base installés."

# -----------------------------------------------------------------------------
# Étape 5 : Installation de Lazygit (interface git en terminal)
# -----------------------------------------------------------------------------
step "[5/12] Installation de Lazygit..."

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
step "[6/12] Installation de Tree-sitter..."

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
step "[7/12] Installation de fzf..."
curl -Lo $HOME/install-tmp/fzf.tar.gz "https://github.com/junegunn/fzf/releases/download/v0.67.0/fzf-0.67.0-linux_amd64.tar.gz"
tar -xzf $HOME/install-tmp/fzf.tar.gz -C $HOME/install-tmp
sudo mv $HOME/install-tmp/fzf /usr/local/bin/fzf
ok "fzf installé."

# -----------------------------------------------------------------------------
# Étape 8 : Installation de ripgrep et fd (outils de recherche rapide)
# -----------------------------------------------------------------------------
step "[8/12] Installation de ripgrep et fd-find..."

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
step "[9/12] Installation de yazi..."

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

# -----------------------------------------------------------------------------
# Étape 10 : Installation de NVM + Node.js LTS
# -----------------------------------------------------------------------------
step "[10/12] Installation de NVM..."

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
# Étape 11 : Installation de Neovim (dernière version stable)
# -----------------------------------------------------------------------------
step "[11/12] Installation de Neovim..."

# On installe le binaire officiel précompilé plutôt que de compiler depuis les
# sources : `git clone` sans tag récupère master (nightly), donc une version
# différente à chaque exécution.
NVIM_VERSION=$(curl -s "https://api.github.com/repos/neovim/neovim/releases/latest" | \grep -Po '"tag_name": *"\K[^"]*')
echo "  → Version stable détectée : ${NVIM_VERSION}"

echo "  → Téléchargement de l'archive..."
curl -Lo $HOME/install-tmp/nvim.tar.gz \
  "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.tar.gz"

# Purge de toute install précédente, y compris une compilation `make install`
# qui aurait éparpillé binaire et runtime dans /usr/local.
echo "  → Suppression de l'éventuelle install précédente..."
sudo rm -rf /usr/local/bin/nvim /usr/local/share/nvim /opt/nvim-linux-x86_64

# L'archive contient bin/ et share/nvim/runtime/ du même build : on l'extrait
# d'un bloc. Neovim résout $VIMRUNTIME relativement au chemin réel du binaire,
# donc le runtime reste toujours en phase avec lui (pas de E5009 possible).
echo "  → Extraction dans /opt..."
sudo tar -C /opt -xzf $HOME/install-tmp/nvim.tar.gz

echo "  → Création du lien symbolique dans /usr/local/bin..."
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
ok "Neovim installé : $(/usr/local/bin/nvim --version | head -1)"

# -----------------------------------------------------------------------------
# Étape 12 : Installation de zoxide
# -----------------------------------------------------------------------------
step "[12/12] Installation de zoxide..."

#Exécution du script d'instalation
echo "  → Exécution du script d'instalation..."
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# -----------------------------------------------------------------------------
# Fin du script
# -----------------------------------------------------------------------------
echo -e "\n${GREEN}=============================================="
echo -e "✔ Installation terminée avec succès !"
echo -e "==============================================\n${NC}"
echo "Note : Redémarre ta session pour que le changement de shell (Zsh) soit pris en compte."
