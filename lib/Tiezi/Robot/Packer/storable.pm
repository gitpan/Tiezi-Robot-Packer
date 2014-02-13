package Tiezi::Robot::Packer::storable;
use strict;
use warnings;
use utf8;

use base 'Tiezi::Robot::Packer';
use Storable;


sub suffix {
    'storable';
}

sub main {
    my ($self, $tz, %opt) = @_;
    store $tz, $opt{output};
    return $opt{output};
}

no Moo;
1;
