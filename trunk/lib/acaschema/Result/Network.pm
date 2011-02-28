package acaschema::Result::Network;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

acaschema::Result::Network

=cut

__PACKAGE__->table("network");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 target_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 partition

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 nnodes

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 ninteractions

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 nedges

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "target_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "partition",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "nnodes",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "ninteractions",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "nedges",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id", "target_id");

=head1 RELATIONS

=head2 complexes

Type: has_many

Related object: L<acaschema::Result::Complex>

=cut

__PACKAGE__->has_many(
  "complexes",
  "acaschema::Result::Complex",
  { "foreign.network_id" => "self.id" },
  {},
);

=head2 target_id

Type: belongs_to

Related object: L<acaschema::Result::Target>

=cut

__PACKAGE__->belongs_to(
  "target_id",
  "acaschema::Result::Target",
  { id => "target_id" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-02-28 15:51:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:GiTSWcwuLQAwnKUdPJzp1w


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
