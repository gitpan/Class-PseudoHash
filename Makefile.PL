#!/usr/bin/perl
# $File: //member/autrijus/Class-PseudoHash/Makefile.PL $ $Author: autrijus $
# $Revision: #3 $ $Change: 1677 $ $DateTime: 2001/09/03 20:41:22 $

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
	'Test::More'	=> '0.11',
    },

    dist		=> {
        COMPRESS	=> 'gzip',
        SUFFIX		=> '.gz',
    },
);

