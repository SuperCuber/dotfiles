#==> Zsh options
setopt PROMPT_SUBST
autoload -U colors && colors
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

translate_color(){
    echo "print(';'.join(str(int(part, 16)) for part in ('$1'[1:3], '$1'[3:5], '$1'[5:])))" | python
}

# Colors
CLR_RED=`translate_color "{{ color_red }}"`
CLR_GREEN=`translate_color "{{ color_green }}"`
CLR_YELLOW=`translate_color "{{ color_yellow }}"`
CLR_BLUE=`translate_color "{{ color_blue }}"`
CLR_CYAN=`translate_color "{{ color_cyan }}"`
CLR_WHITE=`translate_color "{{ color_foreground }}"`
CLR_BLACK=`translate_color "{{ color_black }}"`

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
PS1="%{\$(get_exit_code_color)%} %{\$(get_exit_code) \$(get_exit_code_color_2)%}$SEPARATOR\
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

# Terminal color
TERM=xterm-256color

c
#<==

# vim:foldmethod=marker:foldmarker=\=\=>,<\=\=:foldtext=VimrcFoldText()
