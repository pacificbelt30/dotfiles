set -euCo pipefail

function main() {
  local -Ar menu=(
    # ['Lock']='dm-tool lock'
    ['Logout']='i3-msg exit'
    ['Poweroff']='systemctl poweroff'
    ['Reboot']='systemctl reboot'
    ['Suspend']='systemctl suspend'
  )

  local -Ar menu_icon=(
    ['Logout']='\0icon\x1fxfsm-logout\n'
    ['Poweroff']='\0icon\x1fsystem-shutdown\n'
    ['Reboot']='\0icon\x1fsystem-reboot\n'
    ['Suspend']='\0icon\x1fsystem-suspend\n'
  )

  local -r IFS=$'\n'
  if [[ $# -ne 0 ]]; then
    eval "${menu[$1]}"
  else
    for key in ${!menu[@]}; do
      echo -ne "$key${menu_icon[$key]}"
    done
  fi

}

main $@

