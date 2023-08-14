# fzf
export FZF_DEFAULT_OPTS="--prompt '🔎 ' --marker=+ --color=dark --layout=reverse --color=fg:250,fg+:15,hl:203,hl+:203 --color=info:100,pointer:15,marker:220,spinner:11,header:-1,gutter:-1,prompt:15"
export FZF_CTRL_T_COMMAND='fd --hidden --follow | rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=header,grid --line-range :100 {}"'
export FZF_COMPLETION_OPTS="-x"
_fzf_compgen_path() {
    fd --hidden --follow . "$1"
}
_fzf_compgen_dir() {
    fd --type d --hidden --follow . "$1"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
