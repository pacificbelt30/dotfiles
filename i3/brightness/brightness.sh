##
# @brief Change LCD brightness
#
#        Change the brightness of the current LCD via command line.
#        You should be a root to run this script.
#
# @usage
#   ./brightness value
# 
# @param value 
#    A relative brightness. The max brightness is when value = 100.
#    If value > 100, it is regarded as value = 100. The minimum
#    brightness is set when value = 0. But this means a LCD blackout.
#    Thus, value smaller than 20 is ignored and set value = 20.
#    Non-numeric input is regarded as value = 20. 

##
usage () {
  echo "usage:" >&2
  echo "   brightness value" >&2
  echo "   value is an integer number between 20 and 100." >&2
  exit 1;
}

## No argument, then show usage and exit. 
[ -z "${@}" ] && usage

## Parse the first argument. Non-numeric input is zero.
VALUE=$(echo ${1:?} | awk '{print $1*1}')
[ ${VALUE} -gt 100 ] && VALUE=100
[ ${VALUE} -lt  20 ] && VALUE=20

PREFIX="/sys/class/backlight/intel_backlight"

MAX_V=$(cat ${PREFIX}/max_brightness)
VALUE=$(echo "${MAX_V} * ${VALUE} / 100" | bc)

echo ${VALUE} | sudo tee ${PREFIX}/brightness >/dev/null

