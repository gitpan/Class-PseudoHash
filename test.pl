#!/usr/bin/perl
# $File: //member/autrijus/Class-PseudoHash/test.pl $ $Author: autrijus $
# $Revision: #1 $ $Change: 1495 $ $DateTime: 2001/08/01 19:13:52 $

use Test::Simple tests => 6;
use Class::PseudoHash;

my @arg = ([qw/hello hay hoo aiph/], [1..10]);
$h = Class::PseudoHash->new(@arg);

ok((defined($h) and ref $h eq 'Class::PseudoHash'), 'new() works');

$h = fields::phash(@arg);

ok((defined($h) and ref $h eq 'Class::PseudoHash'), 'fields::phash() works');

$h->{hello} = 'hi';
$h->{hay} = 'hay';

ok($h->[1] eq 'hi', 'array access works');
ok($h->{aiph} eq '4', 'hash access works');
ok(keys %$h eq '4', 'keys works');
ok($#{$h} eq '4', 'fetchsize works');

