#!/bin/bash
args=(
  --artist="Lois McMaster Bujold, Grover Gardner"
  --album="Cetaganda"

  --shortest-chapter-len-millis=1744000

  googleplay_cetaganda.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
