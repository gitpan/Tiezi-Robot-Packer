
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "\x{8d34}\x{5b50}\x{6253}\x{5305}\x{5f15}\x{64ce}\r",
  "AUTHOR" => "abbypan <abbypan\@gmail.com>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Tiezi-Robot-Packer",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Tiezi::Robot::Packer",
  "PREREQ_PM" => {
    "HTML::FormatText" => 0,
    "HTML::TreeBuilder" => 0,
    "Template" => 0
  },
  "TEST_REQUIRES" => {},
  "VERSION" => "0.08",
  "test" => {
    "TESTS" => ""
  }
);


my %FallbackPrereqs = (
  "HTML::FormatText" => 0,
  "HTML::TreeBuilder" => 0,
  "Template" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



