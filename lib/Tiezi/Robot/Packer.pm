# ABSTRACT: 贴子打包引擎
use strict;
use warnings;
package  Tiezi::Robot::Packer;
use Moo;
use Tiezi::Robot::Packer::HTML;

our $VERSION = 0.01;

sub init_packer {
      my ( $self, $site , $opt) = @_;
      my $s = $opt?'%$opt':'';
      my $packer = eval qq[new Tiezi::Robot::Packer::$site($s)];
      return $packer;
}

no Moo;
1;
