package Tiezi::Robot::Packer::txt;
use strict;
use warnings;
use utf8;

use base 'Tiezi::Robot::Packer';
use HTML::FormatText;
use HTML::TreeBuilder;
use Template;

sub suffix {
    'txt';
}

sub main {
    my ($self, $tz, %opt) = @_;
    $self->filter_skip_floors($tz);

    $self->{formatter} = HTML::FormatText->new() ;
    $self->format_floor_content($_) for @{$tz->{floors}};

    $self->process_template($tz, %opt);
    return $opt{output};
}

sub format_floor_content {
    my ($self, $r) = @_;
    my $tree = HTML::TreeBuilder->new_from_content($r->{content});
    $r->{content} = $self->{formatter}->format($tree);
}

sub process_template {
    my ($self, $tz, %opt) = @_;
    my $txt = qq{
    [% topic.name %]《 [% topic.title %] 》

    [% FOREACH r IN floors %][% r.id %]#  [% r.title %] [% r.time %]  [% r.name %]
    [% END %]

    [% FOREACH r IN floors %]
    [% r.id %]#  [% r.title %] [% r.time %]  [% r.name %]
    [% r.content %]
    [% END %]
    };
    my $tt=Template->new();
    $tt->process(\$txt, $tz, $opt{output}, { binmode => ':utf8' })  || die $tt->error(), "\n";
}

1;
