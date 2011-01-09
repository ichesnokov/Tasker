use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Tasker' }
BEGIN { use_ok 'Tasker::Controller::Tasks' }

ok( request('/tasks')->is_success, 'Request should succeed' );


