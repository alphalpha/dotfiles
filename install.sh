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
modulesdir=$pathToScript/modules
if [ ! -d "$modulesdir" ]; then
  echo "no modules present" 
fi

##########
vimdir=~/.vim
if [ ! -d "$vimdir" ]; then
  mkdir $vimdir
fi

##########
vimcolorsdir=$vimdir/colors
if [ ! -d "$vimcolorsdir" ]; then
  mkdir $vimcolorsdir
fi

##########
vimcolorschemefolder=$modulesdir/smyck-color-scheme
vimcolorscheme=smyck.vim
source=$vimcolorschemefolder/$vimcolorscheme
if [ -f "$source" ]; then
  target=$vimcolorsdir/$vimcolorscheme
  if [ -f "$target" ]; then
    rm -rf $target
  fi
  echo "link ${source} to ${target} in home directory."
  ln -fs ${source} ${target}
else
  echo "no color scheme"
fi

##########
vimpacksdir=$vimdir/pack
if [ ! -d "$vimpacksdir" ]; then
  mkdir $vimpacksdir
fi

vimpacksdir=$vimpacksdir/alphalpha
if [ ! -d "$vimpacksdir" ]; then
  mkdir $vimpacksdir
fi

vimpacksdir=$vimpacksdir/start
if [ ! -d "$vimpacksdir" ]; then
  mkdir $vimpacksdir
fi

##########
gutentagsdir=vim-gutentags
source=$modulesdir/$gutentagsdir
if [ -d "$source" ]; then
  target=$vimpacksdir/$gutentagsdir
  if [ -d "$target" ]; then
    rm -rf $target
  fi
  echo "link ${source} to ${target} in home directory."
  ln -fs ${source} ${target}
else
  echo "gutentags module not present"
fi
