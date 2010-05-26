#!/usr/bin/perl -Iblib/lib -Iblib/arch -I../blib/lib -I../blib/arch
# 
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 002-Reader-source-accessors.t'

# Test file created outside of h2xs framework.
# Run this like so: `perl 002-Reader-source-accessors.t'
#   Andrei Pratasavitski <andrei.pratasavitski@booking.com>     2009/10/24 12:14:46

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests =>
    1                   # use_ok
    # set via setter
    + 2                 # empty
    + 3                 # string
    + 3                 # files
    # set via constructor
    + 3                 # empty
    + 3 + 3             # string
    + 3 + 3             # files
    ;

BEGIN {
    use_ok( XML::SAX::YAPPParser::Reader );
}

# set source via setter

# empty
my $r_empty1 = XML::SAX::YAPPParser::Reader->new(); # empty string
$r_empty1->set_source('');
is(ref($r_empty1->get_source()), 'XML::SAX::YAPPParser::Reader::Empty', "empty string should return XML::SAX::YAPPParser::Reader::Empty");
my $r_empty2 = XML::SAX::YAPPParser::Reader->new(); # undef
$r_empty2->set_source();
is(ref($r_empty2->get_source()), 'XML::SAX::YAPPParser::Reader::Empty', "undef should return XML::SAX::YAPPParser::Reader::Empty");

# string
if ( -f './0') {
    unlink './0'; # make sure file 0 does not exists
}
my $r_0 = XML::SAX::YAPPParser::Reader->new(); # string 0
$r_0->set_source(0);
is(ref($r_0->get_source()), 'XML::SAX::YAPPParser::Reader::String', '0 should be considered as string');
my $r_stringref = XML::SAX::YAPPParser::Reader->new(); # stringref
$r_stringref->set_source('123');
is(ref($r_stringref->get_source()), 'XML::SAX::YAPPParser::Reader::String', 'string source');
my $r_string = XML::SAX::YAPPParser::Reader->new(); # string
$r_string->set_source(\'123');
is(ref($r_string->get_source()), 'XML::SAX::YAPPParser::Reader::String', 'string ref source');

# file
open($file0, ">", "0");
print $file0 '<tag hello="world" />';
close $file0;
my $r_file0 = XML::SAX::YAPPParser::Reader->new(); # filename is '0'
$r_file0->set_source('0');
is(ref($r_file0->get_source()), 'XML::SAX::YAPPParser::Reader::File', 'file source when filename is "0"');

my $filename = __FILE__;
my $r_filename = XML::SAX::YAPPParser::Reader->new(); # filename
$r_filename->set_source($filename);
is(ref($r_filename->get_source()), 'XML::SAX::YAPPParser::Reader::File', 'file source');

my $r_filenameref = XML::SAX::YAPPParser::Reader->new(); # filename as stringref
$r_filenameref->set_source(\$filename);
is(ref($r_filenameref->get_source()), 'XML::SAX::YAPPParser::Reader::File', 'file source as stringref');

unlink './0';

# set source via constructor

# empty
my $r_empty1 = XML::SAX::YAPPParser::Reader->new(source => ''); # empty string
is(ref($r_empty1->get_source()), 'XML::SAX::YAPPParser::Reader::Empty', "empty string should return XML::SAX::YAPPParser::Reader::Empty");
my $r_empty2 = XML::SAX::YAPPParser::Reader->new(source => undef); # undef
is(ref($r_empty2->get_source()), 'XML::SAX::YAPPParser::Reader::Empty', "undef should return XML::SAX::YAPPParser::Reader::Empty");
my $r_empty3 = XML::SAX::YAPPParser::Reader->new(''); # empty string
is(ref($r_empty3->get_source()), 'XML::SAX::YAPPParser::Reader::Empty', "empty string should return XML::SAX::YAPPParser::Reader::Empty");


# string
if ( -f './0') {
    unlink './0'; # make sure file 0 does not exists
}
my $r_0 = XML::SAX::YAPPParser::Reader->new(source => 0); # string 0
is(ref($r_0->get_source()), 'XML::SAX::YAPPParser::Reader::String', '0 should be considered as string');
my $r_stringref = XML::SAX::YAPPParser::Reader->new(source => '123'); # stringref
is(ref($r_stringref->get_source()), 'XML::SAX::YAPPParser::Reader::String', 'string source');
my $r_string = XML::SAX::YAPPParser::Reader->new(source => \'123'); # string
is(ref($r_string->get_source()), 'XML::SAX::YAPPParser::Reader::String', 'string ref source');
# string is the only parameter
my $ro_0 = XML::SAX::YAPPParser::Reader->new(0); # string 0
is(ref($ro_0->get_source()), 'XML::SAX::YAPPParser::Reader::String', '0 should be considered as string');
my $ro_stringref = XML::SAX::YAPPParser::Reader->new('123'); # stringref
is(ref($ro_stringref->get_source()), 'XML::SAX::YAPPParser::Reader::String', 'string source');
my $ro_string = XML::SAX::YAPPParser::Reader->new(\'123'); # string
is(ref($ro_string->get_source()), 'XML::SAX::YAPPParser::Reader::String', 'string ref source');

# file
open($file0, ">", "0");
print $file0 '<tag hello="world" />';
close $file0;
my $r_file0 = XML::SAX::YAPPParser::Reader->new(source => 0); # filename is '0'
is(ref($r_file0->get_source()), 'XML::SAX::YAPPParser::Reader::File', 'file source when filename is "0"');

my $filename = __FILE__;
my $r_filename = XML::SAX::YAPPParser::Reader->new(source => $filename); # filename
is(ref($r_filename->get_source()), 'XML::SAX::YAPPParser::Reader::File', 'file source');

my $r_filenameref = XML::SAX::YAPPParser::Reader->new(source => \$filename); # filename as stringref
is(ref($r_filenameref->get_source()), 'XML::SAX::YAPPParser::Reader::File', 'file source as stringref');

# file is the only parameter
my $r_file0 = XML::SAX::YAPPParser::Reader->new(0); # filename is '0'
is(ref($r_file0->get_source()), 'XML::SAX::YAPPParser::Reader::File', 'file source when filename is "0"');

my $filename = __FILE__;
my $r_filename = XML::SAX::YAPPParser::Reader->new($filename); # filename
is(ref($r_filename->get_source()), 'XML::SAX::YAPPParser::Reader::File', 'file source');

my $r_filenameref = XML::SAX::YAPPParser::Reader->new(\$filename); # filename as stringref
is(ref($r_filenameref->get_source()), 'XML::SAX::YAPPParser::Reader::File', 'file source as stringref');

unlink './0';

# warning
$r_string->set_source("Another string");


#########################

# Insert your test code below, the Test::More module is used here so read
# its man page ( perldoc Test::More ) for help writing this test script.


