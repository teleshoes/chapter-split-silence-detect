#!/bin/bash
args=(
  --artist="Lois McMaster Bujold, Grover Gardner"
  --album="A Civil Campaign"
  --custom-chapter-name="20:Epilogue"

  --shortest-chapter-len-millis=2269000

  --force-chapter-break-end-seconds=16254 #ch6

  --fake-chapter-break-end-seconds=4671.8

  googleplay_a_civil_campaign.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
