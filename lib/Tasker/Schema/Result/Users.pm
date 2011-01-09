package Tasker::Schema::Result::Users;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "UTF8Columns", "Core");
__PACKAGE__->table("users");
__PACKAGE__->add_columns(
  "id",
  { data_type => "BIGINT", default_value => undef, is_nullable => 0, size => 20 },
  "username",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
  "password",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
  "email_address",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
  "first_name",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
  "last_name",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("id", ["id"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-07-15 00:27:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:dPubDU6PpJoU+jiD6k4Cqg

__PACKAGE__->utf8_columns( qw/ username password first_name last_name / );
#
__PACKAGE__->has_many( 'user_roles' => 'Tasker::Schema::Result::UserRoles', 'user_id');
__PACKAGE__->many_to_many( 'roles' => 'user_roles', 'role' );
#
__PACKAGE__->has_many( 'tasks_created' => 'Tasker::Schema::Result::Tasks', 'creator_id' );
__PACKAGE__->has_many( 'tasks_owned' => 'Tasker::Schema::Result::Tasks', 'owner_id' );
#
__PACKAGE__->has_many( 'comments' => 'Tasker::Schema::Result::Comments', 'commentator_id' );

# You can replace this text with custom content, and it will be preserved on regeneration
1;
