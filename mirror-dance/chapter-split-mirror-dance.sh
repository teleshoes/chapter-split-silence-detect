#!/bin/bash
args=(
  --artist="Lois McMaster Bujold, Grover Gardner"
  --album="Mirror Dance"

  --shortest-chapter-len-millis=1422000

  #some chapters shorter than 'shortest'
  --force-chapter-break-end-seconds=52337.9 #ch25
  --force-chapter-break-end-seconds=53519.4 #ch26
  --force-chapter-break-end-seconds=53673.9 #ch27
  --force-chapter-break-end-seconds=64098.2 #ch33

  googleplay_mirror_dance.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
