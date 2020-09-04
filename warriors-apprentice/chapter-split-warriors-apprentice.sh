#!/bin/bash
args=(
  --artist="Lois McMaster Bujold, Grover Gardner"
  --album="The Warrior's Apprentice"
  --shortest-chapter-len-millis=976000
  --custom-chapter-name="22:Epilogue"

  --force-chapter-break-end-seconds=14614.7
  --force-chapter-break-end-seconds=19202.6
  --force-chapter-break-end-seconds=20918
  --force-chapter-break-end-seconds=22161.8
  --force-chapter-break-end-seconds=24269.1
  --force-chapter-break-end-seconds=32655
  --force-chapter-break-end-seconds=34419.4
  --force-chapter-break-end-seconds=37233.6

  --fake-chapter-break-end-seconds=7429.02
  --fake-chapter-break-end-seconds=22499
  --fake-chapter-break-end-seconds=38178
  googleplay_warriors_apprentice.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
