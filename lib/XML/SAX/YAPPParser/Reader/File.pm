package XML::SAX::YAPPParser::Reader::File;

use strict; 
use warnings;

use Carp;

our $VERSION = '0.01';

# constructor
sub new {
    my $class = shift;
    
    my $self = {
        separator => '>',
    };
    bless($self, $class);
    $self->_init(@_);
    return $self;
}

sub DESTROY {

    my $self = shift;

    my $filehandle = $self->{FILE};
    close $filehandle;
}

# initialize object
sub _init {

    my $self = shift;

    if ( @_ == 1 ) { # only one param provided
        $self->set_source($_[0]);
    }
    elsif (@_) {
        my %params = @_;

        $self->set_source(delete $params{source});
        @$self{keys %params} = values %params;
    }
}

# GENERAL ACCESSORS

# Source setters
sub set_source {

    my ($self, $source) = @_;

    if ( $self->{source} ) {
        carp
        #croak
            "Source is already set!";
    }
    else {
        if ( defined $source ) {
            $self->{source} = $source;
            my $filehandle;
            open($filehandle, '<', $source) or croak "Cannot open file $source: $!";
            $self->{FILE} = $filehandle;
        }
    }
    return;
}

# Source getter
sub get_source {

    my $self = shift;
    return [ $self->{source}, $self->{FILE} ];
}

# Gets next portion of text to parse
sub get_next {

    my $self = shift;
    local $/ = $self->{separator};
    my $filehandle = $self->{FILE};
    return eof($filehandle) ? undef : <$filehandle>;
}

1;
__END__

=head1 NAME

XML::SAX::YAPPParser::Reader::File - Perl extension for blah blah blah

=head1 SYNOPSIS

   use XML::SAX::YAPPParser::Reader::File;
   blah blah blah

=head1 DESCRIPTION

Stub documentation for XML::SAX::YAPPParser::Reader::File, 

Blah blah blah.

=head2 EXPORT

None by default.

=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Andrei Pratasavitski, E<lt>andrei.pratasavitski@booking.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Andrei Pratasavitski

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.2 or,
at your option, any later version of Perl 5 you may have available.

=head1 BUGS

None reported... yet.

=cut
