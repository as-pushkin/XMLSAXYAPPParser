#!/usr/bin/perl -Iblib/lib -Iblib/arch -I../blib/lib -I../blib/arch
# 
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 0002-String-source-accessors.t'

# Test file created outside of h2xs framework.
# Run this like so: `perl 0002-String-source-accessors.t'
#   Andrei Pratasavitski <andrei.pratasavitski@booking.com>     2009/10/25 13:18:22

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests =>
    1                   # use_ok
    + 1                 # set via setter
    + 2                 # set via constructor
    ;
BEGIN {
    use_ok( XML::SAX::YAPPParser::Reader::String );
}

my $source = qq|<a><b c="d"><e>fgh</e><i /></b></a>|;
my $string_s = XML::SAX::YAPPParser::Reader::String->new();
$string_s->set_source($source);
is($string_s->get_source(), $source, "set via setter");

my $string_c1 = XML::SAX::YAPPParser::Reader::String->new(source => $source);
is($string_c1->get_source(), $source, "set via constructor");

my $string_c2 = XML::SAX::YAPPParser::Reader::String->new($source);
is($string_c2->get_source(), $source, "set via constructor (one arg)");

# warning
$string_s->set_source("");

#########################

# Insert your test code below, the Test::More module is used here so read
# its man page ( perldoc Test::More ) for help writing this test script.


