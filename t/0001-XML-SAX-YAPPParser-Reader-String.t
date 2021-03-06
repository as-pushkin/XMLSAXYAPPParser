#!/usr/bin/perl -Iblib/lib -Iblib/arch -I../blib/lib -I../blib/arch
# 
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 0001-XML-SAX-YAPPParser-Reader-String.t'

# Test file created outside of h2xs framework.
# Run this like so: `perl 0001-XML-SAX-YAPPParser-Reader-String.t'
#   Andrei Pratasavitski <andrei.pratasavitski@booking.com>     2009/10/10 09:33:11

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 1;
BEGIN { use_ok( XML::SAX::YAPPParser::Reader::String ); }

#########################

# Insert your test code below, the Test::More module is used here so read
# its man page ( perldoc Test::More ) for help writing this test script.


