# lsd
alias ls='lsd'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# clear
alias cls='clear'

# edit the .vimrc ()
alias vim='nvim'
alias vv='vim ~/.vimrc'

# edit the .zshrc.XX
alias vz='vim ~/.zshrc'

# Reflecting the .zshrc
alias sz='source ~/.zshrc'

# file control
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# # ssh reload
# alias ssh-reload='cat ~/.ssh/config.d/_config.common ~/.ssh/config.d/*/config >! ~/.ssh/config && chmod 700 ~/.ssh/config && echo "~/.ssh/config reloaded"'

# docker
alias d='docker'
alias dclean='docker rm -v $(docker ps -a -q -f status=exited)'
alias dclean-none='docker rmi $(docker images -f "dangling=true" -q)'

# gcloud
alias gc='gcloud'

# kubectl
alias k='kubectl'
alias kk='kubectl krew'

# helm
alias h='helm'

# Color Diff
if [[ -x `which colordiff` ]]; then
    alias diff='colordiff -u'
else
    alias diff='diff -u'
fi

# rga
rga-fzf() {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
}

# fd-fzf - find with fzf
function fdzf() {
    local target_dir=$(fd -t d -I -H -E ".git"| fzf-tmux --reverse --query="$LBUFFER")
    local current_dir=$(pwd)

    if [ -n "$target_dir" ]; then
        BUFFER="cd ${current_dir}/${target_dir}"
        zle accept-line
    fi

    zle reset-prompt
}
zle -N fdzf
bindkey "^n" fdzf

# fbr - checkout git branch
fbr() {
    local branches branch
    branches=$(git branch -vv) &&
    branch=$(echo "$branches" | fzf +m) &&
    git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# fshow - git commit browser
fshow() {
    git log --graph --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
        --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fzf-select-history(Ctrl+R) -
function fzf-select-history() {
    BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history

# batdiff - git diff with bat
batdiff() {
    git diff --name-only --diff-filter=d | xargs bat --diff
}

# fcat - cat to narrow down the files under the current directory
fcat (){
    local selected
    if [ $# = 0 ];then
        selected=$(fd --color=always -t f | fzf --preview "bat  --color=always --style=header,grid --line-range :100 {}")
    else
        if [ -f $1 ]; then
        selected=$1
        else
        selected=$(fd --color=always -t f | fzf --query "$1" --preview "bat  --color=always --style=header,grid --line-range :100 {}")
        fi
    fi

    if [ -n "$selected" ];then
        print -s "bat $selected"
        bat $selected
    else
        echo "No file is selected"
    fi
}
