{{#if zsh~}}
#==> Zsh options
setopt PROMPT_SUBST
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=0
autoload -Uz compinit
compinit
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
alias g="git"
alias gs="git s"
alias gd="git d"
alias gds="git ds"
alias ga="git a"
alias gc="git c"

# Misc
alias e="exit"
alias eb="exec zsh"
alias x="exec startx"
alias vsp="vi -O"
#<==

{{#if zsh~}}
#==> ZSH Prompt
PS1_EXIT_CODE="%F{0}%(?.%K{15}.%K{1}) %? "
PS1_USERNAME="%F{8}%K{7} %n "
PS1_PATH="%F{7}%K{8} %(5~@.../%3~@%~) "
PS1_PROMPT="%F{15}%B%(!.%K{1} # .%K{0} $ )%f%k%b "

PS1="$PS1_EXIT_CODE$PS1_USERNAME$PS1_PATH$PS1_PROMPT"
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
    type todo >/dev/null && todo
    return 0
}

cat ()
{
    if type bat >/dev/null; then
        bat $*
    else
        cat $*
    fi
}

# Terminal color
TERM=xterm-256color
export PATH=$HOME/.scripts:$PATH
#<==

# vim:foldmethod=marker:foldmarker=\=\=>,<\=\=:foldtext=v\:folddashes.getline(v\:foldstart)[3\:]
