volup="amixer -D pulse sset Master 5%+"
voldown="amixer -D pulse sset Master 5%-"
volmute="amixer -D pulse sset Master off"
volon="amixer -D pulse sset Master on"
volget="amixer -D pulse get Master"
| sed -e "s/^.*\s(\[[0-9]+%\])?\s.*$/\1/g"

