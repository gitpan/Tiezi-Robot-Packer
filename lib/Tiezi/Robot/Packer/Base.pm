# ABSTRACT: 打包小说基础引擎
use strict;
use warnings;
package  Tiezi::Robot::Packer::Base;
use Moo;
extends 'Novel::Robot::Packer::Base';
use Encode::Locale;
use Encode;

sub format_default_filename {
    my ($self, $tz) = @_;
   return  "$tz->{topic}{name}-$tz->{topic}{title}.$self->{suffix}";
}

sub format_before_toc { }
sub format_toc { }
sub format_before_floor { }
sub format_floor { }
sub format_after_floor { }


no Moo;
1;
