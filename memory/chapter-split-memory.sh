#!/bin/bash
args=(
  --artist="Lois McMaster Bujold, Grover Gardner"
  --album="Memory"

  --long-breaks-min-silence-millis=2190

  --shortest-chapter-len-millis=1323000 #except: ch18

  --force-chapter-break-end-seconds=30029.3 #ch19

  --fake-chapter-break-end-seconds=24653.7
  --fake-chapter-break-end-seconds=27066.9
  --fake-chapter-break-end-seconds=37582.4
  --fake-chapter-break-end-seconds=52049.3

  googleplay_memory.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
