package acaschema::Result::Complex;

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

acaschema::Result::Complex

=cut

__PACKAGE__->table("complex");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 model

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 network_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 score

  data_type: 'float'
  is_nullable: 1

=head2 nreplaced

  data_type: 'integer'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 path

  data_type: 'varchar'
  is_nullable: 1
  size: 1024

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "model",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "network_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "score",
  { data_type => "float", is_nullable => 1 },
  "nreplaced",
  {
    data_type => "integer",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "path",
  { data_type => "varchar", is_nullable => 1, size => 1024 },
);
__PACKAGE__->set_primary_key("id", "network_id");

=head1 RELATIONS

=head2 network_id

Type: belongs_to

Related object: L<acaschema::Result::Network>

=cut

__PACKAGE__->belongs_to(
  "network_id",
  "acaschema::Result::Network",
  { id => "network_id" },
);

=head2 domains

Type: has_many

Related object: L<acaschema::Result::Domain>

=cut

__PACKAGE__->has_many(
  "domains",
  "acaschema::Result::Domain",
  { "foreign.complex_id" => "self.id" },
  {},
);

=head2 interactions

Type: has_many

Related object: L<acaschema::Result::Interaction>

=cut

__PACKAGE__->has_many(
  "interactions",
  "acaschema::Result::Interaction",
  { "foreign.complex_id" => "self.id" },
  {},
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-02-28 15:51:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:GC3N21fXm5Ufg2nG6P0Pcw


# You can replace this text with custom content, and it will be preserved on regeneration

use File::Spec::Functions;

sub basedir {
	my ($self) = @_;
	my $net = $self->network_id;
	my $part = sprintf "%02d", $net->partition;
	my $target = $net->target_id;
	my $exp = $target->experiment_id;
	my $model = sprintf "%02d", $self->model;
	return catdir($exp->label, $target->label, $part, $model); 
}

1;


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
