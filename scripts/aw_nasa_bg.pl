#!/usr/bin/env perl
use warnings;
use strict;

use XML::Simple qw(:strict);
use Data::Dumper;
use File::Copy;
use Text::Wrap qw(wrap);
use Proc::Daemon;
use Encode;

# Simple script to change the awesome background to the nasa
# image of the day.
#
# Call this from crontab, and it should just work. But only for one
# user on a machine at a time (it uses global filename).

my $feed_path = "http://www.nasa.gov/rss/lg_image_of_the_day.rss";

my $tmp_image = '/tmp/awesome_iotd_bckground.tmp';
my $image     = '/tmp/awesome_iotd_bckground.jpg';

my $lockfile  = '/tmp/awesome_iotd_bckground.pid';
my $logfile   = '/tmp/awesome_iotd_bckground.log';

# Default an hour.
my $sleeptime = 3600;

open(my $log, '>>', $logfile) or die "Unable to open logfile: $!";

$SIG{__DIE__} = sub {
	print $log "Die: $_[0]\n";
	die $_[0];
	exit 1;
};

$SIG{__WARN__} = sub {
	#print $log "Received signal $_[1]\n";
	print $log "Warn: " . $_[0] . "\n";
};

$SIG{'INT'} = sub {
	print $log "Interruped by signal\n";
	exit 1;
};

if(-e $lockfile) {
	open(my $LFH, '<', $lockfile);
	my $pid = <$LFH>;
	chomp($pid);
	my $ret;

	$ret = kill(0, ($pid));

	# Process is running.
	if($ret) {
		my $process = `ps -p $pid -o command`;
		if($process =~ m/\Q$0\E/) {
			print "Program is already running, exiting\n";
			exit 1;
		} else {
			# Someone else has taken our old PID
		}
	} else {
		#Process is not running, success
	}
}

Proc::Daemon->init();

# Write the lockfile.
open(my $LFH, '>', $lockfile) or die $!;
print $log "Writing pid $$ to lockfile\n";
print $LFH $$;
close($LFH);

while(1) {
	my $data = `wget -O - $feed_path 2> /dev/null`;

	if(($? >> 8) != 0) {
		if(-t STDOUT) {
			print $log "Error fetching page with wget\n";
		}
		#exit 1;
		$sleeptime = 500;
		next;
	}

	my $ref = XMLin($data, ForceArray => [], KeyAttr => {});

	if(!$ref) {
		if(-t STDOUT) {
			print $log "Error parsing XML\n";
		}
		#exit 1;
		$sleeptime = 500;
		next;
	}

	my $link = $ref->{channel}->{item}->{enclosure}->{url};
	my $title = $ref->{channel}->{item}->{title};
	my $description = $ref->{channel}->{item}->{description};

	if(!$link || !$title || !$description) {
		if(-t STDOUT) {
			print $log "No data in hashref\n"
		}
		$sleeptime = 500;
		next;
		#exit 1;
	}

	`wget -O $tmp_image $link 2> /dev/null`;

	if(($? >> 8) != 0) {
		if(-t STDOUT) {
			print $log "Error fetching image\n";
		}
		if(-e $tmp_image) {
			unlink($tmp_image);
		}
		$sleeptime = 500;
		next;
		#exit 1;
	}

	move($tmp_image, $image);

	#print $log "Before awset\n";
	#my $message = `awsetbg -a $image`;
	my $message = `feh --bg-max $image`;
	#print $log "Just asfter awset\n";
	if(($? >> 8) != 0) {
		print $log "Error settings background: $message\n";
		#print $log "Inside error awset\n";
		next;
	} else {
		print $log "Updated background image\n";
	}

	#print $log "After awset\n";
	if($ENV{HOME}) {
		open(my $msgfh, '>', $ENV{HOME} . '/.message') or die $!;

		$description = decode_utf8($description);

		print $msgfh wrap('', '', "-- $title --")       . "\n";
		print $msgfh wrap('', '', $description) . "\n";

		close($msgfh);
	}

	$sleeptime = 3600;
} continue {
	sleep($sleeptime);
}
