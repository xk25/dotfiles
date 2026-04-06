#!/bin/sh
case "$1" in
1)
  awww query | rg -oe '.*image: (.*)' -r '$1' | tail -1
  ;;
2)
  awww query | rg -oe '.*image: (.*)' -r '$1' | head -1
  ;;
*)
  exit 1
  ;;
esac
