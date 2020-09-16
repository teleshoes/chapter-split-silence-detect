#!/usr/bin/perl
use strict;
use warnings;
use File::Basename qw(basename dirname);
use Cwd qw(abs_path);

my $EXEC = basename $0;

my $BASE_DIR = abs_path(dirname $0);

my $OGG_DUR_TOOL_SOXI = "soxi";
my $OGG_DUR_TOOL_DURATION = "duration";
my $OGG_DUR_TOOL_NONE = "none";

my $ALLOWED_DURATION_DIFF_MILLIS = 60; #0.05s is the biggest actual diff seen so far

sub assertExists(@);
sub getDirs();
sub gitCommitExistingDirs();

my $usage = "Usage:
  $EXEC -h | --help
    show this message

  $EXEC [OPTS]
    check info files for each DIR, and compare against converted oggs
    also create symlink DIR/finished-oggs/original-file to DIR

  OPTS
    --quick
      same as: --skip-info --dur-tool=none

    --skip-info
      do not recalculate output info

    --dur-tool=DUR_TOOL
      use DUR_TOOL to read OGG duration

  DUR_TOOL = soxi|duration|none
    soxi    {DEFAULT}
      `soxi -D` to read duration from metadata
      quick, but may not give the same value as ffmpeg

    duration
      `duration -n -s` to read duration using ffmpeg
       SLOW, but guaranteed to exactly match `wav-durations` file

     none
       `cat wav-durations` to use pre-calculated WAV dur
       very fast, but useless for checking actual produced files
";

sub main(@){
  my $oggDurTool = $OGG_DUR_TOOL_SOXI;
  my $recalculateInfo = 1;
  my $createOriginalFileSymlink = 1;
  while(@_ > 0 and $_[0] =~ /^-/){
    my $arg = shift;
    if($arg =~ /^(-h|--help)$/){
      print $usage;
      exit 0;
    }elsif($arg =~ /^(--quick)$/){
      $recalculateInfo = 0;
      $oggDurTool = $OGG_DUR_TOOL_NONE;
    }elsif($arg =~ /^(--skip-info)$/){
      $recalculateInfo = 0;
    }elsif($arg =~ /^--dur-tool=($OGG_DUR_TOOL_SOXI|$OGG_DUR_TOOL_DURATION|$OGG_DUR_TOOL_NONE)$/){
      $oggDurTool = $1;
    }else{
      die "$usage\nERROR: unknown arg $arg\n";
    }
  }
  die $usage if @_ > 0;

  system "cd $BASE_DIR && git status";
  print "\n\n";

  for my $dir(getDirs()){
    print "CHECKING: $dir\n";

    if($recalculateInfo){
      system "rm $BASE_DIR/$dir/info-chapters";
      system "rm $BASE_DIR/$dir/info-commands";

      if(-e "$BASE_DIR/$dir/info-chapters" or -e "$BASE_DIR/$dir/info-commands"){
        die "ERROR: could not remove info-chapters/info-commands for $dir\n";
      }

      system "cd $BASE_DIR/$dir/ && ./chapter-split-$dir.sh --output-info";
    }

    assertExists(
      "$BASE_DIR/$dir/info-chapters",
      "$BASE_DIR/$dir/info-commands",
      "$BASE_DIR/$dir/wav-durations",
      "$BASE_DIR/$dir/wav-filesizes",
      "$BASE_DIR/$dir/wav-md5sums",
    );

    if(not -l "$BASE_DIR/$dir/finished-oggs" or not -d "$BASE_DIR/$dir/finished-oggs/"){
      die "ERROR: invalid/missing finished-oggs symlink for $dir\n";
    }

    my $originalFileSymlink = "$BASE_DIR/$dir/finished-oggs/original-file";
    if($createOriginalFileSymlink){
      if(-l $originalFileSymlink){
        system "rm", $originalFileSymlink;
      }
      die "ERROR: could not remove $originalFileSymlink\n" if -e $originalFileSymlink;
      system "ln", "-s", "$BASE_DIR/$dir", $originalFileSymlink;
      if(not -l $originalFileSymlink or not -d "$originalFileSymlink/"){
        die "ERROR: could not create $originalFileSymlink\n";
      }
    }

    my @oggs = glob "$BASE_DIR/$dir/finished-oggs/*.ogg";
    die "ERROR: missing converted oggs\n" if @oggs == 0;

    my @commands = `cat $BASE_DIR/$dir/info-commands`;
    chomp foreach @commands;
    my (%ffmpegCmds, %oggencCmds);
    for my $cmd(@commands){
      if($cmd =~ /^"?ffmpeg.* "?(\S+\.wav)"?$/){
        $ffmpegCmds{$1} = $cmd;
      }elsif($cmd =~ /^"?oggenc.* "?(\S+\.wav)"?$/){
        $oggencCmds{$1} = $cmd;
      }else{
        die "ERROR: unknown command in info-commands \"$cmd\"\n";
      }
    }

    my %wavDurations;
    my @wavDurationLines = `cat $BASE_DIR/$dir/wav-durations`;
    for my $line(@wavDurationLines){
      if($line =~ /^(\d+|\d*\.\d+) (.*\.wav)$/){
        $wavDurations{$2} = $1;
      }
    }

    my %ffmpegDurations;
    for my $wav(sort keys %ffmpegCmds){
      my $ffmpegCmd = $ffmpegCmds{$wav};
      if($ffmpegCmd =~ / -t (\d+|\d*\.\d+) /){
        $ffmpegDurations{$wav} = $1;
      }else{
        die "ERROR: could not read duration from ffmpeg cmd \"$ffmpegCmd\"\n";
      }
    }

    my %oggsByWav = map {my $wav=basename $_; $wav=~s/\.ogg/\.wav/; $wav => $_} @oggs;

    for my $wav(sort keys %ffmpegCmds, sort keys %oggencCmds){
      die "ERROR: missing ogg for $wav\n" if not defined $oggsByWav{$wav};
    }
    for my $wav(sort keys %oggsByWav){
      my $oggFile = $oggsByWav{$wav};
      die "ERROR: missing ogg file\n" if not -f $oggFile;

      die "ERROR: missing ffmpeg cmd for $wav\n" if not defined $ffmpegCmds{$wav};
      die "ERROR: missing oggenc cmd for $wav\n" if not defined $oggencCmds{$wav};

      my $wavDur = $wavDurations{$wav};
      my $ffmpegDur = $ffmpegDurations{$wav};

      my $oggDur;
      if($oggDurTool eq $OGG_DUR_TOOL_SOXI){
        $oggDur = `soxi -D $oggFile`;
      }elsif($oggDurTool eq $OGG_DUR_TOOL_DURATION){
        $oggDur = `duration -s -n $oggFile`;
      }elsif($oggDurTool eq $OGG_DUR_TOOL_NONE){
        $oggDur = $wavDur;
      }
      if($oggDur !~ /^(\d+|\d*\.\d+)$/ or $oggDur == 0){
        die "ERROR: missing/invalid dur for $oggFile\n";
      }

      my $wavDurDiff = $wavDur - $oggDur;
      $wavDurDiff *= -1 if $wavDurDiff < 0;
      if($wavDurDiff > $ALLOWED_DURATION_DIFF_MILLIS/1000.0){
        die "ERROR: mismatched ogg vs wav dur for $oggFile ($oggDur vs $wavDur)\n";
      }

      my $ffmpegDurDiff = $oggDur - $ffmpegDur;
      $ffmpegDurDiff *= -1 if $ffmpegDurDiff < 0;
      if($ffmpegDurDiff > $ALLOWED_DURATION_DIFF_MILLIS/1000.0){
        die "ERROR: mismatched ogg vs ffmpeg dur for $oggFile ($oggDur vs $ffmpegDur)\n";
      }
    }
  }

  print "\n\n";
  system "cd $BASE_DIR && git status";
}

sub assertExists(@){
  for my $file(@_){
    die "ERROR: '$file' does not exist\n" if not -f $file;
  }
}

sub getDirs(){
  my @dirs;
  for my $dir(glob "$BASE_DIR/*/"){
    $dir =~ s/^$BASE_DIR\///;
    $dir =~ s/\/$//;
    die "ERROR: could not parse dir $dir\n" if $dir =~ /\//;
    next if $dir eq ".git";
    push @dirs, $dir;
  }
  return @dirs;
}

sub gitCommitExistingDirs(){
  my @commands;
  push @commands, "git reset cc7d97e09e";
  for my $dir(getDirs()){
    my $mtime = `mtime $dir/googleplay*.m4a.orig`;
    chomp $mtime;
    my $mtimeP1 = $mtime+1;

    push @commands, "git add $dir/chapter-split*.sh";
    push @commands, "GIT_AUTHOR_DATE=\$(date --date=\@$mtime) git commit -m \"chapter-split: add $dir\"";
    push @commands, "git add $dir/info-* $dir/silence-detect-interval* $dir/wav-*";
    push @commands, "GIT_AUTHOR_DATE=\$(date --date=\@$mtimeP1) git commit -m \"info: add $dir\"";
  }
  push @commands, "git rebase --committer-date-is-author-date cc7d97e09e";

  for my $cmd(@commands){
    print "$cmd\n";
    #system $cmd;
  }
}

&main(@ARGV);
