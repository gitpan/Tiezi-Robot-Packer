# ABSTRACT: 打包贴子为HTML
package Tiezi::Robot::Packer::HTML;
use strict;
use warnings;
use utf8;

use Moo;
extends 'Tiezi::Robot::Packer::Base';

has '+suffix' => ( default => sub { 'html' } );

sub format_before_toc {
    my ( $self, $tz ) = @_;
    my $title      = "$tz->{topic}{name}《$tz->{topic}{title}》" || '';
    my $css = $self->generate_css();
    my $toc_url  = $tz->{topic}{url} || '';
    return qq[
        <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
        <html>

        <head>
        <title> $title </title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8">
        <style type="text/css">
        $css
        </style>
        </head>

        <body>
        <div id="title"><a href="$toc_url">$title</a></div>
        ];
}

sub generate_css
{
    my $css = <<__CSS__;
body {
    font-size: medium;
    font-family: Verdana, Arial, Helvetica, sans-serif;
    margin: 1em 8em 1em 8em;
    text-indent: 2em;
    line-height: 145%;
}
#title, .fltitle {
    border-bottom: 0.2em solid #ee9b73;
    margin: 0.8em 0.2em 0.8em 0.2em;
    text-indent: 0em;
    font-size: x-large;
    font-weight: bold;
    padding-bottom: 0.25em;
}
#title, ol { line-height: 150%; }
#title { text-align: center; }
__CSS__
    return $css;
} ## end sub read_css

sub format_toc {
    my ($self, $r) = @_; 

    my $toc=qq`<li><a href="#toc0">$r->{topic}{time} $r->{topic}{name}</a></li>\n`;

    for my $i (0 .. $#{$r->{floors}}){
        my $f = $r->{floors}[$i];
        next if($f->{skip});

        my $id = $f->{id} || ($i+1);
        $toc.=qq`<li><a href="#toc$id">$f->{title} $f->{time} $f->{name}</a></li>\n`;
    }   

    $toc = qq[<div id="toc"><ol>$toc</ol></div>]; 
    return $toc;
}

sub format_before_floor {
    my ($self, $tz) = @_;

    my $f = $tz->{topic};
    my $ft = <<__FLOOR__;
<div id="content">
<div class="floor">
<div class="fltitle">000# <a name="toc0">$f->{title} $f->{time} $f->{name}</a></div>
<div class="flcontent">$f->{content}</div>
</div>
__FLOOR__
   return $ft; 
}

sub format_floor {
    my ( $self, $f , $id) = @_;
    return if($f->{skip});

    $f->{id} ||= $id || 1;
    my $j = sprintf( "%03d# ", $f->{id});

    my $ft = <<__FLOOR__;
<div class="f">
<div class="fltitle">$j <a name="toc$f->{id}">$f->{title} $f->{time} $f->{name}</a></div>
<div class="flcontent">$f->{content}</div>
</div>
__FLOOR__

    return $ft;
} ## end sub format_floor

sub format_after_floor {
    my ( $self, $toc ) = @_;

    return "</div></body></html>";
}

no Moo;
1;
