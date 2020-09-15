#!/usr/bin/perl
use strict;
use warnings;

my $inputFile = "googleplay_shards_of_honor.m4a.orig";

sub hmsToSec($);

my @chapterDurs = (
  '38:13',  #ch01
  '39:51',  #ch02
  '30:01',  #ch03
  '39:07',  #ch04
  '25:12',  #ch05
  '29:31',  #ch06
  '39:30',  #ch07
  '28:49',  #ch08
  '25:53',  #ch09
  '19:45',  #ch10
  '31:34',  #ch11
  '32:17',  #ch12
  '39:06',  #ch13
  '40:44',  #ch14
  '36:05',  #ch15
  '26:03',  #aftermaths
);

sub main(@){
  my $lastStart = 0;
  for(my $i=0; $i<@chapterDurs; $i++){
    my $dur = hmsToSec $chapterDurs[$i];
    print "$dur\n";
    next;
    my $file = sprintf "%02d.wav", $i+1;
    my @ffmpegCmd = ("ffmpeg", "-i", $inputFile, "-ss", $lastStart, "-t", $dur, $file);
    system @ffmpegCmd;
    $lastStart += $dur;
    print "@ffmpegCmd\n";
  }

  system "oggenc *.wav";
#  system "flac --best *.wav";
}

sub hmsToSec($){
  my ($hms) = @_;
  if($hms =~ /^(\d+):(\d\d):(\d\d)$/){
    return $1*60*60 + $2*60 + $3;
  }elsif($hms =~ /^(\d+):(\d\d)$/){
    return $1*60 + $2;
  }else{
    die "ERROR: invalid H:MM:SS or M:SS time \"$hms\"\n";
  }
}

&main(@ARGV);
