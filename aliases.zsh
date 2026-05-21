alias glog="pretty_git_log"
alias glogall="pretty_git_log_all"
alias gb="pretty_git_branch_sorted"
alias gbunsorted="pretty_git_branch"
alias ghead="show_git_head"
alias zls="zellij ls"
alias zla="zellij a"
alias zda="zellij da"
alias zka="zellij ka"


# These are suffix aliases to specify what to do when a file name is put with the ending suffix
alias -s json=jless
alias -s md=bat
alias -s go='$EDITOR'
alias -s rs='$EDITOR'
alias -s txt=bat
alias -s log=bat
alias -s py='$EDITOR'
alias -s js='$EDITOR'
alias -s ts='$EDITOR'
alias ls="eza --icons=always"
alias la="eza --icons=always -a"
alias ll="eza --icons=always -l --git --header"
alias lla="eza --icons=always -la --git --header"
alias lt="eza --icons=always --tree --level=2"

compdef eza=ls

# alias cat="bat"
alias du="dust"
alias vi="nvim"
alias nv="nvim"
# alias find="fd"
# alias grep="rg"
alias nve="neovide --fork --frame none "

# MUSIC
alias play_random="rmpc clear && rmpc add / && rmpc random on && rmpc play"
alias play_random_english="rmpc clear && rmpc add english && rmpc random on && rmpc play"
alias play_random_hindi="rmpc clear && rmpc add hindi && rmpc random on && rmpc play"

# Git aliases (replacing OMZ git plugin)
alias g="git"
alias gst="git status"
alias gss="git status -s"
alias gd="git diff"
alias gco="git checkout"
alias gcob="git checkout -b"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit"
alias gcm="git commit -m"
alias gp="git push"
alias gl="git log --oneline -n 15"
alias gpsup='git push -u origin $(git symbolic-ref --short HEAD)'

# Global alias for quick pino-pretty piping
alias -g PP="| pino-pretty"
