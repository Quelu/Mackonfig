#!/bin/sh
# -- Mac Install

START_TIME=$SECONDS

# CWD
DOTFILES_DIR="$( cd "$( dirname "${(%):-%x}" )" && pwd )"

echo ""
echo ""
echo ""
echo "----- Install tools for XCode -----"

if [[ ! -d "$('xcode-select' -print-path 2>/dev/null)" ]]; then
    sudo xcode-select -switch /usr/bin
fi

echo ""
echo ""
echo ""
echo "----- Install gems -----"
sudo gem update --system
sudo gem install cocoapods

echo ""
echo ""
echo ""
echo "----- Install homebrew & cask -----"

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions
brew tap caskroom/fonts

echo ""
echo ""
echo ""
echo "----- Install brew's -----"

brew update
brew upgrade
brew install $(cat "$DOTFILES_DIR/Brewfile"|grep -v "#")
brew cleanup

local binroot="$(brew --config | awk '/HOMEBREW_PREFIX/ {print $2}')"/bin

echo ""
echo ""
echo ""
echo "----- Install app's from Cask -----"

export HOMEBREW_CASK_OPTS="--appdir=/Applications"
brew cask install $(cat "$DOTFILES_DIR/Caskfile"|grep -v "#")
qlmanage -r


echo ""
echo ""
echo ""
echo "----- Install useful global npm packages -----"

npm install -g bower browserify coffee-script grunt grunt-cli gulp stylus watchify yo polymer-cli firebase-tools

echo ""
echo ""
echo ""
echo "----- Install apm packages -----"

apm install package-sync

echo ""
echo ""
echo ""
echo "----- Install python packages -----"

pip install -I Cython==0.23
USE_OSX_FRAMEWORKS=0 pip install kivy
pip install pygments

echo ""
echo ""
echo ""
echo "----- Generate directory structure -----"

mkdir -p ~/Works/graphic
mkdir -p ~/Works/dev
mkdir -p ~/Works/misc
mkdir -p ~/Works/resources

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo ""
echo ""
echo ""
echo "-----------------------------"
echo "----- Mac Install ended -----"
echo "-----------------------------"
echo "Duration : $(($ELAPSED_TIME/60)) min $(($ELAPSED_TIME%60)) sec"
echo "-------------------------"