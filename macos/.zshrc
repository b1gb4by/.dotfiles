ZSHRC_DIR=${${(%):-%N}:A:h}

# source command override technique
function source {
  ensure_zcompiled $1
  builtin source $1
}
function ensure_zcompiled {
  local compiled="$1.zwc"
  if [[ ! -r "$compiled" || "$1" -nt "$compiled" ]]; then
    echo "\033[1;36mCompiling\033[m $1"
    zcompile $1
  fi
}
ensure_zcompiled ~/.zshrc

# sheldon cache technique
export SHELDON_CONFIG_DIR="$ZSHRC_DIR/.config/sheldon"
sheldon_cache="$SHELDON_CONFIG_DIR/sheldon.zsh"
sheldon_toml="$SHELDON_CONFIG_DIR/plugins.toml"
if [[ ! -r "$sheldon_cache" || "$sheldon_toml" -nt "$sheldon_cache" ]]; then
  sheldon source > $sheldon_cache
fi
source "$sheldon_cache"
unset sheldon_cache sheldon_toml

source $ZSHRC_DIR/.zsh/sync/*.zsh
zsh-defer source $ZSHRC_DIR/.zsh/defer/*.zsh
zsh-defer unfunction source

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/taisuke.okamoto/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"
