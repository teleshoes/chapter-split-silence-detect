#!/bin/bash
args=(
  --artist="Lois McMaster Bujold, Grover Gardner"
  --album="Komarr"

  --shortest-chapter-len-millis=1431000 #except: ch9

  --force-chapter-break-end-seconds=19063.4 #ch10
  --force-chapter-break-end-seconds=27892.1 #ch14

  googleplay_komarr.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
