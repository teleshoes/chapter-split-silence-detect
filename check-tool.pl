#!/usr/bin/perl
use strict;
use warnings;
use File::Basename qw(basename dirname);

my $BASE_DIR = dirname $0;

sub assertExists(@);
sub getDirs();
sub gitCommitExistingDirs();

sub main(@){
  system "cd $BASE_DIR && git status";
  print "\n\n";

  for my $dir(getDirs()){
    print "CHECKING: $dir\n";
    system "rm $BASE_DIR/$dir/info-chapters";
    system "rm $BASE_DIR/$dir/info-commands";
    if(-e "$BASE_DIR/$dir/info-chapters" or -e "$BASE_DIR/$dir/info-commands"){
      die "ERROR: could not remove info-chapters/info-commands for $dir\n";
    }

    system "cd $BASE_DIR/$dir/ && ./chapter-split-$dir.sh --output-info";

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

    my %oggsByWav = map {my $wav=basename $_; $wav=~s/\.ogg/\.wav/; $wav => $_} @oggs;

    for my $wav(sort keys %ffmpegCmds, sort keys %oggencCmds){
      die "ERROR: missing ogg for $wav\n" if not defined $oggsByWav{$wav};
    }
    for my $wav(sort keys %oggsByWav){
      my $oggFile = $oggsByWav{$wav};
      die "ERROR: missing ogg file\n" if not -f $oggFile;

      die "ERROR: missing ffmpeg cmd for $wav\n" if not defined $ffmpegCmds{$wav};
      die "ERROR: missing oggenc cmd for $wav\n" if not defined $oggencCmds{$wav};
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
