#!/bin/bash
args=(
  --artist="Lois McMaster Bujold, Grover Gardner"
  --album="Ethan of Athos"

  --shortest-chapter-len-millis=1354000

  googleplay_ethan_of_athos.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
