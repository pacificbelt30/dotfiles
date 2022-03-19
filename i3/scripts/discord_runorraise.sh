#discord run or raise
#reference
#http://malkalech.com/i3_wm_4_run_or_raise
#https://github.com/i3/i3/issues/1809#issuecomment-135656078

#[ "$(i3-msg '[class=firefox] focus')" != "[{\"success\":true\}]" ] || i3-msg exec firefox
i3-msg "[class=$1] focus" || i3-msg exec $1
