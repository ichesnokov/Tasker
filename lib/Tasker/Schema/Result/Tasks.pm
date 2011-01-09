package Tasker::Schema::Result::Tasks;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "UTF8Columns", "Core");
__PACKAGE__->table("tasks");
__PACKAGE__->add_columns(
  "id",
  { data_type => "BIGINT", default_value => undef, is_nullable => 0, size => 20 },
  "description",
  {
    data_type => "LONGTEXT",
    default_value => undef,
    is_nullable => 1,
    size => 4294967295,
  },
  "creator_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "owner_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "created",
  {
    data_type => "TIMESTAMP",
    default_value => "CURRENT_TIMESTAMP",
    is_nullable => 0,
    size => 14,
  },
  "updated",
  {
    data_type => "TIMESTAMP",
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
    size => 14,
  },
  "subject",
  {
    data_type => "LONGTEXT",
    default_value => "",
    is_nullable => 0,
    size => 4294967295,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("id", ["id"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-07-15 00:27:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Ha+b6zsYxvq9qQLpMFWgkw

__PACKAGE__->utf8_columns( qw/ subject description / );
#
__PACKAGE__->has_many( 'comments' => 'Tasker::Schema::Result::Comments', 'task_id' );
#
__PACKAGE__->belongs_to( 'owner' => 'Tasker::Schema::Result::Users', 'owner_id' );
__PACKAGE__->belongs_to( 'creator' => 'Tasker::Schema::Result::Users', 'creator_id' );

# You can replace this text with custom content, and it will be preserved on regeneration
1;
