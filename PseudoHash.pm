# $File: //member/autrijus/Class-PseudoHash/PseudoHash.pm $ $Author: autrijus $
# $Revision: #2 $ $Change: 1675 $ $DateTime: 2001/09/03 20:39:12 $

package Class::PseudoHash;
require 5.005;

$Class::PseudoHash::VERSION = '0.02';

use strict;

=head1 NAME

Class::PseudoHash - Emulates Pseudo-Hash behaviour via overload

=head1 SYNOPSIS

    use Class::PseudoHash;

    my @arg = ([qw/key1 key2 key3 key4/], [1..10]);
    $ref = fields::phash(@arg);          # phash override
    $ref = Class::PseudoHash->new(@arg); # constructor syntax

=head1 DESCRIPTION

Due to its impact on overall performance of ordinary hashes, pseudo-hashes
are deprecated in perl v5.8, and will cease to exist in perl v5.10. The 
C<fields> pragma is supposed to change to use a different implementation.

Although L<perlref/Pseudo-hashes: Using an array as a hash> recommends
against using the first-element-as-index behaviour, certainly there are
many brave souls still writing such codes, and fear that the elimination
of pseudo-hashes will require a massive rewrite of their programs.

As one of the primary victims, I tried to find a drop-in solution that 
could emulate exactly the same semantic of pseudo-hashes, thus keeping 
all my legacy code intact. So C<Class::PseudoHash> is born.

Hence, if you're using the perferred C<fields::phash()> function, just 
write:

    use fields;
    use Class::PseudoHash;

then everything will work like before. If you are creating pseudo-hashes 
by hand (C<[{}]> anyone?), just write this:

    $ref = Class::PseudoHash->new;

and use the returned object in whatever way you like.

=head1 NOTES

If you set C<$Class::PseudoHash::FixedKeys> to a false value and tries
to access a non-existent hash key, then a new pseudo-hash entry will be
created silently. This is most useful if you're already using untyped
pseudo-hashes, and don't want the compile-time checking feature.

=head1 CAVEATS

Compile-type validating of keys is not possible with this module,
for obvious reasons. Also, the performance will not be as fast as
typed pseudo-hashes (but generally faster than untyped ones).

The numeric context overloading (C<0+>) is broken, and i don't have the
time to track it down.

=cut

use constant NO_SUCH_FIELD => 'No such pseudohash field "%s"';
use constant NO_SUCH_INDEX => 'Bad index while coercing array into hash';

use vars qw/$FixedKeys/;
$FixedKeys = 1;

my ($obj, $proxy);

use overload (
    '%{}'  => sub { $$obj = $_[0]; return $proxy },
    '""'   => sub { overload::AddrRef($_[0]) },
    '0+'   => sub { 0 },
    'bool' => sub { 1 },
    'cmp'  => sub { "$_[0]" cmp "$_[1]" },
    '<=>'  => sub { "$_[0]" cmp "$_[1]" }, # for completeness' sake
);

sub import {
    no strict 'refs';

    my $class = shift;
    tie %{$proxy}, $class;

    *{'fields::phash'} = sub {
	$class->new(@_);
    } unless defined $_[0];
}

sub new {
    my $class = shift;
    my @array = undef;

    if (UNIVERSAL::isa($_[0], 'ARRAY')) {
	foreach my $k (@{$_[0]}) {
	    $array[$array[0]{$k} = @array] = $_[1][$#array];
	}
    }
    else {
	while (my ($k, $v) = splice(@_, 0, 2)) {
	    $array[$array[0]{$k} = @array] = $v;
	}
    }

    bless(\@array, $class);
}

sub FETCH {
    my ($self, $key) = @_;
    $self = $$$self;

    return $self->[
	$self->[0]{$key} >= 1 
	    ? $self->[0]{$key}
	    : defined($self->[0]{$key})
                ? _croak(NO_SUCH_INDEX)
	        : $FixedKeys 
		    ? _croak(NO_SUCH_FIELD, $key)
		    : @$self
    ];
}

sub STORE {
    my ($self, $key, $value) = @_;
    $self = $$$self;

    return $self->[
	$self->[0]{$key} >= 1 
	    ? $self->[0]{$key}
	    : defined($self->[0]{$key})
                ? _croak(NO_SUCH_INDEX)
	        : $FixedKeys 
		    ? _croak(NO_SUCH_FIELD, $key)
		    : @$self
    ] = $value;
}

sub _croak {
    require Carp;
    Carp::croak(sprintf(shift, @_));
}

sub TIEHASH {
    bless \$obj => shift;
}

sub FIRSTKEY {
    scalar keys %{$${$_[0]}->[0]};
    each %{$${$_[0]}->[0]};
}

sub NEXTKEY {
    each %{$${$_[0]}->[0]};
}

sub EXISTS {
    exists $${$_[0]}->[0]{$_[1]};
}

sub DELETE {
    delete $${$_[0]}->[0]{$_[1]};
}

sub CLEAR {
    @{$${$_[0]}} = undef;
}

1;

=head1 SEE ALSO

L<fields>,
L<perlref/Pseudo-hashes: Using an array as a hash>

=head1 AUTHORS

Autrijus Tang E<lt>autrijus@autrijus.org>

=head1 COPYRIGHT

Copyright 2001 by Autrijus Tang E<lt>autrijus@autrijus.org>.

This program is free software; you can redistribute it and/or 
modify it under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut
