#==> Zsh options
setopt PROMPT_SUBST
#<==

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
alias ccd="c;cd"

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

# Shortcuts for installing
alias install='pacaur -S'
alias uninstall='pacaur -Rns'
alias update='pacaur -Syu'
alias autoremove='sudo pacman -Rns $(pacman -Qdtq)'

# Misc
alias e="exit"
alias eb="exec zsh"
alias x="exec startx"
alias vsp="vi -O"
#<==

#==> Prompt
# Exit code
# Username
# Path
# Prompt
PS1="%F{8}%(?.%K{2}.%K{1}) %? \
%F{0}%K{7} %n \
%F{7}%K{8} %~ \
%F{15}%(!.%K{1} # .$ )%f%k "
#<==

#==> Misc
# Dircolors
eval `dircolors ~/.dir_colors`

# CD
cd ()
{
    # Pass all arguments to cd
    builtin cd "$@" || return $RV
    # If everything OK, print ls and todo
    l
    todo
}

# Terminal color
TERM=xterm-256color
#<==

# vim:foldmethod=marker:foldmarker=\=\=>,<\=\=:foldtext=VimrcFoldText()
