package Catty::Controller::Root;

use strict;
use warnings;
use base qw/ Catalyst::Controller /;

use utf8;

__PACKAGE__->config( namespace => '' );

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    my $html = html( "Root", "This is the root page" );

    $c->stash->{foo} = "bar";

    $c->response->content_type("text/html");
    $c->response->output($html);
}

# borrowed from Test::WWW::Catalyst::Mechanize
sub html {
    my ( $title, $body ) = @_;
    return qq{
<html>
<head><title>$title</title></head>
<body>
$body
<a href="/hello/">Hello</a>.
</body></html>
};
}

1;

