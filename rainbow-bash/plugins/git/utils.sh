rbw_git_unpushed_commits(){
  if [[ $rbw_git_is_repo == 1 ]]; then
    echo -en `git log @{u}.. --oneline |wc -l`
  fi
}

rbw_git_check_repo(){
  local result
  result=`git rev-parse --is-inside-work-tree 2>/dev/null`
  if [[ "$result" == "true" ]]; then
    rbw_git_is_repo=1
  else
    rbw_git_is_repo=0
  fi
}

rbw_git_set_branch(){
  local result
  if [[ $rbw_git_is_repo == 1 ]]; then
    result=`git symbolic-ref --short -q HEAD`
    if [[ "$result" == "" ]]; then
      rbw_git_branch="DETACHED"
    else
      rbw_git_branch=$result
    fi
  fi
}

rbw_git_set_dirty(){
  local result
  if [[ $rbw_git_is_repo == 1 ]]; then
    result=`git status --porcelain 2>/dev/null`
    if [[ "$result" == "" ]]; then
      rbw_git_dirty=0
    else
      rbw_git_dirty=1
    fi
  fi
}