requires 'perl', '5.008001';
requires 'Catalyst';
requires 'HTTP::Request';
requires 'Moose';
requires 'Test::WWW::Mechanize::Catalyst';

on 'test' => sub {
    requires 'Test::More', '0.98';
    requires 'Test::Exception';
};

