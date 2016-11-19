source $RBW_PLUGINS/position/utils.sh

# Create the variables calling the functions:
PROMPT_COMMAND="rbw_position_get_cursor_position; $PROMPT_COMMAND"
