service=$BLOCK_INSTANCE
#service="sshd"

INACTIVE_COLOR=#888888
ACTIVE_COLOR=#22bb22
if [ "$(systemctl is-active "$service")" == "active" ] ; then
  echo "<span foreground=\"$ACTIVE_COLOR\">$service</span>"
else
  echo "<span foreground=\"$INACTIVE_COLOR\"><s>$service</s></span>"
fi
