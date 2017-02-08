#==> Zsh options
setopt PROMPT_SUBST
autoload -U colors && colors
#<==

#==> Aliases
# Path
export PATH=$PATH:~/bin
export PATH=$PATH:~/.scripts

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
alias eb="c; exec zsh"
alias x="startx"
#<==

#==> Prompt
#;Colors
CLR_RED="110;23;8"
CLR_GREEN="27;119;55"
CLR_YELLOW="67;109;7"
CLR_BLUE="7;59;74"
CLR_CYAN="45;103;120"
CLR_WHITE="255;255;255"
CLR_BLACK="0;0;0"

# Exit
EXIT_OK="$CLR_GREEN"
EXIT_ERROR="$CLR_RED"
# User
USERNAME_COLOR="$CLR_CYAN"
# Path
PATH_COLOR="$CLR_BLACK"
# Prompt
PROMPT_COLOR="$CLR_YELLOW"
# Text
TEXT_COLOR="$CLR_WHITE"

get_exit_code(){
    RV=$?
    echo -en "$RV"
    return $RV
}

get_exit_code_color(){
    RV=$?
    if (( $RV == 0 )); then
        echo -en `to_rgb $EXIT_OK 1`
    else
        echo -en `to_rgb $EXIT_ERROR 1`
    fi
    return $RV
}

get_exit_code_color_2(){
    RV=$?
    if (( $RV == 0 )); then
        echo -en `to_rgb $EXIT_OK 0` # Green
    else
        echo -en `to_rgb $EXIT_ERROR 0` # Red
    fi
    echo -en `to_rgb $USERNAME_COLOR 1` # Cyan bg
    return $RV
}

to_rgb() {
    [ -z $2 ] && exit 1
    if (( $2 == 0 )); then
        printf "\x1b[38;2;${1}m\n"
    else
        printf "\x1b[48;2;${1}m\n"
    fi
}

RESET_COLORS=$reset_color
SEPARATOR=""


# Exit code
# Username
# Path
# Prompt
PS1="%{$(get_exit_code_color)%} %{$(get_exit_code) $(get_exit_code_color_2)%}$SEPARATOR\
%{$(to_rgb "$TEXT_COLOR" 0)$(to_rgb "$USERNAME_COLOR" 1)%} %n %{$(to_rgb "$USERNAME_COLOR" 0)$(to_rgb "$PATH_COLOR" 1)$SEPARATOR%}\
%{$(to_rgb "$TEXT_COLOR" 0)$(to_rgb "$PATH_COLOR" 1)%} %~ %{$RESET_COLORS$(to_rgb "$PATH_COLOR" 0)$SEPARATOR%}
%{$(to_rgb "$TEXT_COLOR" 0)$(to_rgb "$PROMPT_COLOR" 1)%} %(!.#.$) %{$RESET_COLORS$(to_rgb "$PROMPT_COLOR" 0)%}%{$SEPARATOR%G%}%{$RESET_COLORS%} "
#<==

#==> Misc
# Dircolors
eval `dircolors ~/.dir_colors`

# CD
cd ()
{
    # Pass all arguments to cd
    builtin cd "$@"
    # Get return value
    RV=$?
    # If its not 0, just get out, it already printed message
    [ $RV = 0 ] || return $RV
    # If everything OK, print ls and todo
    l
    todo
}

c;todo
#<==

# vim:foldmethod=marker:foldmarker=\=\=>,<\=\=:foldtext=VimrcFoldText()
