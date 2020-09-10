#!/bin/bash
args=(
  --artist="Lois McMaster Bujold, Grover Gardner"
  --album="The Vor Game"

  --long-breaks-min-silence-millis=1800
  --shortest-chapter-len-millis=1713000

  --force-chapter-break-end-seconds=7191.66 #ch5
  --force-chapter-break-end-seconds=19930.4 #ch11
  --force-chapter-break-end-seconds=25719 #ch13
  --force-chapter-break-end-seconds=30918.4 #ch15

  --fake-chapter-break-end-seconds=9054.87
  --fake-chapter-break-end-seconds=9394.81
  --fake-chapter-break-end-seconds=13090.4
  --fake-chapter-break-end-seconds=15560.8
  --fake-chapter-break-end-seconds=17320.3
  --fake-chapter-break-end-seconds=19350.3
  --fake-chapter-break-end-seconds=19602.5
  --fake-chapter-break-end-seconds=19635.7
  --fake-chapter-break-end-seconds=19688.9
  --fake-chapter-break-end-seconds=19914.7
  --fake-chapter-break-end-seconds=22331.5
  --fake-chapter-break-end-seconds=22659.7
  --fake-chapter-break-end-seconds=24563.2
  --fake-chapter-break-end-seconds=24733.3
  --fake-chapter-break-end-seconds=25036.1
  --fake-chapter-break-end-seconds=25657.9
  --fake-chapter-break-end-seconds=27615.6
  --fake-chapter-break-end-seconds=27631.7
  --fake-chapter-break-end-seconds=27667.7
  --fake-chapter-break-end-seconds=30378.5
  --fake-chapter-break-end-seconds=30394.1
  --fake-chapter-break-end-seconds=30671.9
  --fake-chapter-break-end-seconds=30678.8
  --fake-chapter-break-end-seconds=31181.4
  --fake-chapter-break-end-seconds=31270.2
  --fake-chapter-break-end-seconds=32656.4
  --fake-chapter-break-end-seconds=32723.2
  --fake-chapter-break-end-seconds=36028.2
  --fake-chapter-break-end-seconds=38542.3
  --fake-chapter-break-end-seconds=38771.7
  --fake-chapter-break-end-seconds=38891.7
  --fake-chapter-break-end-seconds=39038.4
  --fake-chapter-break-end-seconds=39165.2
  --fake-chapter-break-end-seconds=39421.4
  --fake-chapter-break-end-seconds=39540.3

  googleplay_the_vor_game.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
