#!/usr/bin/sh

echo "############### You must prepare github ssh key####################"
echo "Enter your github ssh key absolute path: "
read private_key
echo "Entered: $private_key"
echo "###################################################################"

cat << EOS > $HOME/.ssh/config
Host github.com
  HostName github.com
  User git
  Port 22
  IdentityFile $private_key
EOS
ssh -T github.com

# create src dir
mkdir $HOME/src

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew update

brew install git ghq

# 初回の ghq getp のために root 変更のみ対応
cat << EOS > $HOME/.gitconfig
[ghq]
  root = $HOME/src
EOS

# private repository
rm -rf $HOME/src/github.com/
ghq get -p hagetak/mac-setup
sh $HOME/src/github.com/hagetak/mac-setup/bin/provisioning.sh
