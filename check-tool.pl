#!/usr/bin/perl
use strict;
use warnings;
use File::Basename qw(dirname);

my $BASE_DIR = dirname $0;

sub getDirs();
sub gitCommitExistingDirs();

sub main(@){
  gitCommitExistingDirs();
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
