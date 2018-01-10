#!/usr/bin/perl
use strict;
use warnings;

# primary source: https://www.iqt.org/portfolio/
# backup source:  https://en.wikipedia.org/wiki/In-Q-Tel

sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}

my $url = 'https://www.iqt.org/portfolio/';
my $contents=`curl -L -s $url`;

my @matches = $contents =~ /\<a class=".*esgbox" href=".*?" lgtitle="(.*?)"\>Read More\<\/a\>/g;
my $i = 0;
foreach (@matches) {
    if ($i >= 200 && $i <= 250) {
        print "$i\n";

        `python theHarvester/theHarvester.py -d "$_" -b linkedin > "tmp.txt"`;

        my $new_employees = `sed -n 20,99999p "tmp.txt"`;
        my $existing_employees = `sed -n 20,99999p "companies/$_.txt"`;
        my @employees = sort(uniq(split("\n", $new_employees . $existing_employees)));

        open(my $fh, ">", "companies/$_.txt") or die "Could not open file 'companies/$_.txt.'";
        print $fh join("\n", @employees);
        close $fh;

        # `python theHarvester/theHarvester.py -d "$_" -b linkedin > "companies/$_.txt"`;
    }
    $i++;
}

unlink "tmp.txt"

# 205 files grabbed via primary
# 120 files grabbed via backup
