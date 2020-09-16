#!/bin/bash
args=(
  --artist="Lois McMaster Bujold, Grover Gardner"
  --album="Barrayar"
  --custom-chapter-name="21:Epilogue"

  --shortest-chapter-len-millis=1595000 #except: ch21

  --fake-chapter-break-end-seconds=13056.1
  --fake-chapter-break-end-seconds=29988.5

  googleplay_barrayar.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
