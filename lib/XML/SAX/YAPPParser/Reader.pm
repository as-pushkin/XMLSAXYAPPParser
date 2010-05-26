package XML::SAX::YAPPParser::Reader;

use strict; 
use warnings;

use Carp;

our $VERSION = '0.01';

# Constructor
sub new {
    my $class = shift;
    
    my $self = {  };
    bless($self, $class);
    $self->_init(@_);
    return $self;
}

# Initialize the object
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

# Source setter
sub set_source {

    my ($self, $source) = @_;
    if ( $self->{source} ) {
        carp
        #croak
            "Source is already set!";
    }
    else {
        if ( defined $source and $source ne '' ) {
            my $ref = ref $source;

            if ( $ref eq 'SCALAR' ) { # stringref with source or filename
                $source = $$source;
            }

            if ( $self->_is_filename($source) ) {
                require XML::SAX::YAPPParser::Reader::File;
                $self->{source} =  XML::SAX::YAPPParser::Reader::File->new(source => $source);
            } else {
                require XML::SAX::YAPPParser::Reader::String;
                $self->{source} = XML::SAX::YAPPParser::Reader::String->new(source => $source);
            }
        }
        else {
            $self->{source} = XML::SAX::YAPPParser::Reader::Empty->new();
        }
    }
    return;
}

# Determine if the string XML or filename
sub _is_filename { return if $_[1] =~ /\n/; return -f $_[1]; }

# Source getter
sub get_source {

    my $self = shift;
    return $self->{source};
}


# METHODS

# Gets next portion of text to parse
sub get_next {

    my $self = shift;

    return $self->{source}->get_next();
}

# if no data provided
package XML::SAX::YAPPParser::Reader::Empty;

sub new {
    my $classname = shift;
    
    my $self = {  };
    bless($self, $classname);
    return $self;
}

sub get_next { return; }

1;

__END__

=head1 NAME

XML::SAX::YAPPParser::Reader - Perl extension for blah blah blah

=head1 SYNOPSIS

   use XML::SAX::YAPPParser::Reader;
   blah blah blah

=head1 DESCRIPTION

Stub documentation for XML::SAX::YAPPParser::Reader, 

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
