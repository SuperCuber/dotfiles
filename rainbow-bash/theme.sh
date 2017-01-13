# Includes
source ${RBW_PATH}/powerline.sh

source ${RBW_PLUGINS}/git/init.sh

CLR_RED="110 23 8"
CLR_GREEN="27 119 55"
CLR_YELLOW="67 109 7 "
CLR_BLUE="7 59 74 "
CLR_CYAN="45 103 120"
CLR_WHITE="255 255 255"
CLR_BLACK="0 0 0"

get_git_color(){
    if [[ $rbw_git_is_repo == 1 ]]; then
        if [[ $rbw_git_dirty == 1 ]]; then
            echo -en `to_rgb $CLR_RED 0`
        else
            echo -en `to_rgb $CLR_GREEN 0`
        fi
    else
        echo -en `to_rgb $CLR_YELLOW 0`
    fi
    echo -en `to_rgb $CLR_BLUE 1`
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
        echo -en `to_rgb $CLR_GREEN 1`
    else
        echo -en `to_rgb $CLR_RED 1`
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
        echo -en `to_rgb $CLR_GREEN 0` # Green
    else
        echo -en `to_rgb $CLR_RED 0` # Red
    fi
    echo -en `to_rgb $CLR_CYAN 1` # Cyan bg
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
            echo -en `to_rgb 7 59 74 1` # Blue bg
RBW_THEME="\
\[\$(get_exit_code_color)\] \$(get_exit_code)\[\$(get_exit_code_color_2)\]\[$PL_RIGHT_SEPARATOR\]\
\[\$(to_rgb $CLR_WHITE 0)\$(to_rgb $CLR_CYAN 1)\] \u\[\$(to_rgb $CLR_CYAN 0)\$(to_rgb $CLR_BLACK 1)\]\[$PL_RIGHT_SEPARATOR\]\
\[\$(to_rgb $CLR_WHITE 0)\$(to_rgb $CLR_BLACK 1)\] \w\[$RBW_RESET_ALL\]\[\$(to_rgb $CLR_BLACK 0)\$(to_rgb $CLR_BLUE 1)\]\[$PL_RIGHT_SEPARATOR\]\
\[\$(get_git_color)\] \$(get_git_info)\[$RBW_RESET_ALL\$(to_rgb $CLR_BLUE 0)\]\[$PL_RIGHT_SEPARATOR\]
\[\$(to_rgb $CLR_WHITE 0)\$(to_rgb $CLR_YELLOW 1)\] \$\[$RBW_RESET_ALL\$(to_rgb $CLR_YELLOW 0)\]${PL_RIGHT_SEPARATOR}\[$RBW_RESET_ALL\] "

PS1=${RBW_THEME}
