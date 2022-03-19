# battery remaining
acpi_info=$(acpi -b | grep "Battery 0")
status=$(echo $acpi_info | awk '{print $3}' | tr -d ",")
remain_per=$(echo $acpi_info | awk '{print $4}' | tr -d "," | tr -d "%")
remain_time=$(echo $acpi_info | awk '{print $5}' | tr -d "," | sed -r "s/:[0-9]+$//g")
#echo $status $remain_time $remain_per
up=" "
down=" "
#low_color="#e06c75"
low_color="#ee3333"
high_color="#333333"
if [[ $status = "Charging" ]]; then
  #echo $remain_per $up \($remain_time\)
  if [[ $remain_per -eq 100 ]]; then
    echo "<span foreground=\"$high_color\">$remain_per% $up FULL</span>"
  else
    echo "<span foreground=\"$high_color\">$remain_per% $up ($remain_time)</span>"
  fi
elif [[ $status = "Full" ]]; then
    echo "<span foreground=\"$high_color\">$remain_per% $up FULL</span>"
else
  #echo $remain_per $down \($remain_time\)
  if [[ $remain_per -gt 30 ]]; then
    echo "<span foreground=\"$high_color\">$remain_per% $down ($remain_time)</span>"
  else
    echo "<span foreground=\"$low_color\">$remain_per% $down ($remain_time)</span>"
  fi
fi


