package acaschema::Result::Domain;

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

acaschema::Result::Domain

=cut

__PACKAGE__->table("domain");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 complex_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=head2 acc

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 template

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0 },
  "complex_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "acc",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "template",
  { data_type => "varchar", is_nullable => 1, size => 45 },
);
__PACKAGE__->set_primary_key("id", "complex_id");

=head1 RELATIONS

=head2 complex_id

Type: belongs_to

Related object: L<acaschema::Result::Complex>

=cut

__PACKAGE__->belongs_to(
  "complex_id",
  "acaschema::Result::Complex",
  { id => "complex_id" },
);

=head2 interaction_domains

Type: has_many

Related object: L<acaschema::Result::InteractionDomain>

=cut

__PACKAGE__->has_many(
  "interaction_domains",
  "acaschema::Result::InteractionDomain",
  {
    "foreign.complex_id" => "self.complex_id",
    "foreign.domain_id"  => "self.id",
  },
  {},
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-02-28 15:51:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:QmcalEtaaEzN2kn8S3VwHg


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
