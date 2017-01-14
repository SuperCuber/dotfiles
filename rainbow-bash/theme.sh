# Includes
source ${RBW_PATH}/powerline.sh

source ${RBW_PLUGINS}/git/init.sh
# Colors
CLR_RED="110 23 8"
CLR_GREEN="27 119 55"
CLR_YELLOW="67 109 7"
CLR_BLUE="7 59 74"
CLR_CYAN="45 103 120"
CLR_WHITE="255 255 255"
CLR_BLACK="0 0 0"

# Git
GIT_DIRTY="$CLR_RED"
GIT_CLEAN="$CLR_GREEN"
GIT_NEUTRAL="$CLR_YELLOW"
GIT_BG="$CLR_BLUE"
# Exit
EXIT_OK="$CLR_GREEN"
EXIT_ERROR="$CLR_RED"
# User
USERNAME="$CLR_CYAN"
# Path
PATH_COLOR="$CLR_BLACK"
# Prompt
PROMPT_COLOR="$CLR_YELLOW"
# Text
TEXT_COLOR="$CLR_WHITE"

# # Text
# TEXT_COLOR="$CLR_WHITE"
# # Exit
# EXIT_OK="115 52 52"
# EXIT_ERROR="255 0 0"
# # User
# USERNAME="42 43 128"
# # Path
# PATH_COLOR="79 79 89"
# # Git
# GIT_CLEAN="255 0 0"
# GIT_DIRTY="255 0 0"
# GIT_NEUTRAL="25 50 59"
# GIT_BG="111 43 138"
# # Prompt
# PROMPT_COLOR="25 50 59"

get_git_color(){
    if [[ $rbw_git_is_repo == 1 ]]; then
        if [[ $rbw_git_dirty == 1 ]]; then
            echo -en `to_rgb $GIT_DIRTY 0`
        else
            echo -en `to_rgb $GIT_CLEAN 0`
        fi
    else
        echo -en `to_rgb $GIT_NEUTRAL 0`
    fi
    echo -en `to_rgb $GIT_BG 1`
}

get_git_info(){
    if [[ $rbw_git_is_repo == 1 ]]; then
        if [[ $rbw_git_dirty == 1 ]]; then
            echo -en " $rbw_git_branch  "
        else
            echo -en " $rbw_git_branch  "
        fi
    else
        echo -en " "
    fi
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

get_exit_code(){
    RV=$?
    echo -en "$RV"
    return $RV
}

get_exit_code_color_2(){
    RV=$?
    if (( $RV == 0 )); then
        echo -en `to_rgb $EXIT_OK 0` # Green
    else
        echo -en `to_rgb $EXIT_ERROR 0` # Red
    fi
    echo -en `to_rgb $USERNAME 1` # Cyan bg
    return $RV
}

to_rgb() {
    if (( $4 == 0 )); then
        printf "\x1b[38;2;$1;$2;${3}m\n"
    else
        printf "\x1b[48;2;$1;$2;${3}m\n"
    fi
}

# Exit code
# Username
# Path
# Git
# Prompt
RBW_THEME="\
\[\$(get_exit_code_color)\] \$(get_exit_code)\[\$(get_exit_code_color_2)\]\[$PL_RIGHT_SEPARATOR\]\
\[\$(to_rgb $TEXT_COLOR 0)\$(to_rgb $USERNAME 1)\] \u\[\$(to_rgb $USERNAME 0)\$(to_rgb $PATH_COLOR 1)\]\[$PL_RIGHT_SEPARATOR\]\
\[\$(to_rgb $TEXT_COLOR 0)\$(to_rgb $PATH_COLOR 1)\] \w\[$RBW_RESET_ALL\]\[\$(to_rgb $PATH_COLOR 0)\$(to_rgb $GIT_BG 1)\]\[$PL_RIGHT_SEPARATOR\]\
\[\$(get_git_color)\] \$(get_git_info)\[$RBW_RESET_ALL\$(to_rgb $GIT_BG 0)\]\[$PL_RIGHT_SEPARATOR\]
\[\$(to_rgb $TEXT_COLOR 0)\$(to_rgb $PROMPT_COLOR 1)\] \$\[$RBW_RESET_ALL\$(to_rgb $PROMPT_COLOR 0)\]${PL_RIGHT_SEPARATOR}\[$RBW_RESET_ALL\] "

PS1=${RBW_THEME}
