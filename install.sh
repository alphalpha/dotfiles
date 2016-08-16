#!/bin/bash

pathToScript=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

##########

for filename in src/*; do
  echo "creating symlink to ~/.${filename##*/} in home directory."
  ln -fs $pathToScript/$filename ~/.${filename##*/}
done
