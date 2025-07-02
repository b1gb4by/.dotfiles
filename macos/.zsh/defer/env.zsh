# homebrew
eval "$(/usr/local/bin/brew shellenv)"

# mise
eval "$(mise activate zsh)"

# krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# golang
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$GOPATH/bin
