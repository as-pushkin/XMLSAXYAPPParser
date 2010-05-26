package XML::SAX::YAPPParser;

use strict; 
use warnings;

use XML::SAX::YAPPParser::Reader;

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

    my $source;
    if ( @_ == 1 ) { # only one param provided
        $source = shift;
    }
    elsif (@_) {
        my %params = @_;
        $source = delete $params{source};
        $self->{debug} = delete $params{debug};
        @$self{keys %params} = values %params;
    }
    $self->{reader} = XML::SAX::YAPPParser::Reader->new(source => $source);
    $self->{stack} = []; # Element stack
    $self->{context} = ['start']; # Context stack:
                                  # start, xml, comment, cdata, processing instructions, etc...
}


# Parse

sub parse {

    my $self = shift;

    while ( my $fragment = $self->{reader}->get_next() ) {
        $self->_DEBUG(">>>>> ", $self->_context, ":\n", $fragment, "\n");
        if ( $self->_context eq 'xml') {
        }
        elsif ( $self->_context eq 'start' ) {
            # event: start document
        }
    }
}


# print debug info
sub _DEBUG {

    my $self = shift;

    print @_ if $self->{debug};

}

# Fetches last context or put new
sub _context {

    my $self = shift;

    my $context = @{ $self->{context} }[ $#{ $self->{context} } ];

    if ( @_ ) {
        push @{ $self->{context} }, @_;
    }
    return $context;
}


1;
__END__

=head1 NAME

XML::SAX::YAPPParser - Perl extension for blah blah blah

=head1 SYNOPSIS

   use XML::SAX::YAPPParser;
   blah blah blah

=head1 DESCRIPTION

Stub documentation for XML::SAX::YAPPParser, 

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
