#!/usr/bin/env bash
# shellcheck disable=2219

shopt -s extglob

declare -i timeout=0
declare msg=""

while (( $# )); do
  case "$1" in
    (+([0-9])*d) t=${1%d}; let timeout+=$(( ( ( t * 60 ) * 60 ) * 24 )) ;;
    (+([0-9])*h) t=${1%h}; let timeout+=$(( ( t * 60 ) * 60 )) ;;
    (+([0-9])*m) t=${1%m}; let timeout+=$(( t * 60 )) ;;
    (+([0-9])*s) t=${1%s}; let timeout+=$t ;;
    (+([0-9])) let timeout+=$1 ;;
    *) msg="$1" ;;
  esac
  shift
done

trap "printf '\e[2k\r'" EXIT

while [ "$timeout" -gt 0 ]; do
  printf '\e[2K\r%d...' "$timeout"
  sleep 1 && let timeout--
done

if [ "$msg" != "" ]; then
  printf '\e[2K\r%s\n' "$msg"
fi

1>&2 2>/dev/null mpg321 /usr/local/share/et/bell.mp3&
