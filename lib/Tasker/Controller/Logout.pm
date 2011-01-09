package Tasker::Controller::Logout;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Tasker::Controller::Logout - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller, that handles logout for Tasker

=head1 METHODS

index

=cut


=head2 index 

Log user out

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    if ($c->user){
        $c->logout();
        $c->flash->{message} = 'Вы вышли из системы';
    } 
    $c->res->redirect( '/login' );
}


=head1 AUTHOR

Ilya A. Chesnokov

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
