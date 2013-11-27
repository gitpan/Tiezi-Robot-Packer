# ABSTRACT: 打包贴子为TXT
package Tiezi::Robot::Packer::TXT;
use strict;
use warnings;
use utf8;

use Moo;
extends 'Tiezi::Robot::Packer::Base';
use HTML::FormatText;
use HTML::TreeBuilder;
use IO::File;

has '+suffix' => ( default => sub { 'txt' } );

sub BUILD {
    my ( $self ) = @_;
    $self->{formatter} = $self->{format_option} ?  
    HTML::FormatText->new(@{$self->{format_option}}) : 
    HTML::FormatText->new() ;
    $self;
}

sub format_before_toc {
    my ( $self, $tz ) = @_;
    my $title      = "$tz->{topic}{name}《$tz->{topic}{title}》" || '';
    my $toc_url  = $tz->{topic}{url} || '';
    return qq[$title\n来自：$toc_url\n];
}

sub format_toc {
    my ($self, $r) = @_; 

    #my $toc=qq`<li><a href="#toc0">$r->{topic}{time} $r->{topic}{name}</a></li>\n`;
    my $toc='';

    for my $i (0 .. $#{$r->{floors}}){
        my $f = $r->{floors}[$i];
        next if($f->{skip});

        my $id = $f->{id} || ($i+1);
        $toc.=qq`$id# $f->{title} $f->{time} $f->{name}\n`;
    }   

    #$toc = qq[<div id="toc"><ol>$toc</ol></div>]; 
    $toc = "\n$toc\n";
    return $toc;
}

sub format_before_floor {
    my ($self, $tz) = @_;

    my $f = $tz->{topic};
    my $ft = <<__FLOOR__;
000# $f->{title} $f->{time} $f->{name}
<br>
$f->{content}
__FLOOR__
    my $tree = HTML::TreeBuilder->new_from_content($ft);
    my $c = $self->{formatter}->format($tree);
   return $c; 
}

sub format_floor {
    my ( $self, $f , $id) = @_;
    return if($f->{skip});

    $f->{id} ||= $id || 1;
    my $j = sprintf( "%03d# ", $f->{id});

    my $ft = <<__FLOOR__;
$j $f->{title} $f->{time} $f->{name}
$f->{content}\n
__FLOOR__
    my $tree = HTML::TreeBuilder->new_from_content($ft);
    my $c = $self->{formatter}->format($tree);
   return $c; 
} ## end sub format_floor

sub format_after_floor {
    my ( $self, $toc ) = @_;

    return "";
}

no Moo;
1;
