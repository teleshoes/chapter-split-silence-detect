#!/bin/bash
args=(
  --artist="Lois McMaster Bujold, Grover Gardner"
  --album="Brothers in Arms"

  --shortest-chapter-len-millis=1776000

  --fake-chapter-break-end-seconds=35120.6
  --fake-chapter-break-end-seconds=35460.1

  googleplay_brothers_in_arms.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
