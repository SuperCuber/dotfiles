
rbw_get_battery_info(){
    battery_info=$(upower -i `upower  -e | grep BAT`)
}

rbw_battery_set_charging(){
  local result
  result=$(echo "$battery_info" | grep state |  awk '{print $2}')
  if [[ "$result" == "charging" ]]; then
    rbw_battery_charging=1
  elif [[ "$result" == "fully-charged" ]]; then
    rbw_battery_full=1
  else
    rbw_battery_charging=0
  fi
}

rbw_battery_set_percent(){
  rbw_battery_percent=$(echo "$battery_info" | grep percentage| awk '{print $2}' | sed s/%//)
}
