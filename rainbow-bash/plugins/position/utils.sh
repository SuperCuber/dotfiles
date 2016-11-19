rbw_position_get_cursor_position(){
    # based on a script from http://invisible-island.net/xterm/xterm.faq.html
    exec < /dev/tty
    oldstty=$(stty -g)
    stty raw -echo min 0
    # on my system, the following line can be replaced by the line below it
    echo -en "\033[6n" > /dev/tty
    # tput u7 > /dev/tty    # when TERM=xterm (and relatives)
    IFS=';' read -r -d R -a pos
    stty $oldstty
    # change from one-based to zero based so they work with: tput cup $row $col
    rbw_position_row=$((${pos[0]:2} - 1))    # strip off the esc-[
    rbw_position_col=$((${pos[1]} - 1))
}

rbw_position_write_end_of_line(){
    local end_of_line fixed_str
    rbw_position_get_cursor_position

    # delete scape characters for count
    fixed_str=$(echo -en $1 | sed 's/\[[0-9\;]*m//g')

    end_of_line=$((`tput cols`-${#fixed_str}))
    tput sc                   #Save the cursor position&attributes
    tput cup $rbw_position_row $end_of_line
    echo -en $1
    tput rc
}