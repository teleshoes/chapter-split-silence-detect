#!/bin/bash
args=(
  --artist="Lois McMaster Bujold, Grover Gardner"
  --album="The Vor Game"

  --long-breaks-min-silence-millis=2500

  --shortest-chapter-len-millis=1713000

  --force-chapter-break-end-seconds=1817.94 #ch2
  --force-chapter-break-end-seconds=3531.65 #ch3
  --force-chapter-break-end-seconds=7191.66 #ch5
  --force-chapter-break-end-seconds=11200.1 #ch7
  --force-chapter-break-end-seconds=19930.4 #ch11
  --force-chapter-break-end-seconds=25719   #ch13
  --force-chapter-break-end-seconds=30918.4 #ch15
  --force-chapter-break-end-seconds=33540.8 #ch16

  --fake-chapter-break-end-seconds=24563.2
  --fake-chapter-break-end-seconds=30678.8
  --fake-chapter-break-end-seconds=39038.4

  googleplay_the_vor_game.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
