#!/usr/bin/perl
# $File: //member/autrijus/Class-PseudoHash/Makefile.PL $ $Author: autrijus $
# $Revision: #2 $ $Change: 1496 $ $DateTime: 2001/08/01 19:19:18 $

require 5.005;

use ExtUtils::MakeMaker;

WriteMakefile(
    AUTHOR		=> 'Autrijus Tang (autrijus@autrijus.org)',
    ABSTRACT		=> 'Emulates Pseudo-Hash behaviour via overload',
    NAME		=> 'Class::PseudoHash',
    VERSION_FROM	=> 'PseudoHash.pm', 
    DISTNAME		=> 'Class-PseudoHash',
    BINARY_LOCATION	=> 'x86/Class-PseudoHash.tar.gz',

    PREREQ_PM		=> {
	'Test::Simple'	=> '0.01',
    },

    dist		=> {
        COMPRESS	=> 'gzip',
        SUFFIX		=> '.gz',
    },
);

