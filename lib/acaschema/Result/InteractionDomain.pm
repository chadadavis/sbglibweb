package acaschema::Result::InteractionDomain;

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

acaschema::Result::InteractionDomain

=cut

__PACKAGE__->table("interaction_domain");

=head1 ACCESSORS

=head2 interaction_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 domain_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 complex_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "interaction_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "domain_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "complex_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
);
__PACKAGE__->set_primary_key("interaction_id", "domain_id", "complex_id");

=head1 RELATIONS

=head2 domain

Type: belongs_to

Related object: L<acaschema::Result::Domain>

=cut

__PACKAGE__->belongs_to(
  "domain",
  "acaschema::Result::Domain",
  { complex_id => "complex_id", id => "domain_id" },
);

=head2 interaction_id

Type: belongs_to

Related object: L<acaschema::Result::Interaction>

=cut

__PACKAGE__->belongs_to(
  "interaction_id",
  "acaschema::Result::Interaction",
  { id => "interaction_id" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-02-28 15:51:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:rxtgTFnWQd4zf7hmtGOwzg


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
