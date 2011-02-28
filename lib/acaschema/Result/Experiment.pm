package acaschema::Result::Experiment;

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

acaschema::Result::Experiment

=cut

__PACKAGE__->table("experiment");

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

=head2 date

  data_type: 'datetime'
  is_nullable: 1

=head2 user

  data_type: 'varchar'
  is_nullable: 1
  size: 128

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
  "date",
  { data_type => "datetime", is_nullable => 1 },
  "user",
  { data_type => "varchar", is_nullable => 1, size => 128 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 targets

Type: has_many

Related object: L<acaschema::Result::Target>

=cut

__PACKAGE__->has_many(
  "targets",
  "acaschema::Result::Target",
  { "foreign.experiment_id" => "self.id" },
  {},
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-02-28 15:51:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:bXnRZk7WQhIvzUbt1REpwQ


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
