# Output
OUTPUT=${RBW_PATH}/export_colors.sh

# Bolds
RBW_BOLD=01
RBW_NOTBOLD=0

# Resets
RBW_RESET_ALL="\e[00m"

# Simple Colors
RBW_BLACK=0 # Black
RBW_RED=1 # Red
RBW_GREEN=2 # Green
RBW_YELLOW=3 # Yellow
RBW_BLUE=4 # Blue
RBW_MAGENTA=5 # Magenta
RBW_CYAN=6 # Cyan
RBW_WHITE=7 # White

RBW_BASIC_COLORS=('RBW_BLACK' 'RBW_RED' 'RBW_GREEN' 'RBW_YELLOW' 'RBW_BLUE' 'RBW_MAGENTA' 'RBW_CYAN' 'RBW_WHITE')

#formats
REGULAR_FMT_VALUE="\\\e[$RBW_NOTBOLD;3%um"
REGULAR_FMT_VARIABLE="RBW_R_%s"

LIGHT_FMT_VALUE="\\\e[$RBW_NOTBOLD;9%um"
LIGHT_FMT_VARIABLE="RBW_L_%s"

BOLD_FMT_VALUE="\\\e[$RBW_BOLD;3%um"
BOLD_FMT_VARIABLE="RBW_BR_%s"

BOLD_LIGHT_FMT_VALUE="\\\e[$RBW_BOLD;9%um"
BOLD_LIGHT_FMT_VARIABLE="RBW_BL_%s"

BACK_REGULAR_FMT_VALUE="\\\e[$RBW_NOTBOLD;3%u;4%um"
BACK_REGULAR_FMT_VARIABLE="RBW_R_%s_ON_%s"

BACK_LIGHT_FMT_VALUE="\\\e[$RBW_NOTBOLD;9%u;4%um"
BACK_LIGHT_FMT_VARIABLE="RBW_L_%s_ON_%s"

BACK_BOLD_REGULAR_FMT_VALUE="\\\e[$RBW_BOLD;3%u;4%um"
BACK_BOLD_REGULAR_FMT_VARIABLE="RBW_BR_%s_ON_%s"

BACK_BOLD_LIGHT_FMT_VALUE="\\\e[$RBW_BOLD;9%u;4%um"
BACK_BOLD_LIGHT_FMT_VARIABLE="RBW_BL_%s_ON_%s"

# Gets OTHER_SOMETHING and returns SOMETHING
get_color_name(){
    IFS='_'
    read -ra color <<< "$1"
    echo ${color[-1]}
}

save_color(){
    echo "$1" >> ${OUTPUT}
}

create_color(){
    local variable_format value_format value_format variable_name value
    variable_format=$1
    value_format=$2
    value=$3

    variable_name=$(printf $variable_format `get_color_name $value` )
    variable_value=$(printf $value_format ${!value})
    save_color "export ${variable_name}=\"${variable_value}\""
}

create_background_color(){
    local variable_format value_format value_format variable_name value
    variable_format=$1
    value_format=$2
    foreground=$3
    background=$4

    variable_name=$(printf $variable_format `get_color_name $foreground` `get_color_name $background`)
    variable_value=$(printf $value_format ${!foreground} ${!background})
    #export "${variable_name}"="${variable_value}"
    save_color "export ${variable_name}=\"${variable_value}\""
}

create_colors(){
    rm -f ${OUTPUT}
    for i in ${RBW_BASIC_COLORS[@]}
    do
        # Dynamic variable color creation

        # Regular color: RBW_R_*
        create_color $REGULAR_FMT_VARIABLE $REGULAR_FMT_VALUE $i

        # Light color: RBW_L_*
        create_color $LIGHT_FMT_VARIABLE $LIGHT_FMT_VALUE $i

        # Bold Regular color: RBW_BR_*
        create_color $BOLD_FMT_VARIABLE $BOLD_FMT_VALUE $i

        # Bold light color: RBW_BL_*
        create_color $BOLD_LIGHT_FMT_VARIABLE $BOLD_LIGHT_FMT_VALUE $i

        # Create background color combinations
        for j in ${RBW_BASIC_COLORS[@]}
        do
            # Background regular color : RBW_R_*_ON_*
            create_background_color $BACK_REGULAR_FMT_VARIABLE $BACK_REGULAR_FMT_VALUE $j $i

            # Background light color : RBW_L_*_ON_*
            create_background_color $BACK_LIGHT_FMT_VARIABLE $BACK_LIGHT_FMT_VALUE $j $i

            # Background regular bold color : RBW_BR_*_ON_*
            create_background_color $BACK_BOLD_REGULAR_FMT_VARIABLE $BACK_BOLD_REGULAR_FMT_VALUE $j $i

            # Background light bold color : RBW_BL_*_ON_*
            create_background_color $BACK_BOLD_LIGHT_FMT_VARIABLE $BACK_BOLD_LIGHT_FMT_VALUE $j $i
        done

    done
}


rbw_test_colors(){
    RBW_VAR_FORMATS=(REGULAR_FMT_VARIABLE LIGHT_FMT_VARIABLE BOLD_FMT_VARIABLE
                     BOLD_LIGHT_FMT_VARIABLE BACK_REGULAR_FMT_VARIABLE BACK_LIGHT_FMT_VARIABLE
                     BACK_BOLD_REGULAR_FMT_VARIABLE BACK_BOLD_LIGHT_FMT_VARIABLE)
    for fmt in ${RBW_VAR_FORMATS[@]}
    do
        echo
        echo ==$fmt==
        local color bash_color

        for i in ${RBW_BASIC_COLORS[@]}
        do
            # Background colors ned doble loop
            if [[ $fmt == *BACK* ]]; then
                for j in ${RBW_BASIC_COLORS[@]}
                do
                    fg_color=`get_color_name $i`
                    bg_color=`get_color_name $j`
                    bash_color=$(printf ${!fmt} $fg_color $bg_color)
                    echo -en "${!bash_color}$bash_color "
                done
            else
                color=`get_color_name $i`
                bash_color=$(printf ${!fmt} $color)
                echo -en "${!bash_color}$bash_color "
            fi
        done
        echo -en $RBW_RESET_ALL
    done
    echo -en $RBW_RESET_ALL
}

export_colors(){
    # Create file of colors if doesn't exists
    if [ ! -f ${OUTPUT} ]; then
        create_colors
    fi
    source ${OUTPUT}
}


export_colors
