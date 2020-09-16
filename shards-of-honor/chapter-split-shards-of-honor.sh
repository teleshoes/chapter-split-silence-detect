#!/bin/bash
args=(
  --artist="Lois McMaster Bujold, Grover Gardner"
  --album="Shards of Honor"
  --custom-chapter-name="16:Aftermaths"

  --shortest-chapter-len-millis=1140000

  --fake-chapter-break-end-seconds=22554.2
  --fake-chapter-break-end-seconds=29676.8
  --fake-chapter-break-end-seconds=31169.8
  --fake-chapter-break-end-seconds=31242.1

  googleplay_shards_of_honor.m4a.orig
)
chapter-split.pl "${args[@]}" "$@"
