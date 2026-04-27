#!/usr/bin/env bash
set -e

REPO="git@github.com:FishyBusinessYT/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"
function dots {
    git --git-dir="$DOTFILES_DIR/" --work-tree="$HOME" "$@"
}
cd $HOME


echo "Cloning bare dotfiles repo..."
git clone --bare $REPO $DOTFILES_DIR


echo "Backing up any pre-existing files to ./.backup-files..."
mkdir -p "$HOME/.backup-files"

# Pipe error text through stdout to grep
dots switch main 2>&1 | \
    # Grep lines with filenames (they all start with spaces)
    grep -E "^\s+" | \
    # Remove whitespace from filenames
    awk '{print $1}' | \
    # Replace {} in the mv command with the filenames we got before
    xargs -I{} mv "$HOME/{}" "$HOME/.backup-files/{}"


echo "Copying dotfiles to home directory"
dots switch main
dots config --local status.showUntrackedFiles no


echo "Installing packages from deplist..."
if command -v pacman &> /dev/null; then
    sudo pacman -S --needed - < ./deplist.txt
elif command -v dnf &> /dev/null; then
    sudo dnf install $(cat ./deplist.txt)
fi


echo "Downloading and extracting fonts..."
# Some setup
mkdir -p ./tmpfls/unzipped
mkdir -p $HOME/.local/share/fonts/

cd ./tmpfls
wget -q --output-document rodondo.zip 'https://dl.dafont.com/dl/?f=rodondo'
wget -q 'https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz'
unzip -q ./*.zip -d ./unzipped/
tar -xf ./*.tar* --directory ./unzipped/

#Remove unnecessary files
cd ./unzipped
rm ./*.txt ./*.md
rm *JetBrains*Propo*
rm *JetBrainsMono*Mono* 
rm *Extra*
rm *Light*
rm *Medium*
rm *Semi*
rm *Thin*
find -type f -name '*JetBrains*' -not -name '*NL*' -delete


echo "Copying fonts and updating font cache..."
mv -f * $HOME/.local/share/fonts
fc-cache -f


echo "Cleaning up..."
cd ../..
rm -rf ./tmpfls

echo "Done! System restart is recommended."
