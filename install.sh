#!/bin/bash

files=".antigen.zsh .git-aliases .octaverc .tm_properties .vimrc .zshrc"
pathToScript=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

##########

for file in $files; do
  echo "creating symlink to $file in home directory."
  ln -fs $pathToScript/$file ~/$file
done