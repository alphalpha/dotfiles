#!/bin/sh

pathToScript=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cmdExists() { type -t "$1" &> /dev/null; }

dirIsEmpty() {
  if [ -d $1 ]; then
    if [ "$(ls -A $1)" ]; then
      return 1;
    else
      return 0;
    fi
  else
   echo "$1 is not a directory"
   exit 99
  fi
}

# $1:source $2:target
createSymLink() {
  if [ -L "$2" ]; then
    rm -rf "$2"
  fi
  ln -fsv "$1" "$2"
}

# $1:sourceFolder $2:target $3:prefix
createSymLinks() {
  for filename in $1/*; do
    source=$pathToScript/$filename
    target=$2/$3${filename##*/}
    createSymLink $source $target
  done
}
##########
modulesdir=$pathToScript/modules
if [ ! -d "$modulesdir" ]; then
  echo "submodules folder does not exist"
  exit 1
else
  if dirIsEmpty $modulesdir; then
    echo "submodules not installed"
    exit 1
  fi
fi

########## home
createSymLinks home ~ .

########## hammerspoon
if [[ "$OSTYPE"=="darwin"* ]]; then
  hammerspoondir=~/.hammerspoon
  if [ -d "$hammerspoondir" ]; then
    createSymLinks hammerspoon $hammerspoondir
  else
    echo "hammerspoon not installed"
  fi
fi

##########
if ! cmdExists vim; then
  echo "vim is not installed"
else
  vimdir=~/.vim
  if [ ! -d "$vimdir" ]; then
    mkdir "$vimdir"
  fi

  ##########
  vimcolorsdir=$vimdir/colors
  if [ ! -d "$vimcolorsdir" ]; then
    mkdir "$vimcolorsdir"
  fi

  ##########
  vimcolorschemefolder=$modulesdir/smyck-color-scheme
  vimcolorscheme=smyck.vim
  source=$vimcolorschemefolder/$vimcolorscheme
  if [ -f "$source" ]; then
    target=$vimcolorsdir/$vimcolorscheme
    createSymLink $source $target
  else
    echo "no color scheme"
  fi

  ##########
  vimpacksdir=$vimdir/pack
  if [ ! -d "$vimpacksdir" ]; then
    mkdir "$vimpacksdir"
  fi

  vimpacksdir=$vimpacksdir/alphalpha
  if [ ! -d "$vimpacksdir" ]; then
    mkdir "$vimpacksdir"
  fi

  vimpacksdir=$vimpacksdir/start
  if [ ! -d "$vimpacksdir" ]; then
    mkdir "$vimpacksdir"
  fi

  ##########
  gutentagsdir=vim-gutentags
  source=$modulesdir/$gutentagsdir
  if [ -d "$source" ]; then
    target=$vimpacksdir/$gutentagsdir
    createSymLink $source $target
  else
    echo "gutentags module not present"
  fi

  ##########
  rustvimdir=rust.vim
  source=$modulesdir/$rustvimdir
  if [ -d "$source" ]; then
    target=$vimpacksdir/$rustvimdir
    createSymLink $source $target
  else
    echo "rust.vim module not present"
  fi

  ##########
  blackdir=black
  source=$modulesdir/$blackdir
  if [ -d "$source" ]; then
    target=$vimpacksdir/$blackdir
    createSymLink $source $target
  else
    echo "black module not present"
  fi
fi

