package Tasker::Schema::Result::Roles;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "UTF8Columns", "Core");
__PACKAGE__->table("roles");
__PACKAGE__->add_columns(
  "id",
  { data_type => "BIGINT", default_value => undef, is_nullable => 0, size => 20 },
  "role",
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
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:S9c0BONDJgKlrT+VTGOLFw

#
__PACKAGE__->utf8_columns( qw/ role / );
#
__PACKAGE__->has_many( 'user_roles' => 'Tasker::Schema::Result::UserRoles', 'role_id' );
__PACKAGE__->many_to_many( 'users' => 'user_roles', 'user' );


# You can replace this text with custom content, and it will be preserved on regeneration
1;
