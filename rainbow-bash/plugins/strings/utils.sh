
rbw_strings_fill_line_with_char(){
    tput sc
    columns=$(tput cols)
    printf '%0.1s' "$1"$(eval echo {1..$columns});
    tput rc
}