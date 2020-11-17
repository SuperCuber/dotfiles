{{#if zsh~}}
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

{{/if~}}
#==> Aliases
# ls
alias ls="ls --color=auto"
alias l="ls -FL"
alias ll="ls -Ahl"
alias la="ls -a"

# Clearing screen
alias c="echo -ne '\033c'"
alias cl="c;l"
alias cll="c;ll"

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
alias glg="git log --oneline --graph --decorate"
alias go="git checkout"
alias gpl="git pull"
alias gps="git push"
alias gs="git status -sb"

# Misc
alias e="exit"
alias eb="exec {{#if zsh}}zsh{{else}}bash{{/if}}"
alias x="exec startx"
alias vsp="vi -O"
#<==

{{#if zsh~}}
#==> ZSH Prompt
function preexec() {
  timer=$(($(date +%s%0N)/1000000))
}

function precmd() {
  if [ $timer ]; then
    now=$(($(date +%s%0N)/1000000))
    elapsed=$(($now-$timer))

    if [ $elapsed -ge 1000 ]; then
        export RPROMPT="%F{cyan}${elapsed}ms %F"
    else
        export RPROMPT=""
    fi
    unset timer
  fi
}

PS1_EXIT_CODE="%F{0}%(?.%K{15}.%K{1}) %? "
PS1_USERNAME="%F{8}%K{7} %n "
PS1_PATH="%F{7}%K{8} %(5~@.../%3~@%~) "
PS1_PROMPT="%F{15}%B%(!.%K{1} # .%K{0} $ )%f%k%b "

PS1="$PS1_EXIT_CODE$PS1_USERNAME$PS1_PATH$PS1_PROMPT"
#<==

{{else~}}
#==> Bash Prompt
PS1_EXIT_CODE='\[\033[38;5;0m\]\[\033[48;5;15m\] $? '
PS1_USERNAME='\[\033[38;5;8m\]\[\033[48;5;7m\] \u '
PS1_PATH='\[\033[38;5;7m\]\[\033[48;5;8m\] \w '
PS1_PROMPT='\[$(tput bold)\]\[\033[48;5;0m\] \\$ '
PS1="$PS1_EXIT_CODE$PS1_USERNAME$PS1_PATH$PS1_PROMPT\[$(tput sgr0)\]"
#<==

{{/if~}}
#==> Misc
# Dircolors
eval `dircolors ~/.dir_colors`

# CD
cd ()
{
    # Pass all arguments to cd
    builtin cd "$@" || return $?
    # If everything OK, print ls and todo
    l
    type todo >/dev/null 2>&1 && todo
    return 0
}

cat ()
{
    if type bat >/dev/null 2>&1; then
        bat $*
    else
        cat $*
    fi
}

j ()  # Navigate with fzf
{
    if type fzf >/dev/null 2>&1; then
        if type fd >/dev/null 2>&1; then
            find_command='fd . ~ --type d'
        else
            # Settle for not hiding gitignored stuff
            find_command='find ~ -type d'
        fi
        dir=$(eval $find_command | fzf --preview 'tree -C -L 2 {+1}')
        fzf_return=$?
        [ $fzf_return = 0 ] && cd $dir || return $fzf_return
    else
        echo fzf not installed
    fi
}

# Terminal color
TERM=xterm-256color
export PATH=$HOME/.scripts:$PATH
#<==

# vim:foldmethod=marker:foldmarker=\=\=>,<\=\=:foldtext=v\:folddashes.getline(v\:foldstart)[3\:]
