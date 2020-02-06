#!/usr/bin/env bash
# shellcheck disable=2219

shopt -s extglob
declare -i timeout=0

while (( $# )); do
  case "$1" in
    *d) t=${1%d}; let timeout+=$(( ( ( t * 60 ) * 60 ) * 24 )) ;;
    *h) t=${1%h}; let timeout+=$(( ( t * 60 ) * 60 )) ;;
    *m) t=${1%m}; let timeout+=$(( t * 60 )) ;;
    (+([0-9])) let timeout+=$1 ;;
    *) exit 1 ;;
  esac
  shift
done

trap "printf '\e[2k\r'" EXIT

while [ "$timeout" -gt 0 ]; do
  printf '\e[2K  %d...\r' "$timeout"
  sleep 1 && let timeout--
done

1>&2 2>/dev/null mpg321 /usr/local/share/eggtimer/bell.mp3&
