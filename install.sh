#!/bin/bash

pathToScript=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

##########

for filename in src/*; do
  source=$pathToScript/$filename
  target=~/.${filename##*/}
  echo "link ${source} to ${target} in home directory."
  ln -fs ${source} ${target}
done
