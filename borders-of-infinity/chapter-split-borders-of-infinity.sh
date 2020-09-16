#!/bin/bash
args=(
  --artist="Lois McMaster Bujold, Grover Gardner"
  --album="Borders of Infinity"
  --custom-chapter-name="1:One"
  --custom-chapter-name="2:The Mountains of Mourning part1"
  --custom-chapter-name="3:The Mountains of Mourning part2"
  --custom-chapter-name="4:The Mountains of Mourning part3"
  --custom-chapter-name="5:Two"
  --custom-chapter-name="6:Labyrinth part1"
  --custom-chapter-name="7:Labyrinth part2"
  --custom-chapter-name="8:Labyrinth part3"
  --custom-chapter-name="9:Three"
  --custom-chapter-name="10:Borders of Infinity part1"
  --custom-chapter-name="11:Borders of Infinity part2"
  --custom-chapter-name="12:Borders of Infinity part3"
  --custom-chapter-name="13:Four"

  --shortest-chapter-len-millis=3266000 #except: ch1 ch5 ch9 ch13

  --force-chapter-break-end-seconds=704.76  #ch2
  --force-chapter-break-end-seconds=4117.11 #ch3
# --force-chapter-break-end-seconds=7661.75 #ch4
# --force-chapter-break-end-seconds=11009.5 #ch5
  --force-chapter-break-end-seconds=11192.7 #ch6
  --force-chapter-break-end-seconds=15199.3 #ch7
  --force-chapter-break-end-seconds=19332.7 #ch8
# --force-chapter-break-end-seconds=23598.3 #ch9
  --force-chapter-break-end-seconds=23681   #ch10
# --force-chapter-break-end-seconds=27189.5 #ch11
  --force-chapter-break-end-seconds=30456.4 #ch12
# --force-chapter-break-end-seconds=33978.7 #ch13

  #these are all 3+ seconds, and some of the nearby actual breaks are < 2s...
  --fake-chapter-break-end-seconds=4321.76
  --fake-chapter-break-end-seconds=14460
  --fake-chapter-break-end-seconds=18610.3
  --fake-chapter-break-end-seconds=22778.3
  --fake-chapter-break-end-seconds=23288.7
  --fake-chapter-break-end-seconds=31252.7

  googleplay_borders_of_infinity.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
