#! /usr/bin/perl

#*--<<Definision>>-----------------------------------------*
#PGID         merge_polymorphism_files.pl
#Kind of PG   Main PG
#Create Date  2012/02/14
#
#       Merge DNA polymorphism files from pileup (mpileup)
#
#   Comandline  DNA polymorphism file1
#               DNA polymorphism file2
#               output text file
#*---------------------------------------------------------*
#***********************************************************
# use
#***********************************************************
#use warnings;
#use strict;
#***********************************************************
# constant
#***********************************************************
#***********************************************************
# variable
#***********************************************************
my @list;
my @tmp1;
my @tmp2;
#***********************************************************
# Main Coading
#***********************************************************
my $input_file_1    = $ARGV[0];
my $input_file_2    = $ARGV[1];
my $output_file     = $ARGV[2];

open (IN_1, "< $input_file_1") or "die cannot open $input_file_1\n";
open (IN_2, "< $input_file_2") or "die cannot open $input_file_2\n";
open (OUT, "> $output_file\n") or "die cannot open $output_file\n";

while (my $l = <IN_1>) {
	if($l =~ /^#/){
		print OUT "$l";
		next;
	}
	my @ls = split /\t/, $l;
	push(@list, $l);
	push(@tmp1, $ls[0]);
	push(@tmp2, $ls[1]);
}

while (my $l = <IN_2>) {
	if($l =~ /^#/){
		next;
	}
	my @ls = split /\t/, $l;
	push(@list, $l);
	push(@tmp1, $ls[0]);
	push(@tmp2, $ls[1]);
}

## sort 1:contig, 2:position, 3:index ##
@list = @list[sort {$tmp1[$a] cmp $tmp1[$b] or $tmp2[$a] <=> $tmp2[$b]} 0 .. $#tmp1];
#print OUT "@list";
foreach (@list) {
	print OUT "$_";
}

close OUT;
close IN_1;
close IN_2;

