#!/bin/bash

pathToScript=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

##########

for filename in src/*; do
  source=$pathToScript/$filename
  target=~/.${filename##*/}
  echo "link ${source} to ${target} in home directory."
  ln -fs ${source} ${target}
done

##########

vimcolorschemefolder=modules/smyck-color-scheme
vimcolorscheme=smyck.vim
source=$pathToScript/$vimcolorschemefolder/$vimcolorscheme
target=~/.vim/colors/$vimcolorscheme
echo "link ${source} to ${target} in home directory."
ln -fs ${source} ${target}

##########

gutentagsfolder=vim-gutentags
source=$pathToScript/modules/$gutentagsfolder
target=~/.vim/pack/alphalpha/start/$gutentagsfolder
echo "link ${source} to ${target}."
ln -fs ${source} ${target}
