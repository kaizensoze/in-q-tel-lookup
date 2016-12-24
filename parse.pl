#!/usr/bin/perl
use strict;
use warnings;

my $url = $ARGV[0] || 'en.wikipedia.org/wiki/In-Q-Tel';
my $regex = $ARGV[1];
my $contents=`curl -L -s $url`;

my @matches = $contents =~ /\<li\>\<a\ href=".*"\ title=".*"\>(.*?)\<\/a\> (?:–|-)/g;
print "$_\n" for @matches;