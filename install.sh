#!/bin/zsh

cd $HOME

echo Installing packages from deplist...
if command -v pacman &> /dev/null; then
    sudo pacman -S --noconfirm --needed - < ./deplist.txt
elif command -v dnf &> /dev/null; then
    sudo dnf install $(cat ./deplist.txt)
fi

# Some setup
mkdir -p ./tmpfls/unzipped
mkdir -p $HOME/.local/share/fonts/

echo Downloading and extracting fonts
cd ./tmpfls
wget -q --output-document rodondo.zip 'https://dl.dafont.com/dl/?f=rodondo'
wget -q 'https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz'
unzip -q ./*.zip -d ./unzipped/
tar -xf ./*.tar* --directory ./unzipped/

#Remove unnecessary files
cd ./unzipped
rm ./*.txt ./*.md
rm *JetBrains*Propo* *JetBrainsMono*Mono*
find -type f -name '*JetBrains*' -not -name '*NL*' -delete

echo Copying fonts and updating font cache...
mv -f * $HOME/.local/share/fonts
fc-cache -f

#Cleanup
cd ../..
rm -rf ./tmpfls

echo Done!
