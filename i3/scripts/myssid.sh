SSID=$(iwgetid -r)
IP=$(ip -4 a show wlan0 | grep inet | awk '{print $2}' | sed "s/\/.*//g")

time=$(date "+%S")
tc=$(($time % 20))
if [[ $tc -lt 10 ]]; then
  echo $SSID
else
  echo $IP
fi
