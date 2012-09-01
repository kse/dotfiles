#!/usr/bin/env perl
use warnings;
use strict;
# vim: set sw=4 sts=4 :

use File::Spec;
use File::Basename;

# This is relative, it'll have to do for now.
my $cfg_folder = "../config";
chdir($cfg_folder) or die "Unable to cd to configfolder: $!";

if(!$ENV{HOME}) {
	die "I need the environment variable HOME declared\n";
}

my $err = 0;

# Filehandle of file containing information about placement of files.
open(my $pl_fh, '<', "$cfg_folder/PLACEMENTS") or die "Unable to open placement file: $!";

while(my $line = <$pl_fh>) {
	my ($cfg, $place) = split(/\t+/, $line);
	chomp($place);

	if(!$cfg || !$place) {
		print "Invalid placement line: '$line'\n";
		next;
	}

	# Remove beginning/trailing whitespace.
	$cfg =~ s/^\s+//;
	$cfg =~ s/\s+$//;
	$place =~ s/^\s+//;
	$place =~ s/\s+$//;

	# Replace tilde with home path.
	$place =~ s/~/$ENV{HOME}/;

	# Get full path of cfg file.
	$cfg = File::Spec->rel2abs($cfg);

	#The placement is not a link and therefore not linked to the repo file.
	if(!-l $place) {
		print "Not linked: $place\n";
		$err++;
		next;
	} else {
		my $link_path = readlink($place);
		if(!$link_path) {
			print "Unable to read link path: $!\n";
		}

		my $link_dir = dirname($place);
		$link_path = File::Spec->rel2abs($link_path, $link_dir);

		if($link_path ne $cfg) {
			print "Invalidly linked $place\n";
			$err++;
		}
	}
}

close($pl_fh);

if($err == 0) {
	print "All files linked correctly\n";
} else {
	print "There are $err incorrectly linked files\n";
}
