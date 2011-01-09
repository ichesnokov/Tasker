package Tasker::Schema::Result::UserRoles;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "UTF8Columns", "Core");
__PACKAGE__->table("user_roles");
__PACKAGE__->add_columns(
  "user_id",
  { data_type => "INT", default_value => 0, is_nullable => 0, size => 11 },
  "role_id",
  { data_type => "INT", default_value => 0, is_nullable => 0, size => 11 },
);
__PACKAGE__->set_primary_key("user_id", "role_id");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-07-15 00:27:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1ISjXDD2mchXHy1Dn0dmHA

__PACKAGE__->belongs_to( 'role' => 'Tasker::Schema::Result::Roles', 'role_id' );
__PACKAGE__->belongs_to( 'user' => 'Tasker::Schema::Result::Users', 'user_id' );

# You can replace this text with custom content, and it will be preserved on regeneration
1;
