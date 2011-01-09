package Tasker::Schema::Result::Comments;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "UTF8Columns", "Core");
__PACKAGE__->table("comments");
__PACKAGE__->add_columns(
  "id",
  { data_type => "BIGINT", default_value => undef, is_nullable => 0, size => 20 },
  "task_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "commentator_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "created",
  {
    data_type => "TIMESTAMP",
    default_value => "CURRENT_TIMESTAMP",
    is_nullable => 0,
    size => 14,
  },
  "comment_text",
  {
    data_type => "LONGTEXT",
    default_value => undef,
    is_nullable => 1,
    size => 4294967295,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("id", ["id"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-07-15 00:27:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tbPubItjebhr03vw84x6Kg

__PACKAGE__->utf8_columns( qw/ comment_text / );
#
__PACKAGE__->belongs_to( 'task' => 'Tasker::Schema::Result::Tasks', 'task_id' );
__PACKAGE__->belongs_to( 'commentator' => 'Tasker::Schema::Result::Users', 'commentator_id' );

# You can replace this text with custom content, and it will be preserved on regeneration
1;
