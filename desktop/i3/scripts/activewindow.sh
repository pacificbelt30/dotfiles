# print Window title and description
limit=100
window_id=`xprop -root _NET_ACTIVE_WINDOW | awk '{print $5}'`
#window_id='0x2c0002c'
window_name=`xprop -id ${window_id} WM_CLASS | awk '{print $4}' | tr -d '\"'`
window_icon_name=`xprop -id ${window_id} WM_NAME | sed -e 's/WM_NAME.*= *\"*//g' | tr -d '\"'`

echo $window_name $window_icon_name | colrm $limit

