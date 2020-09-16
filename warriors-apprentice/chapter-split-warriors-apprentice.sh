#!/bin/bash
args=(
  --artist="Lois McMaster Bujold, Grover Gardner"
  --album="The Warrior's Apprentice"
  --custom-chapter-name="22:Epilogue"

  --long-breaks-min-silence-millis=2675

  --shortest-chapter-len-millis=1515000 #except: ch4 ch12 ch17 ch20 ch22

  --force-chapter-break-end-seconds=6362.85 #ch5
  --force-chapter-break-end-seconds=14614.7 #ch9
  --force-chapter-break-end-seconds=22161.8 #ch13
  --force-chapter-break-end-seconds=32655   #ch18
  --force-chapter-break-end-seconds=37233.6 #ch21

  --fake-chapter-break-end-seconds=22499
  --fake-chapter-break-end-seconds=23412.9

  googleplay_warriors_apprentice.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
