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

  --long-breaks-min-silence-millis=2737

  --shortest-chapter-len-millis=1440000 #except: ch1 ch3

  --force-chapter-break-end-seconds=413.423 #ch2
  --force-chapter-break-end-seconds=2920.9  #ch4

  --fake-chapter-break-end-seconds=7118.75
  --fake-chapter-break-end-seconds=10505.1
  --fake-chapter-break-end-seconds=11184.4
  --fake-chapter-break-end-seconds=12980.6
  --fake-chapter-break-end-seconds=13041.8

  googleplay_proto_zoa.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
