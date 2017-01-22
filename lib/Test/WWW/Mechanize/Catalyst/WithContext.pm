package Test::WWW::Mechanize::Catalyst::WithContext;
use 5.008001;
use Moose;
use HTTP::Request;
use Carp 'croak';

require Catalyst::Test;
extends 'Test::WWW::Mechanize::Catalyst';

our $VERSION = "0.01";


# this stores the ctx_request function as a code reference
has _get_context => (
    is      => 'ro',
    isa     => 'CodeRef',
    lazy    => 1,
    builder => '_build__get_context',
);

sub _build__get_context {
    my ($self) = @_;

    # we need $request for ctx_request
    my $request = Catalyst::Test::_build_request_export(
        undef,    # this is C::T's $self
        { class => $self->{catalyst_app}, remote => $ENV{CATALYST_SERVER} }
    );

    return Catalyst::Test::_build_ctx_request_export(
        undef,    # this is C::T's $self
        {
            class   => $self->{catalyst_app},
            request => $request,
        }
    );
}

sub get_context {
    my ( $self, $url ) = @_;

    croak 'url is required' unless $url;

    my $request = HTTP::Request->new( GET => URI->new_abs( $url, $self->base ) );
    $self->cookie_jar->add_cookie_header($request);

    my ( $res, $c ) = $self->_get_context->($request);

    return $res, $c;
}

1;
__END__

=encoding utf-8

=head1 NAME

Test::WWW::Mechanize::Catalyst::WithContext - T::W::M::C can give you $c

=head1 SYNOPSIS

    use Test::WWW::Mechanize::Catalyst::WithContext;

    my $mech = Test::WWW::Mechanize::Catalyst::WithContext->new( catalyst_app => 'Catty' );

    my ($res, $c) = $mech->get_context("/"); # $c is a Catalyst context
    is $c->stash->{foo}, "bar", "foo got set to bar";

    $mech->post_ok("login", { u => "test", p => "secret" });
    my ($res, $c) = $mech->get_context("/");
    is $c->session->{stuff}, "something", "things are in the session";

=head1 DESCRIPTION

Test::WWW::Mechanize::Catalyst::WithContext is a subclass of L<Test::WWW::Mechanize::Catalyst>
that can give you the C<$c> context object of the request you just did. This is useful for
testing if things ended up in the stash correctly, if the session got filled without reaching
into the persistention layer or to grab an instance of a model, view or controller to do tests
on them. Since the cookie jar of your C<$mech> will be used to fetch the context, things
like being logged into your app will be taken into account.

=head1 METHODS

=head2 get_context($url)

Does a GET request on C<$url> and returns the L<HTTP::Response> and the request context C<$c>.

    my ( $res, $c ) = $mech->get_context('/');
    
=head1 LICENSE

Copyright (C) simbabque.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

simbabque <simbabque@cpan.org>
