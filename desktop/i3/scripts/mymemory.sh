# メモリ情報出力
# freeコマンドの見方
# https://milestone-of-se.nesuke.com/sv-basic/linux-basic/free-command/
# catの出力を変数に代入すると改行が消える
# https://orebibou.com/ja/home/201411/20141114_001/
# KB表記
# total:全メモリ容量
# free:一切利用されていないメモリ容量
# available:解放可能領域+free 実質的な空き容量
# used:total-available or total-free
meminfo=$(cat /proc/meminfo)
total=$(echo "$meminfo" | grep MemTotal | awk '{print $2}')
free=$(echo "$meminfo" | grep MemFree | awk '{print $2}')
ava=$(echo "$meminfo" | grep MemAvailable | awk '{print $2}')
used=$(($total-$ava))
#echo $used
per=$(($used*100/$total))
used_GB=$(echo "scale=1; $used/(1024.0*1024.0)" | bc)
total_GB=$(echo "scale=1; $total/(1024.0*1024.0)" | bc)
#echo $per \%
echo $used_GB"G"\/$total_GB"G" \($per\%\)
