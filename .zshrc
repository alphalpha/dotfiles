# Use local settings if it exists
if [[ -s "`eval echo ~`/.zshrc-local" ]]; then
  echo "source zshrc-local"
  source ~/.zshrc-local
fi

# Source aliases
if [[ -s "`eval echo ~`/.dotfiles/.zsh-aliases" ]]; then
  echo "source zsh-aliases"
  source ~/.dotfiles/.zsh-aliases
fi

# Source aliases
if [[ -s "`eval echo ~`/.antigen.zsh" ]]; then
  echo "source antigen"
  source ~/.antigen.zsh

# Load the oh-my-zsh's library.
  antigen use oh-my-zsh

# Bundles from the default repo (oh-my-zsh)
  antigen bundle common-aliases
  antigen-bundle git
  antigen bundle git-extras
  antigen bundle git-flow
  antigen bundle z

  if [ "$OSTYPE"="darwin11.0" ]; then
    antigen-bundle osx
  fi

# none oh-my-zsh bundles
  antigen bundle zsh-users/zsh-syntax-highlighting
  antigen bundle zsh-users/zsh-history-substring-search ./zsh-history-substring-search.zsh

# Load the theme.
  antigen theme nanotech

# Tell antigen that you're done.
  antigen apply
fi
