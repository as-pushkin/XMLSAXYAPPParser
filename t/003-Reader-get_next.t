#!/usr/bin/perl -Iblib/lib -Iblib/arch -I../blib/lib -I../blib/arch
# 
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 003-Reader-get_next.t'

# Test file created outside of h2xs framework.
# Run this like so: `perl 003-Reader-get_next.t'
#   Andrei Pratasavitski <andrei.pratasavitski@booking.com>     2009/10/25 21:53:55

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests =>
    1                   # use_ok
    + 1                 # from string
    + 1                 # from file
;
BEGIN {
    use_ok( XML::SAX::YAPPParser::Reader );
}

# string
my $source = qq|<a><b c="d"><e>fgh</e>
<i /></b></a>|;
my $reader_s = XML::SAX::YAPPParser::Reader->new($source);

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

my $result = [];
for ( my $next = $reader_s->get_next; defined $next; $next = $reader_s->get_next ) {
    push @$result, $next;
}
is_deeply($result, $test, "parse preparation with get_next (from string)");

# file
$source = \'t/testfile.xml';
my $reader_f = XML::SAX::YAPPParser::Reader->new($source);
$test = [
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

$result = [];
for ( my $next = $reader_f->get_next; defined $next; $next = $reader_f->get_next ) {
    push @$result, $next;
}
is_deeply($result, $test, "parse preparation with get_next (from file)");

1;

#########################

# Insert your test code below, the Test::More module is used here so read
# its man page ( perldoc Test::More ) for help writing this test script.


