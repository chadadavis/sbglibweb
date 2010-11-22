package acaweb::Model::acamodel;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

use SBG::U::DB qw/dsn/;

my $database = __PACKAGE__->config->{'database'} || 'aca';
my $host = __PACKAGE__->config->{'host'};
my $dsn = "dbi:mysql:dbname=${database};host=${host};user='%'";

__PACKAGE__->config(
    schema_class => 'acaschema',
    connect_info => [ $dsn ],
);

=head1 NAME

acaweb::Model::acamodel - Catalyst DBIC Schema Model
=head1 SYNOPSIS

See L<acaweb>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<acaschema>

=head1 AUTHOR

Chad Davis

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
