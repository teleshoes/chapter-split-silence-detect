#!/bin/bash
args=(
  --artist="Lois McMaster Bujold, Grover Gardner"
  --album="Winterfair Gifts"
  --custom-chapter-name="1:Winterfair Gifts"

  --shortest-chapter-len-millis=9109000

  googleplay_winterfair_gifts.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
