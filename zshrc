{{#if dotter.packages.zsh}}
#==> Zsh options
# Prompt
setopt PROMPT_SUBST
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=0
autoload -Uz compinit
compinit

# History
HISTFILE=~/.zsh_history
HISTSIZE=1000000000
SAVEHIST=1000000000
setopt INC_APPEND_HISTORY_TIME EXTENDED_HISTORY HIST_IGNORE_DUPS
#<==

{{/if}}
#==> Aliases
# ls
{{#if (is_executable "eza")}}
alias l="eza --time-style long-iso --color=auto -F"
alias ll="l -ahl"
{{else}}
alias l="ls --color=auto -F"
alias ll="l -Ahl"
{{/if}}
alias la="l -a"

# Clearing screen
alias c="echo -ne '\033c';"
alias cl="c l"
alias cll="c ll"

# Navigation
alias b="cd - >/dev/null && l" # b stands for back

# Interactive commands
alias mv="mv -i"  # "m" - never forget
alias cp="cp -i"

# Move up quickly
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .5="cd ../../../.."
alias .6="cd ../../../../.."
alias .7="cd ../../../../../.."
alias .8="cd ../../../../../../.."

# Package management
alias install='{{ install }}'
alias uninstall='{{ uninstall }}'
alias update='{{ update }}'
alias autoremove='{{ autoremove }}'

# Git
alias ga="git add"
alias gb="git branch"
alias gca="git commit -a"
alias gcam="git commit -am"
alias gc="git commit"
alias gcm="git commit -m"
alias gd="git diff"
alias gds="git diff --staged"
alias glg="git log --all --oneline --graph --decorate"
alias gpl="git pull --prune"
alias gps="git push"
alias gm="git merge"
alias gs="git status -sb"
alias gs-="git switch -"

function gsb() {
    query_and_branch=$(git branch | tr -d ' *' | fzf --print-query)
    fzf_exit=$?
    branch=$(tail -1 <<<"$query_and_branch")
    if (( fzf_exit == 0 )); then
        git switch $branch
    elif (( fzf_exit == 1)); then
        git switch -c $branch
    fi
    return $?
}

# Misc
alias e="exit"
alias eb="exec {{#if dotter.packages.zsh}}zsh{{else}}bash{{/if}}"
alias vsp="vi -O"
alias pv="pv -pterb"
#<==

# Prompt git integration
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM=verbose
. ~/.git_prompt

{{#if dotter.packages.zsh}}
#==> ZSH Prompt
function displaytime {
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  (( $D > 0 )) && printf '%d days ' $D
  (( $H > 0 )) && printf '%d hours ' $H
  (( $M > 0 )) && printf '%d minutes ' $M
  (( $D > 0 || $H > 0 || $M > 0 )) && printf 'and '
  printf '%d seconds\n' $S
}

function preexec() {
  timer=$(($(date +%s%0N)/1000000000))
}

PS1_EXIT_CODE="%F{0}%(?.%K{15}.%K{1}) %? "
PS1_USERNAME="%F{8}%K{ {{user_color}}} %n@%m "
PS1_PATH="%F{7}%K{8} %(5~@.../%3~@%~) "
PS1_PROMPT="%F{15}%B%(!.%K{1} # .%K{0} $ )%f%k%b "

PS1_PRE="$PS1_EXIT_CODE$PS1_USERNAME$PS1_PATH"
PS1_GIT="%%K{5} %s "
PS1_POST="$PS1_PROMPT"

function precmd() {
  if [ $timer ]; then
    now=$(($(date +%s%0N)/1000000000))
    elapsed=$(($now-$timer))
    elapsed_human=$(displaytime $elapsed)

    if [ $elapsed -ge 1 ]; then
        export RPROMPT="%F{cyan}${elapsed_human} %F"
    else
        export RPROMPT=""
    fi
    unset timer
  fi
  # Git Prompt
  __git_ps1 "$PS1_PRE" "$PS1_POST" "$PS1_GIT"
}
#<==

{{else}}
#==> Bash Prompt
PS1_EXIT_CODE='\[\033[38;5;0m\]\[\033[48;5;15m\] $? '
PS1_USERNAME='\[\033[38;5;8m\]\[\033[48;5;7m\] \u@\h '
PS1_PATH='\[\033[38;5;7m\]\[\033[48;5;8m\] \w '

PS1_PRE="$PS1_EXIT_CODE$PS1_USERNAME$PS1_PATH"
PS1_GIT='\[\033[48;5;5m\] %s '
PS1_POST='\[$(tput bold)\]\[\033[48;5;0m\] \\$ \[$(tput sgr0)\]'

PROMPT_COMMAND="__git_ps1 '$PS1_PRE' '$PS1_POST' '$PS1_GIT'"
#<==

{{/if}}
#==> Misc
# Dircolors
eval `{{#if (is_executable "gdircolors")}}gdircolors{{else}}dircolors{{/if}} ~/.dir_colors`

# CD
{{#if (is_executable "zoxide")}}
eval "$(zoxide init {{#if dotter.packages.zsh}}zsh{{else}}bash{{/if}})"
{{/if}}
cd ()
{
    # Pass all arguments to cd
    {{#if (is_executable "zoxide")}}z{{else}}builtin cd{{/if}} "$@" || return $?
    l
}

{{#if (is_executable "bat")}}
alias cat="bat"

{{/if}}
{{#if (is_executable "fzf")}}
j ()  # Navigate with fzf
{
    {{#if (is_executable fd)}}
    find_command='fd . ~ --type d'
    {{else}}
    # Settle for not hiding gitignored stuff
    find_command='find ~ -type d'
    {{/if}}
    dir=$(eval $find_command | fzf --preview 'tree -CF -L 2 {+1}')
    fzf_return=$?
    [ $fzf_return = 0 ] && cd $dir || return $fzf_return
}

{{/if}}
{{#if (is_executable "thefuck")}}
eval $(thefuck --alias)

{{/if}}
# Terminal color
TERM=xterm-256color
export PATH=$HOME/.scripts:$PATH

{{#if (is_executable "atuin")}}
export ATUIN_NOBIND="true"
eval "$(atuin init {{#if dotter.packages.zsh}}zsh{{else}}bash{{/if}})"
bindkey '^r' _atuin_search_widget

{{/if}}
#<==

# Local zshrc
[ -f ~/.zshrc.local ] && . ~/.zshrc.local

# vim:foldmethod=marker:foldmarker=\=\=>,<\=\=:foldtext=v\:folddashes.getline(v\:foldstart)[3\:]
