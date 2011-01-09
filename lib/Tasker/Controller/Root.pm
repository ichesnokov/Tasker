package Tasker::Controller::Root;

use strict;
use warnings;
use parent 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

=head1 NAME

Tasker::Controller::Root - Root Controller for Tasker

=head1 DESCRIPTION

Root controller for Tasker

=head1 METHODS

=cut

# Called for all actions
sub auto :Private {
    my ( $self, $c ) = @_;
    if ($c->controller eq $c->controller('Login')) {
        return 1;
    }
    if ( !$c->user_exists ) {
        $c->res->redirect( '/login' ); #require login
        return 0;
    }
    return 1;
}

=head2 index

Redirect to /tasks/my

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->res->redirect( $c->uri_for( 'tasks', 'my'  ) );
    $c->detach;
}

=head2 default

"Not found" page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->status(404);
    $c->stash->{template} = 'notfound.tt2';
}

=head2 end

Attempt to render a view, if needed.

=cut 

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Ilya A. Chesnokov

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
