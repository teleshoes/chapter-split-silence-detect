#!/bin/bash
args=(
  --artist="Lois McMaster Bujold, Grover Gardner"
  --album="Gentleman Jole and the Red Queen"
  --custom-chapter-name="18:Epilogue"

  --shortest-chapter-len-millis=2224000 #except: ch16 ch17 ch18

  --force-chapter-break-end-seconds=42701.5 #ch17
  --force-chapter-break-end-seconds=44526.9 #ch18

  googleplay_gentleman_jole_and_the_red_queen.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
