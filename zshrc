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
alias gca="git c -a"
alias gcm="git c -m"
alias gcam="git c -am"
alias gps="g ps"
alias gpl="g pl"
alias glg="g lg"

# Misc
alias e="exit"
alias eb="exec {{#if zsh}}zsh{{else}}bash{{/if}}"
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

j ()
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

# Navigate with fzf

# Terminal color
TERM=xterm-256color
export PATH=$HOME/.scripts:$PATH
#<==

# vim:foldmethod=marker:foldmarker=\=\=>,<\=\=:foldtext=v\:folddashes.getline(v\:foldstart)[3\:]
