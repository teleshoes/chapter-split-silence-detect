#!/bin/bash
args=(
  --artist="Lois McMaster Bujold, Grover Gardner"
  --album="Barrayar"
  --custom-chapter-name="21:Epilogue"
  --shortest-chapter-len-millis=1596000
  googleplay_barrayar.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
