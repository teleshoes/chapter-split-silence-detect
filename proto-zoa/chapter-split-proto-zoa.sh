#!/bin/bash
args=(
  --artist="Lois McMaster Bujold, Grover Gardner"
  --album="Proto Zoa"
  --custom-chapter-name="1:Author's Note"
  --custom-chapter-name="2:Barter"
  --custom-chapter-name="3:Garage Sale"
  --custom-chapter-name="4:The Hole Truth"
  --custom-chapter-name="5:Dreamweaver's Dilemma Part1"
  --custom-chapter-name="6:Dreamweaver's Dilemma Part2"
  --custom-chapter-name="7:Aftermaths"


  --long-breaks-min-silence-millis=999999999

  --force-chapter-break-end-seconds=413.423 #ch2
  --force-chapter-break-end-seconds=1854.69 #ch3
  --force-chapter-break-end-seconds=2920.9  #ch4
  --force-chapter-break-end-seconds=4687.06 #ch5
  --force-chapter-break-end-seconds=8086.56 #ch6
  --force-chapter-break-end-seconds=11350.3 #ch7




  googleplay_proto_zoa.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
