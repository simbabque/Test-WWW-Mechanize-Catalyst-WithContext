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

isa_ok $mech->c, 'Catalyst', '$c';
isa_ok $mech->c, 'Catty',    '$c';

$mech->get_ok('/static/hello.txt');
is $mech->c, undef, 'handled by psgi';

done_testing;
