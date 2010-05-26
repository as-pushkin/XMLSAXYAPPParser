#!/usr/bin/perl -Iblib/lib -Iblib/arch -I../blib/lib -I../blib/arch
# 
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 0003-String-get_next.t'

# Test file created outside of h2xs framework.
# Run this like so: `perl 0003-String-get_next.t'
#   Andrei Pratasavitski <andrei.pratasavitski@booking.com>     2009/10/25 17:03:08

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests =>
    1                   # use_ok
    + 1                 # preparsed substrings
    ;

BEGIN {
    use_ok( XML::SAX::YAPPParser::Reader::String );
}

my $source = qq|<a><b c="d"><e>fgh</e>
<i /></b></a>|;
my $string = XML::SAX::YAPPParser::Reader::String->new($source);

my $test = [
    '<a>',
    '<b c="d">',
    '<e>',
    'fgh</e>',
    '
<i />',
    '</b>',
    '</a>'
];

my $result;
for ( my $next = $string->get_next; defined $next; $next = $string->get_next ) {
    push @$result, $next;
}
is_deeply($result, $test, "parse preparation with get_next");

1;

#########################

# Insert your test code below, the Test::More module is used here so read
# its man page ( perldoc Test::More ) for help writing this test script.


