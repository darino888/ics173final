#!/usr/bin/perl -w
#
my $PN = "$0";  $PN =~ s/.*\///;
my $VN = "0.1";

use strict;
use Text::CSV;

my $CSV = Text::CSV->new( { sep_char => ',' } );

my $file = $ARGV[0] or die "Need a CSV file on the command line\n";


#
# open dataset, and discard the header
#
my $DATA;
my $LINE;

open($DATA, '<', $file) or die "Cannot open '$file' $!\n";
$LINE = <$DATA>;


#
# read and process dataset
#
my $lines = 1;
my $hits = 0;
my @fields;
my ($race, $date);
my %RACE_COUNT;

while ($LINE = <$DATA>) {
    $lines++;
    chomp ($LINE);

    if ($CSV->parse($LINE)) {
        @fields = $CSV->fields();

	#
	# if Column 11 is "Yes" the patient has comorbidities
	#
	if ($fields[10] eq "Yes") {
	    #
	    # if Column 7 is not "Unknown", then emit the record,
	    # otherwise we ignore the line
	    #
	    $race = $fields[6];

	    if ($race ne "Unknown" &&
	        $race ne "Missing" &&
		$race ne "NA"        ) {
		#
	        print "cdc_report_dt,race\n" if ($hits == 0);    # JUST THE FIRST TIME
		$date = $fields[0];
		
		# EMIT the record
		print "$date,\"$race\"\n";
		$RACE_COUNT{$race}++;
	    }
	    else {
	        #DEBUG#  print ("$LINE\n");
		#DEBUG#  exit(0);
	    }

	    $hits++;
	}
	else {
	    #
	    # we don't care about all other data
	    #
	}
    }
    else {
        warn "Line could not be parsed: $LINE\n";
    }


    #
    # for debugging
    #
    #DEBUG#  exit(0) if ($lines == 1000);
}


#
# print a report of how many of each race there were
#
my $key;

foreach $key (sort keys(%RACE_COUNT)) {
    print STDERR "\"$key\",$RACE_COUNT{$key}\n";
}


# EOF #
