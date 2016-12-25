#!/usr/bin/perl
use strict;
use warnings;

# primary source: https://www.iqt.org/portfolio/
# backup source:  https://en.wikipedia.org/wiki/In-Q-Tel

my $url = 'https://www.iqt.org/portfolio/';
my $contents=`curl -L -s $url`;

my @matches = $contents =~ /\<a class=".*esgbox" href=".*?" lgtitle="(.*?)"\>Read More\<\/a\>/g;
my $i = 0;
foreach (@matches) {
    if ($i >= 190 && $i <= 240) {
        print "$i\n";
        `python theHarvester/theHarvester.py -d "$_" -b linkedin > "companies/$_.txt"`;
    }
    $i++;
}

# 205 files grabbed via primary
# 120 files grabbed via backup
