#!/usr/bin/env perl
#===============================================================================
#
#         FILE: simu.pl
#
#        EXAMPLE: ./simu.pl < <(while true; do echo "1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22" ; done )
#
#  DESCRIPTION: le script lit le fichier fichier.csv ligne par ligne et pour chacune d'elle, attend en entree une liste de 22 nombres compris entre 
#  				1 et 70. Transforme cette liste en 11 liste de 10 nombre et retourne en sortie la ligne de 20 nombre lu dans fichier.csv
#  				et pour chacune des 11 listes, le nombre de nombre present ainsi que la liste de ceux-ci.
#
#      OPTIONS: ---
# REQUIREMENTS: Besoin du fichier "fichier.csv" dont le format est 20 champs de nombre (separe par un ";") compris entre 1 et 70.
# 				Le script attend en entrée 22 nombres (separe par un ";") compris entre 1 et 70. 
#         BUGS: ---
#        NOTES: Pour l'instant le script ne fait pas de controle de coherences des donnees.
# ORGANIZATION:
#      VERSION: 0.1
#      CREATED: 08/05/2017 11:47:03
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

my @tab2tab = (
	[1,0,0,1,0,1,1,1,0,0,1,0,0,1,1,1,0,0,1,0,0,0],
	[1,0,1,1,0,0,0,0,1,1,1,0,1,1,0,0,0,1,0,1,0,0],
	[1,1,0,0,1,1,0,1,0,1,0,0,1,0,0,0,0,1,1,0,1,0],
	[1,1,1,0,0,0,1,0,0,1,0,1,0,1,0,1,1,0,0,0,1,0],
	[1,1,0,1,1,0,0,0,1,0,0,1,0,0,1,0,1,0,1,1,0,0],
	[0,1,1,1,1,0,1,1,0,0,0,0,1,0,0,1,0,0,0,1,0,1],
	[0,0,1,0,1,1,1,0,1,0,1,0,1,0,1,0,1,0,0,0,1,0],
	[0,1,1,0,0,1,0,1,1,0,0,1,0,1,1,0,0,1,0,0,0,1],
	[0,0,0,1,1,1,0,0,0,1,1,1,0,0,0,1,1,1,0,0,0,1],
	[0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,1,1,1,1],
	[0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1]
);

my	$combi_file_name = 'fichier.csv';

open  my $combi, '<', $combi_file_name
	or die  "$0 : failed to open  input file '$combi_file_name' : $!\n";


while(<$combi>){
	my @tabf;
	chomp;
	my @lst=split(/;/);
	my $tabg = <>;
	chomp $tabg;
	my @tabg = split(/;/,$tabg);
	foreach my $Tab (@tab2tab){
		my @tabt;
		foreach (0..$#tabg){
			push @tabt, $tabg[$_] if ${$Tab}[$_];
		}
		push @tabf, [ @tabt ];
	}
	chomp;
	my @fnl=map { [ grep { my $uu=$_ ;grep { $uu == $_ } @lst } @$_ ] }  @tabf;
	map { print 1+$#$_," => ",join(";",@{ $_ }),"\n" } @fnl;
	print join(";", @lst),"\n";
}

close  $combi
	or warn "$0 : failed to close input file '$combi_file_name' : $!\n";

