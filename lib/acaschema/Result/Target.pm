package acaschema::Result::Target;

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

acaschema::Result::Target

=cut

__PACKAGE__->table("target");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 label

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=head2 description

  data_type: 'varchar'
  is_nullable: 1
  size: 1024

=head2 experiment_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 ndomains

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
  "label",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "description",
  { data_type => "varchar", is_nullable => 1, size => 1024 },
  "experiment_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "ndomains",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id", "experiment_id");

=head1 RELATIONS

=head2 networks

Type: has_many

Related object: L<acaschema::Result::Network>

=cut

__PACKAGE__->has_many(
  "networks",
  "acaschema::Result::Network",
  { "foreign.target_id" => "self.id" },
  {},
);

=head2 experiment_id

Type: belongs_to

Related object: L<acaschema::Result::Experiment>

=cut

__PACKAGE__->belongs_to(
  "experiment_id",
  "acaschema::Result::Experiment",
  { id => "experiment_id" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-02-28 15:51:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:JJAmRuFoIqKZ4AvHGyPfTw


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
