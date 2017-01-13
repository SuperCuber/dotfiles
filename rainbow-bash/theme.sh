# Includes
source ${RBW_PATH}/powerline.sh

source ${RBW_PLUGINS}/git/init.sh

get_git_color(){
    if [[ $rbw_git_is_repo == 1 ]]; then
        if [[ $rbw_git_dirty == 1 ]]; then
            echo -en "$RBW_R_RED_ON_BLUE"
        else
            echo -en "$RBW_R_GREEN_ON_BLUE"
        fi
    else
        echo -en "$RBW_R_YELLOW_ON_BLUE"
    fi
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
        echo -en "$RBW_BR_WHITE_ON_GREEN"
    else
        echo -en "$RBW_BR_WHITE_ON_RED"
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
        echo -en "$RBW_R_GREEN_ON_CYAN"
    else
        echo -en "$RBW_R_RED_ON_CYAN"
    fi
    return $RV
}

# Exit code
# Username
# Path
# Git
# Prompt
RBW_THEME="\
\[\$(get_exit_code_color)\] \$(get_exit_code)\[\$(get_exit_code_color_2)\]\[$PL_RIGHT_SEPARATOR\]\
\[$RBW_BR_WHITE_ON_CYAN\] \u\[$RBW_R_CYAN_ON_BLACK\]\[$PL_RIGHT_SEPARATOR\]\
\[$RBW_BR_WHITE_ON_BLACK\] \w\[$RBW_RESET_ALL\]\[$RBW_R_BLACK_ON_BLUE\]\[$PL_RIGHT_SEPARATOR\]\
\[\$(get_git_color)\] \$(get_git_info)\[$RBW_R_BLUE\]\[$PL_RIGHT_SEPARATOR\]
\[$RBW_BR_WHITE_ON_YELLOW\] \$\[$RBW_R_YELLOW\]${PL_RIGHT_SEPARATOR}\[$RBW_RESET_ALL\] "

PS1=${RBW_THEME}
