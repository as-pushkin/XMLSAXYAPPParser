#!/usr/bin/perl -Iblib/lib -Iblib/arch -I../blib/lib -I../blib/arch
# 
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 0002-File-source-accessors.t'

# Test file created outside of h2xs framework.
# Run this like so: `perl 0002-File-source-accessors.t'
#   Andrei Pratasavitski <andrei.pratasavitski@booking.com>     2009/10/25 19:49:04

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests =>
    1                   # use_ok
    + 1                 # set via setter
    + 2                 # set via constructor
    ;
BEGIN {
    use_ok( XML::SAX::YAPPParser::Reader::File );
}

use Data::Dumper;

my $file = 't/testfile.xml';
my $file_s = XML::SAX::YAPPParser::Reader::File->new();
$file_s->set_source($file);
print Dumper($file_s);
is($file_s->get_source()->[0], $file, "set via setter");
$file_s->DESTROY;

my $file_c1 = XML::SAX::YAPPParser::Reader::File->new(source => $file);
print Dumper($file_c1);
is($file_c1->get_source()->[0], $file, "set via constructor");
$file_c1->DESTROY;

my $file1 = 't/testfile1.xml';
my $file_c2 = XML::SAX::YAPPParser::Reader::File->new($file1);
print Dumper($file_c2);
is($file_c2->get_source()->[0], $file1, "set via constructor (one arg and another file)");
$file_c2->DESTROY;

# warning
$file_s->set_source("");

#########################

# Insert your test code below, the Test::More module is used here so read
# its man page ( perldoc Test::More ) for help writing this test script.


