#!/usr/bin/perl
# $File: //member/autrijus/Class-PseudoHash/Makefile.PL $ $Author: autrijus $
# $Revision: #4 $ $Change: 2349 $ $DateTime: 2001/11/13 03:59:02 $

use 5.005;
use strict;

# ExtUtils::AutoInstall Bootstrap Code, version 1.
BEGIN { my $p='ExtUtils::AutoInstall'; eval"use $p 0.21;1" or(print
	"*** Fetching $p.\n"), require CPAN, CPAN::install $p; eval
	"use $p 0.21;1" or die "*** Please install $p manually.\n"}

use ExtUtils::AutoInstall (
    -version		=> '0.21',
    -core		=> [
        'Test::Harness'	=> '1.23',
        'Test::More'	=> '0.31',	# tests
    ],
);

WriteMakefile(
    AUTHOR		=> 'Autrijus Tang (autrijus@autrijus.org)',
    ABSTRACT		=> 'Emulates Pseudo-Hash behaviour via overload',
    NAME		=> 'Class::PseudoHash',
    VERSION_FROM	=> 'PseudoHash.pm', 
    DISTNAME		=> 'Class-PseudoHash',
    BINARY_LOCATION	=> 'x86/Class-PseudoHash.tar.gz',

    dist		=> {
        COMPRESS	=> 'gzip',
        SUFFIX		=> '.gz',
    },
);
