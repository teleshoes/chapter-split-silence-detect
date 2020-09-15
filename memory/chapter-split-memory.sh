#!/bin/bash
args=(
  --artist="Lois McMaster Bujold, Grover Gardner"
  --album="Memory"

  --shortest-chapter-len-millis=1284000

  --force-chapter-break-end-seconds=1324.3 #ch2
  --force-chapter-break-end-seconds=8927.51 #ch6
  --force-chapter-break-end-seconds=15213.9 #ch10
  --force-chapter-break-end-seconds=27189.9 #ch17
  --force-chapter-break-end-seconds=30029.3 #ch19
  --force-chapter-break-end-seconds=34203.3 #ch21

  googleplay_memory.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
