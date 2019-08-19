#!/usr/bin/env bash

# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install git
brew install git
git config --global user.name "kristaloverbeer"
git config --global user.email "brisemeric@gmail.com"
# To use cloning with HTTPS (recommanded) and store credentials
git config --global credential.helper osxkeychain
# Configure git aliases
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.fixup "commit --amend"

# Use librairies installed by Homebrew instead of OS ones
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile

# Change default folder for screenshots
mdkir -p ~/Screenshots; defaults write com.apple.screencapture location ~/Screenshots && killall SystemUIServer

# Delete screenshots every day
echo "0 12 * * * rm -f ~/Screenshots/*" > ~/cronjobs.txt && cron ~/cronjobs.txt

# Install xcode command line tool
xcode-select --install

# Install Quick look support for Finder
brew cask install \
    qlcolorcode \
    qlstephen \
    qlmarkdown \
    quicklook-json \
    qlprettypatch \
    quicklook-csv \
    betterzip \
    webpquicklook \
    suspicious-package

# Useful applications
brew cask install \
    alfred \
    appcleaner \
    cheatsheet \
    docker \
    google-chrome \
    spectacle \
    sublime-text \
    superduper \
    vlc

brew install \
    openssh \
    openssl \
    jq \
    tree \
    fzf \
    ack \
    vim

# Install iTerm2 and console utilities
brew cask install \
    iterm2 \
    zsh

## Install oh-my-zsh and plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
brew install zsh-syntax-highlighting

## ZSH as default shell
chsh -s $(which zsh)

# Power10k ZSH theme
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# Fzf shell extensions
/usr/local/opt/fzf/install

# Generate SSH key
ssh-keygen -t rsa -C "brisemeric@gmail.com"
eval "$(ssh-agent -s)"
ssh-add -K ~/.ssh/id_rsa

# Adding SSH key to Github account
pbcopy < ~/.ssh/id_rsa.pub

# Setup global .gitignore config
cp configuration/git/.gitignore ~/.gitignore && git config --global core.excludesfile ~/.gitignore

# Bash completion
brew install bash-completion && echo "[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion" >> ~/.bash_profile && source ~/.bash_profile

# Setup Vim
git clone https://github.com/amix/vimrc.git ~/.vim_runtime && sh ~/.vim_runtime/install_awesome_vimrc.sh
git clone https://github.com/square/maximum-awesome.git && cd maximum-awesome && rake

# Setup Sublime Text
## CLI shortcut
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

# Setup PyEnv
brew install pyenv
# echo 'eval "$(pyenv init -)"' >> ~/.bash_profile

# Check C++ version
c++ --version

# Check java version
java -version
## Install java 8
brew cask install java8

# Ruby setup
brew install rbenv ruby-build rbenv-default-gems rbenv-gemset
# echo 'eval "$(rbenv init -)"' >> ~/.zshrc && source ~/.zshrc
gem install bundler

# Rust setup
brew install rustup
rustup-init
rustc --version

## Node setup using nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh | bash
source ~/.zshrc
command -v nvm
nvm install node
nvm ls
nvm use node
nvm alias default node

# Setup go
brew install go

# Setup docker-toolbox
brew cask install docker-toolbox

# Setup MacTex
brew cask install mactex

