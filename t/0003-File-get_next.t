#!/usr/bin/perl -Iblib/lib -Iblib/arch -I../blib/lib -I../blib/arch
# 
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 0003-File-get_next.t'

# Test file created outside of h2xs framework.
# Run this like so: `perl 0003-File-get_next.t'
#   Andrei Pratasavitski <andrei.pratasavitski@booking.com>     2009/10/25 20:42:05

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests =>
    1                   # use_ok
    + 1                 # preparsed substrings
;
BEGIN {
    use_ok( XML::SAX::YAPPParser::Reader::File );
}

my $source = 't/testfile.xml';
my $file = XML::SAX::YAPPParser::Reader::File->new($source);
my $test = [
    '<?xml version="1.0" encoding="utf-8"?>',
    '

<a>',
    '
  <b c="d">',
    '
    <e>',
    'fgh</e>',
    '
    <i />',
    '
  </b>',
    '
</a>',
    '
' # the last empty line
];

my $result;
for ( my $next = $file->get_next; defined $next; $next = $file->get_next ) {
    push @$result, $next;
}
is_deeply($result, $test, "parse preparation with get_next");


#########################

# Insert your test code below, the Test::More module is used here so read
# its man page ( perldoc Test::More ) for help writing this test script.


