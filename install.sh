#!/usr/bin/env bash
set -euo pipefail

# Flags
DRY_RUN=0
for arg in "$@"; do
  if [[ "$arg" == "--dry-run" ]]; then
    DRY_RUN=1
  fi
done

pathToScript=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cmdExists() { type -t "$1" &> /dev/null; }

dirIsEmpty() {
  if [ -d "$1" ]; then
    if [ "$(ls -A "$1")" ]; then
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
    if [[ $DRY_RUN -eq 1 ]]; then
      echo "rm -rf \"$2\""
    else
      rm -rf "$2" || echo "warning: failed to remove existing link: $2"
    fi
  fi
  if [[ $DRY_RUN -eq 1 ]]; then
    echo "ln -fsv -- \"$1\" \"$2\""
  else
    ln -fsv -- "$1" "$2" || echo "warning: failed to create symlink: $2 -> $1"
  fi
  return 0
}

# $1:sourceFolder $2:target $3:prefix
createSymLinks() {
  local source_folder="$1"
  local target_folder="$2"
  local prefix="${3-}"
  for filename in "$source_folder"/*; do
    source="$pathToScript/$filename"
    target="$target_folder/${prefix}${filename##*/}"
    createSymLink "$source" "$target"
  done
}
##########
modulesdir="$pathToScript/modules"
if [ ! -d "$modulesdir" ]; then
  echo "submodules folder does not exist"
  exit 1
else
  if dirIsEmpty "$modulesdir"; then
    echo "submodules not installed"
    exit 1
  fi
fi

########## home
createSymLinks "home" "$HOME" .

########## hammerspoon
case "$(uname)" in
  Darwin)
    hammerspoondir=~/.hammerspoon
    if [ -d "$hammerspoondir" ]; then
      createSymLinks hammerspoon $hammerspoondir
    else
      echo "hammerspoon not installed"
    fi
    ;;
esac

##########
if ! cmdExists vim; then
  echo "vim is not installed"
else
  vimdir=~/.vim
  if [ ! -d "$vimdir" ]; then
    if [[ $DRY_RUN -eq 1 ]]; then
      echo "mkdir \"$vimdir\""
    else
      mkdir "$vimdir"
    fi
  fi

  ##########
  vimcolorsdir=$vimdir/colors
  if [ ! -d "$vimcolorsdir" ]; then
    if [[ $DRY_RUN -eq 1 ]]; then
      echo "mkdir \"$vimcolorsdir\""
    else
      mkdir "$vimcolorsdir"
    fi
  fi

  ##########
  vimcolorschemefolder=$modulesdir/smyck-color-scheme
  vimcolorscheme=smyck.vim
  source=$vimcolorschemefolder/$vimcolorscheme
  if [ -f "$source" ]; then
    target=$vimcolorsdir/$vimcolorscheme
    createSymLink "$source" "$target"
  else
    echo "no color scheme"
  fi

  ##########
  vimpacksdir=$vimdir/pack
  if [ ! -d "$vimpacksdir" ]; then
    if [[ $DRY_RUN -eq 1 ]]; then
      echo "mkdir \"$vimpacksdir\""
    else
      mkdir "$vimpacksdir"
    fi
  fi

  vimpacksdir=$vimpacksdir/alphalpha
  if [ ! -d "$vimpacksdir" ]; then
    if [[ $DRY_RUN -eq 1 ]]; then
      echo "mkdir \"$vimpacksdir\""
    else
      mkdir "$vimpacksdir"
    fi
  fi

  vimpacksdir=$vimpacksdir/start
  if [ ! -d "$vimpacksdir" ]; then
    if [[ $DRY_RUN -eq 1 ]]; then
      echo "mkdir \"$vimpacksdir\""
    else
      mkdir "$vimpacksdir"
    fi
  fi

  ##########
  gutentagsdir=vim-gutentags
  source=$modulesdir/$gutentagsdir
  if [ -d "$source" ]; then
    target=$vimpacksdir/$gutentagsdir
    createSymLink "$source" "$target"
  else
    echo "gutentags module not present"
  fi

  ##########
  rustvimdir=rust.vim
  source=$modulesdir/$rustvimdir
  if [ -d "$source" ]; then
    target=$vimpacksdir/$rustvimdir
    createSymLink "$source" "$target"
  else
    echo "rust.vim module not present"
  fi

  ##########
  blackdir=black/plugin
  source=$modulesdir/$blackdir
  if [ -d "$source" ]; then
    target=$vimpacksdir/$blackdir
    createSymLink "$source" "$target"
  else
    echo "black module not present"
  fi
fi

##########
source=$pathToScript/lazygit/config.yml
# Determine lazygit config directory per OS
case "$(uname)" in
  Darwin)
    lazygitdir="$HOME/Library/Application Support/lazygit"
    ;;
  Linux)
    lazygitdir="$HOME/.config/lazygit"
    ;;
  *)
    lazygitdir=""
    ;;
esac

if [ -n "$lazygitdir" ] && [ -d "$lazygitdir" ]; then
  target="$lazygitdir/config.yml"
  createSymLink "$source" "$target"
else
  echo "lazygit directory does not exist or unsupported OS"
  fi