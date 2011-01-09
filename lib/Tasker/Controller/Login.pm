package Tasker::Controller::Login;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Tasker::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller, that handles logins for Tasker

=head1 METHODS

index

=cut


=head2 index 

Print form and handle login for Tasker

=cut

sub index :Path Args(0) {
    my ( $self, $c ) = @_;

    # Get username and password from submitted values
    my $username = $c->req->params->{login};
    my $password = $c->req->params->{password};

    if ( $username && $password ){

        # Try to authenticate user
        if ( $c->authenticate( { username => $username,
                                 password => $password } ) ) {

            # If authentication succeedes, tell user about it
            $c->flash->{message} = 'You logged in as ' . $c->user->get('username') . '<br />';

            # And redirect user to his tasks
            $c->res->redirect( '/tasks/my' );
            $c->detach;
        }
        else {

            # If authentication fails, tell user about it
            $c->flash->{message} = 'Wrong username or password';

            # Redirect back to login page
            $c->res->redirect( '/login ');
            $c->detach;
        }
    }
    $c->stash->{template} = 'login.tt2';
}


=head1 AUTHOR

Ilya A. Chesnokov

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
