#!/bin/bash
args=(
  --artist="Lois McMaster Bujold, Grover Gardner"
  --album="Cryoburn"

  --shortest-chapter-len-millis=1447000 #except: ch21

  googleplay_cryoburn.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
