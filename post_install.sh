#!/usr/bin/env bash

#----- System Update
sudo apt-get update ; sudo apt-get upgrade -y

#----- Tilix
sudo apt-get install tilix -y
sudo update-alternatives --set x-terminal-emulator /usr/bin/tilix.wrapper

#- Tilix fix
echo "if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi" >> ~/.zshrc
sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh

#----- Zsh
sudo apt-get install zsh git curl -y
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
FONTS=(https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Regular.ttf
https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Bold.ttf
https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Bold%20Italic.ttf
wget https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Italic.ttf
)

#- Installing fonts

for i in {0..4} ; do
	wget ${FONTS[i]} -P ~/Downloads
done

mkdir ~/.local/share/fonts
mv ~/Downloads/*.ttf ~/.local/share/fonts
sudo fc-cache -fv

#- Clipboard
sudo apt-get install xclip -y 

#- Custom plugins

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo "Add \"zsh-autosuggestions\" & \"zsh-syntax-highlighting\" to your ~/.zshrc file"
sleep 2
sudo sed -i s#"plugins=(git)"#"plugins=(git zsh-syntax-highlighting zsh-autosuggestions)"#g ~/.zshrc
source ~/.zshrc

#----- Applications

#- VSCode
wget https://az764295.vo.msecnd.net/stable/ea3859d4ba2f3e577a159bc91e3074c5d85c0523/code_1.52.1-1608136922_amd64.deb -O ~/Downloads/code.deb
sudo dpkg -i ~/Downloads/code.deb
sudo sed -i s#"\[arch=amd64,arm64,armhf\]"#"[arch=amd64]"#g /etc/apt/sources.list.d/vscode.list
sudo apt-get install -fy

#- Atom
wget "https://atom-installer.github.com/v1.53.0/atom-amd64.deb?s=1605024603&ext=.deb" -O ~/Downloads/atom.deb
sudo dpkg -i ~/Downloads/atom.deb
sudo apt-get install -fy

#--- Asdf
sudo apt-get install curl git -y
sudo apt-get install -fy
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
git checkout "$(git describe --abbrev=0 --tags)"
cd
echo ". $HOME/.asdf/asdf.sh" >> ~/.zshrc
source ~/.zshrc

#- Python
asdf plugin-add python
sudo apt-get update; sudo apt-get install --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev -y
asdf install python 3.9.1
asdf global python 3.9.1

#- Rust
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
asdf install rust 1.49.0
asdf global 1.49.0

#- nodejs
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
asdf install nodejs 14.15.3
asdf global nodejs 14.15.3

#- deno
asdf plugin-add deno https://github.com/asdf-community/asdf-deno.git
asdf install deno 1.6.3
asdf global deno 1.6.3

#- .NET
wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O ~/Downloads/packages-microsoft-prod.deb
sudo dpkg -i ~/Downloads/packages-microsoft-prod.deb
sudo sed -i s#"\[arch=amd64,arm64,armhf\]"#""#g /etc/apt/sources.list.d/microsoft-prod.list

sudo apt-get install -fy
sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-5.0
sudo apt-get install -fy

#- Ruby
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf install ruby 2.7.1
asdf global ruby 2.7.1

#- AnyDesk
wget "https://download.anydesk.com/linux/anydesk_6.0.1-1_amd64.deb?_ga=2.245014720.432199673.1609535076-1367798382.1609535076" -O ~/Downloads/anydesk.deb
sudo dpkg -i ~/Downloads/anydesk.deb
sudo apt-get install -fy
sudo systemctl stop anydesk.service
sudo systemctl disable anydesk.service

#- Bitwarden
sudo snap install bitwarden

#- silversearcher-ag
sudo apt-get install silversearcher-ag
sudo apt-get install -fy

#- fd-find
sudo apt-get install fd-find
sudo apt-get install -fy

#- GHex
sudo apt-get install ghex -y
sudo apt-get install -fy

#- Google Chrome
wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -O ~/Downloads/chrome.deb
sudo dpkg -i ~/Downloads/chrome.deb
sudo apt-get install -fy

#- Lutris
echo "deb http://download.opensuse.org/repositories/home:/strycore/Debian_10/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list
wget -q https://download.opensuse.org/repositories/home:/strycore/Debian_10/Release.key -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install lutris -y
sudo apt-get install -fy

sudo dpkg --add-architecture i386
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install libgl1-mesa-dri:i386 mesa-vulkan-drivers mesa-vulkan-drivers:i386 -y

#- TLP
sudo apt-get install tlp -y
sudo apt-get install -fy
sudo systemctl start tlp
sudo systemctl enable tlp

#- Teams
wget "https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_1.3.00.30857_amd64.deb" -O ~/Downloads/teams.deb
sudo dpkg -i ~/Downloads/teams.deb
sudo apt-get install -fy

#- OBS
sudo apt-get install ffmpeg obs-studio -y
sudo apt-get install -fy

#- Olive (WIP!!!!!)

#- PdfArranger
sudo apt-get install pdfarranger -y
sudo apt-get install -fy

#- Qbittorrent
sudo apt-get install qbittorrent -y
sudo apt-get install -fy

#- Slack
wget "https://downloads.slack-edge.com/linux_releases/slack-desktop-4.12.0-amd64.deb" -O ~/Downloads/slack.deb
sudo dpkg -i ~/Downloads/slack.deb
sudo apt-get install -fy

#- Spotify
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client -y

#- Steam
sudo apt-get install python-apt -y
wget "https://repo.steampowered.com/steam/archive/precise/steam_latest.deb" -O ~/Downloads/steam.deb
sudo dpkg -i ~/Downloads/steam.deb
sudo apt-get install -fy

#- Telegram
wget "https://updates.tdesktop.com/tlinux/tsetup.2.5.1.tar.xz" -O ~/Downloads/telegram.tar.xz
cd ~/Downloads
tar -xvf ./telegram.tar.xz
./Telegram/Telegram 
cd

#- Wireshark
sudo apt-get install wireshark-gtk -y
sudo apt-get install -fy

#- VLC
sudo apt-get install vlc -y
sudo apt-get install -fy

#- XMind
wget "https://dl3.xmind.net/XMind-2020-for-Linux-amd-64bit-10.2.1-202008051959.deb" -O ~/Downloads/xmind.deb
sudo dpkg -i ~/Downloads/xmind.deb
sudo apt-get install -fy

#- Vivaldi
wget "https://downloads.vivaldi.com/stable/vivaldi-stable_3.5.2115.81-1_amd64.deb" -O ~/Downloads/vivaldi.deb
sudo dpkg -i ~/Downloads/vivaldi.deb
sudo apt-get install -fy

#- Wine
wget "https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10/Release.key" -O ~/Downloads/Release.key
cd ~/Downloads
sudo apt-key add Release.key
echo "deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10/ ./" | sudo tee /etc/apt/sources.list.d/wine.list
sudo apt-get update
sudo apt-get install winehq-staging -y
sudo apt-get install -fy

#- Coreutils + Advcpmv
cd ~/Downloads
wget http://ftp.gnu.org/gnu/coreutils/coreutils-8.32.tar.xz
tar xvJf coreutils-8.32.tar.xz
cd coreutils-8.32/
wget https://raw.githubusercontent.com/jarun/advcpmv/master/advcpmv-0.8-8.32.patch
patch -p1 -i advcpmv-0.8-8.32.patch
./configure
make
cd ..
sudo mv ./coreutils-8.32 /opt/coreutils
echo "export PATH=/opt/coreutils/src:$PATH" >> ~/.zshrc
echo 'alias cp="cp -vg"' >> ~/.zshrc
echo 'alias mv="mv -vg"' >> ~/.zshrc

#--- Flatpak
sudo apt-get install flatpak -y
sudo apt-get install -fy
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#- Avvie
flatpak install flathub com.github.taiko2k.avvie -y

#- Drawing
flatpak install flathub com.github.maoschanz.drawing -y

#- Foliate
flatpak install flathub com.github.johnfactotum.Foliate -y

#- GIMP
wget "https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref" -P ~/Downloads
cd ~/Downloads
flatpak install org.gimp.GIMP.flatpakref -y
cd

#- Inkscape
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --user flathub org.inkscape.Inkscape -y

#- Lollypop
flatpak install flathub org.gnome.Lollypop -y

#- Flameshot
flatpak install flathub org.flameshot.Flameshot -y

#- Peek
flatpak install flathub com.uploadedlobster.peek -y

#- Stremio
wget "https://dl.strem.io/shell-linux/v4.4.120/Stremio+4.4.120.flatpak" -O ~/Downloads/stremio.flatpak
cd ~/Downloads
sudo flatpak install stremio.flatpak -y
cd

#- Discord
flatpak install flathub com.discordapp.Discord

# Update
sudo apt-get update && sudo apt-get upgrade -y

#----- Visuals

#- Theme
gsettings set org.gnome.desktop.interface gtk-theme '"Adwaita-dark"'

#- Icon Theme
sudo sh -c "echo 'deb http://ppa.launchpad.net/papirus/papirus/ubuntu focal main' > /etc/apt/sources.list.d/papirus-ppa.list"

sudo apt-get install dirmngr
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com E58A9D36647CAE7F
sudo apt-get update
sudo apt-get install papirus-icon-theme
sudo apt-get install -fy

gsettings set org.gnome.desktop.interface icon-theme '"Papirus-Dark"'

#- Cursor theme
wget https://dllb2.pling.com/api/files/download/j/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE1ODI0NDIyNzYiLCJ1IjpudWxsLCJsdCI6ImRvd25sb2FkIiwicyI6ImNjN2IyZmNkYWNkZWJkYThiYjhmODEwZTcxZDRiMzU1NjA3Mjc3OTdlMDhkZjZjYThkYjFkYmFhMDViNzk4MDg0YTU2OTNlODc0YWJiM2Y3NDMwMTcyMjk4MTg5OTU1ZDY2YzgxMTkzMGVhMGQ5ZTlhMzdmNjQxMjQ0NWZkOWYyIiwidCI6MTYwOTUzMjMzNywic3RmcCI6ImI5NDRjZDVlNTI0Yzc5OTAwMTViNzFmMGRlOGI0NTM5Iiwic3RpcCI6IjE4Ny4xMTIuMjMuMTY1In0.Q-F6g61jZ53z8kHGFMhtIC8XQRWxJOY6SC7gHB4GM2o/01-Vimix-cursors.tar.xz -O ~/Downloads/Vimix.tar.xz

tar -xvf ~/Downloads/Vimix.tar.xz -C ~/Downloads
sudo mv ~/Downloads/Vimix-cursors /usr/share/icons

#- Wallpaper
gsettings set org.gnome.desktop.background picture-options '"wallpaper"'
wget "https://i.imgur.com/l0nkL2F.jpg" -O ~/Pictures/bg.jpg
gsettings set org.gnome.desktop.background picture-uri file:///home/carlos/Pictures/bg.jpg

gsettings get org.gnome.desktop.screensaver picture-options '"wallpaper"'
wget "https://i.imgur.com/1ifd1AD.jpg" -O ~/Pictures/mountain.jpg
gsettings set org.gnome.desktop.screensaver picture-uri file:///home/carlos/Pictures/mountain.jpg

#- Grub
wget "https://dllb2.pling.com/api/files/download/j/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE1NzIyNTA5MjciLCJ1IjpudWxsLCJsdCI6ImRvd25sb2FkIiwicyI6ImQ1MmM2MzI3YjYxYWQ1MGE5YzhhMWRkNTI0ZTZlMDJhMWJkZTVkMjg1NzczYWZkZTAyZTU0NmM4ZjhjNWVjZTY0OTZkZWU5MzAzODAzYzdlMTdiNTJhYWI0MWFiN2E0ZmYzODFiYWU5ZjkwYzI0OGQyZWZhMjU5YTEzZGM5MzE5IiwidCI6MTYwOTU0MzU4NSwic3RmcCI6IjQ0YzhlMGE3M2U5YTg3YzNiNzZhMmQ2N2U0YTM0MWE2Iiwic3RpcCI6IjE4Ny4xMTIuMjMuMTY1In0.P5iWCqh4QMSOJMPsc9zkt2F6colwpOItFF1vA5SozsU/Tela-1080p.tar.xz" -O ~/Downloads/grub-theme.tar.xz
cd ~/Downloads
tar -xvf ./grub-theme.tar.xz
cd ./Tela-1080p
sudo ./install.sh
sudo update-grub

#----- ETC

#- Mouse natural scroll
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true

#- Touchpad tap-to-click
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

#- Weather
gsettings set org.gnome.Weather.Application locations "[<(uint32 2, <('Recife', 'SBRF', true, [(-0.14078989881197343, -0.60824724432002386)], [(-0.14049900478554353, -0.60911990894602097)])>)>]"
gsettings set org.gnome.GWeather temperature-unit "'centigrade'"

#- World clocks
gsettings set org.gnome.clocks world-clocks "[{'location': <(uint32 2, <('Coordinated Universal Time (UTC)', '@UTC', false, @a(dd) [], @a(dd) [])>)>}]"

#- Additional packages
sudo apt-get install build-essential default-jdk libssl-dev exuberant-ctags ncurses-term ack-grep silversearcher-ag fontconfig imagemagick libmagickwand-dev software-properties-common git vim-gtk3 curl -y
sudo apt-get install -fy

#- Taskbar
gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'vivaldi-stable.desktop', 'discord.desktop', 'code.desktop', 'atom.desktop', 'org.gexperts.Tilix.desktop']"

#- SSD Optimization
sudo cp /usr/share/systemd/tmp.mount /etc/systemd/system/
sudo systemctl enable tmp.mount

- Custom ZSH theme

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sudo sed -i s#robbyrussell#powerlevel10k/powerlevel10k#g ~/.zshrc
