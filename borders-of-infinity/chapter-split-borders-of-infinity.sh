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

  #skip automatic long-break detection and force all chapters
  --long-breaks-min-silence-millis=999999999
  --shortest-chapter-len-millis=82000 #teeny chapter 1:22

  --force-chapter-break-end-seconds=704.76
  --force-chapter-break-end-seconds=4117.11
  --force-chapter-break-end-seconds=7661.75
  --force-chapter-break-end-seconds=11009.5
  --force-chapter-break-end-seconds=11192.7
  --force-chapter-break-end-seconds=15199.3
  --force-chapter-break-end-seconds=19332.7
  --force-chapter-break-end-seconds=23598.3
  --force-chapter-break-end-seconds=23681
  --force-chapter-break-end-seconds=27189.5
  --force-chapter-break-end-seconds=30456.4
  --force-chapter-break-end-seconds=33978.7

  googleplay_borders_of_infinity.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
