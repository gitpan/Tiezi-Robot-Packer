#ABSTRACT: 贴子打包引擎
package  Tiezi::Robot::Packer;

our $VERSION = 0.07;

sub new {
    my ( $self, %opt ) = @_;
    $opt{type} ||= 'html';
    my $module = "Tiezi::Robot::Packer::$opt{type}";
    eval "require $module;";
    bless { %opt }, $module;
}

sub filter_skip_floors {
    my ($self, $tz) = @_;
    my @new_floors = grep { ! $_->{skip} } @{$tz->{floors}};
    $tz->{floors} = \@new_floors;
}

1;
