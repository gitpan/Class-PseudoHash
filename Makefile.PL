#!/usr/bin/perl
# $File: //member/autrijus/Class-PseudoHash/Makefile.PL $ $Author: autrijus $
# $Revision: #1 $ $Change: 1 $ $DateTime: 2002/06/11 08:35:12 $

use 5.005;
use strict;

# ExtUtils::AutoInstall Bootstrap Code, version 4.
BEGIN{my$p='ExtUtils::AutoInstall';my$v=.30;eval"use $p $v;1"or
($ENV{PERL_EXTUTILS_AUTOINSTALL}!~/--(?:default|skip|testonly)/
and(-t STDIN)or eval"use ExtUtils::MakeMaker;WriteMakefile('PR'
.'EREQ_PM'=>{'$p',$v});1"and exit)and print"==> $p $v needed. "
."Install it from CPAN? [Y/n] "and<STDIN>!~/^n/i and print"***"
." Fetching $p\n"and do{eval{require CPANPLUS;CPANPLUS::install
$p};eval"use $p $v;1"or eval{require CPAN;CPAN::install$p};eval
"use $p $v;1"or die"Please install $p $v manually first...\n"}}

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
