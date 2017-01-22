package Test::WWW::Mechanize::Catalyst::WithContext;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";



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

=head1 LICENSE

Copyright (C) simbabque.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

simbabque <simbabque@cpan.org>
