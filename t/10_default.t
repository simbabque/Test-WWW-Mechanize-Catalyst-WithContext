use strict;
use warnings;
use Test::More;
use Test::Exception;

use lib 't/lib';

BEGIN {
    $ENV{CATALYST_DEBUG} = 0;
    $ENV{CATTY_DEBUG}    = 0;
}
use Test::WWW::Mechanize::Catalyst::WithContext 'Catty';

my $mech = Test::WWW::Mechanize::Catalyst::WithContext->new;
$mech->get_ok('/');

is ref( $mech->_get_context ), 'CODE', '_get_context is there';

dies_ok { $mech->get_context } 'url is required';

my ( $res, $c ) = $mech->get_context('/');
isa_ok $c, 'Catalyst', '$c';
isa_ok $c, 'Catty',    '$c';
is $c->stash->{foo}, 'bar', '... and the current stash is accessible';

my $model = $c->model('Foo');
isa_ok $model, 'Catty::Model::Foo';
is $model->general,          'general', 'general model attribute works';
is $model->context_specific, 'bar',     'attribute set by ACCEPT_CONTEXT works';

done_testing;
