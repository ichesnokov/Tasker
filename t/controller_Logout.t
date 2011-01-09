use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Tasker' }
BEGIN { use_ok 'Tasker::Controller::Logout' }

ok( request('/logout')->is_success, 'Request should succeed' );


