package Tiezi::Robot::Packer::html;
use strict;
use warnings;
use utf8;

use base 'Tiezi::Robot::Packer';
use Template;

sub suffix {
    'html';
}

sub main {
    my ($self, $tz, %opt) = @_;
    $self->filter_skip_floors($tz);
    $self->process_template($tz, %opt);
    return $opt{output};
}


sub process_template {
    my ($self, $tz, %opt) = @_;

    my $toc = $opt{with_toc} ? qq{<div id="toc"><ul>
    [% FOREACH r IN floors %]
    <li>[% r.id %]# <a href="#toc[% r.id %]">[% r.title %] [% r.time %]  [% r.name %]</a></li>
    [% END %]
    </ul>
    </div>} : '';

    my $txt =<<__HTML__;
        <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
        <html>

        <head>
        <title> [% topic.name %] 《 [% topic.title %] 》</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8">
        <style type="text/css">
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
        </style>
        </head>

        <body>
        <div id="title"><a href="[% topic.url %]">[% topic.name %] 《 [% topic.title %] 》</a></div>
        $toc
<div id="content">
    [% FOREACH r IN floors %]
<div class="floor">
<div class="fltitle">[% r.id %]# <a name="toc[% r.id %]">[% r.title %] [% r.time %]  [% r.name %]</a></div>
<div class="flcontent">[% r.content %]</div>
</div>
    [% END %]
</div>
</body>
</html>
__HTML__
    my $tt=Template->new();
    $tt->process(\$txt, $tz, $opt{output}, { binmode => ':utf8' })  || die $tt->error(), "\n";
}

1;
