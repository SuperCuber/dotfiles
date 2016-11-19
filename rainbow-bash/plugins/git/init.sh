source $RBW_PLUGINS/git/utils.sh

# Create the variables calling the functions
PROMPT_COMMAND="rbw_git_check_repo;\
rbw_git_set_branch;\
rbw_git_set_dirty;\
$PROMPT_COMMAND"