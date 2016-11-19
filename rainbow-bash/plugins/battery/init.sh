source $RBW_PLUGINS/battery/utils.sh

# Create the variables calling the functions
PROMPT_COMMAND="rbw_get_battery_info;\
rbw_battery_set_charging;\
rbw_battery_set_percent;\
$PROMPT_COMMAND"
