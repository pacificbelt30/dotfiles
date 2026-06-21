# top batch mode
# CPU usage appears to be fucking high when run as an i3blocks process.
#idle=$(vmstat | awk 'NR==3{print $15}')
idle=$(top -b -n1 | awk 'NR==3{printf("%d",$8)}')
#echo $(top -b -n1 )
used=$((100-$idle))
temp=$(cat /sys/class/thermal/thermal_zone0/temp)
temp_c=$(echo "scale=1; $temp/(1000.0)" | bc | tr -d "\n")
#echo $used\% $temp_c℃
echo $used\% 🌡$temp_c℃
#echo あいうえお
