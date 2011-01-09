use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Tasker' }
BEGIN { use_ok 'Tasker::Controller::Login' }

ok( request('/login')->is_success, 'Request should succeed' );


