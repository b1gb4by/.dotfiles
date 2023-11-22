# homebrew
eval "$(/usr/local/bin/brew shellenv)"

# asdf
# . /usr/local/opt/asdf/libexec/asdf.sh

# krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# node
if [[ $(arch) == "arm64" ]]; then
    eval "$(fnm env --arch arm64 --use-on-cd)"
else
    eval "$(fnm env --use-on-cd)"
fi

# golang
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$GOPATH/bin

# java
export JAVA_HOME=`/usr/libexec/java_home -v xx`
