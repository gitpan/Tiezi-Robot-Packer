# ABSTRACT: 打包小说基础引擎
use strict;
use warnings;
package  Tiezi::Robot::Packer::Base;
use Moo;
use Encode::Locale;
use Encode;

sub format_filename {
    my ($self, $filename) = @_;
    $filename ||= $self->{filename};
    $self->{filename} = encode( locale  => $filename);
}

sub open_packer { }
sub format_before_toc { }
sub format_toc { }
sub format_after_toc { }
sub format_before_floor { }
sub format_floor { }
sub format_after_floor { }
sub close_packer { }


no Moo;
1;
