#!/bin/bash
args=(
  --artist="Lois McMaster Bujold, Grover Gardner"
  --album="The Flowers of Vashnoi"

  --shortest-chapter-len-millis=2885000

  --force-chapter-break-end-seconds=3755.74

  googleplay_the_flowers_of_vashnoi.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
