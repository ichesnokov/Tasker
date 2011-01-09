package Tasker::Controller::Tasks;

use strict;
use warnings;
use utf8;
#use parent 'Catalyst::Controller';
use parent 'Catalyst::Controller::HTML::FormFu';

=head1 NAME

Tasker::Controller::Tasks - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller, for doing task management.

=head1 METHODS

index, create, delete, all, my, view

=cut


=head2 index 

Index page - shows all tasks, assigned to current user.

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    # Just redirect user to his tasks
    $c->res->redirect( $c->uri_for($self->action_for('my')));
    $c->detach;
}

=head2 create

Opens page for creating new task

=cut

sub create :Local FormConfig {
    my ( $self, $c ) = @_;

    # Get HTML::FormFu form
    my $form = $c->stash->{form};
    if ($form->submitted_and_valid) {
        # Create new task object
        my $task = $c->model('TaskerDB::Tasks')->new_result({});
        # Update model with submitted values
        $form->model->update($task);
        # Notify user
        $c->flash->{message} = 'Задание добавлено';
        # Redirect usre to his tasks
        $c->res->redirect( '/tasks/my' );
        $c->detach();
    }
    else {
        # Fill owners
        my @owner_objs = $c->model('TaskerDB::Users')->all();
        my @owners;
        foreach ( sort { $a->id cmp $b->id } @owner_objs ) {
            push @owners,[ $_->id, $_->username ];
        }
        # Fill possible owners
        my $select = $form->get_element( { type => 'Select' } );
        $select->options(\@owners);
        # Fill creator's id
        my $creator_id_field = $form->get_element( { type=>'Hidden', name=>'creator_id' } );
        $creator_id_field->value( $c->user->get('id') );
        # Fill creator
        my $creator_name_field = $form->get_element( { type=>'Text', name=>'creator_name' } );
        $creator_name_field->value( $c->user->get('username') );
    }

    $c->stash->{template} = 'tasks/create.tt2';
}

=head2 all

Show all tasks in the database

=cut

sub all :Local {
    my ( $self, $c ) = @_;
    # Get all tasks from model and put them to stash (unsorted)
    my @tasks = $c->model('TaskerDB::Tasks')->all();
    $c->stash->{tasks} = \@tasks;
    $c->stash->{template} = 'tasks/all.tt2';
}

=head2 my

Show tasks, which belongs to current user

=cut

sub my :Local {
    my ( $self, $c ) = @_;

    my @tasks = $c->model('TaskerDB::Tasks')->search({ owner_id=>$c->user->get('id') });
    $c->stash->{tasks} = \@tasks;
    $c->stash->{template} = 'tasks/my.tt2';
}

=head2 edit

View task details and add comments

=cut

sub view :Local Args(1) FormConfig {
    my ( $self, $c, $id ) = @_;
    
    # Get task object
    my $task = $c->model('TaskerDB::Tasks')->find( $id );

    # Fill some form fields
    my $form = $c->stash->{form};
    # Fill task_id
    my $task_id_field = $form->get_element({ name=>'task_id' });
    $task_id_field->value( $id );
    # Fill commentator_id
    my $commentator_field = $form->get_element({ name=>'commentator_id' });
    $commentator_field->value( $c->user->get('id') );

    # Update database if we are commenting the task
    if ( $form->submitted_and_valid ) {
        my $comment = $c->model('TaskerDB::Comments')->new_result({});
        $form->model->update($comment);
    }

    # Get comments for this task, if it exists
    if ($task) {
        # Sort comments by creation time
        my @comments = sort { $a->created cmp $b->created } $task->comments;
        $c->stash->{comments} = \@comments;
    }

    # Fill stash and render template
    $c->stash->{task} = $task;
    $c->stash->{template} = 'tasks/view.tt2';
}


=head2 delete

Delete task, if user has sufficient privileges

=cut

sub delete :Local Args(1) {
    my ( $self, $c, $id ) = @_;

    # Where will we go next?
    my $redirect_url;
    # Check user roles
    if ( $c->check_any_user_role( qw/ admin / ) ) {
        # If user has sufficient privileges, delete task from the database
        my $task_obj = $c->model('TaskerDB::Tasks')->find( $id );
        if ($task_obj) {
            $task_obj->delete;
            $c->flash->{message} = "Задание $id удалено";
        }
        else {
            $c->flash->{message} = "Нет задания с id=$id";
        }
        $redirect_url = ( $c->req->referer eq $c->uri_for( $self->action_for( 'all' ) ) ) ?
                          $c->req->referer :
                          $c->uri_for( $self->action_for( 'my' ) ) ;

        }
    else {
        $c->flash->{message} = "У вас недостаточно привилегий для удаления задания";
        $redirect_url = $c->req->referer;
    }

    # If task was deleted from "All tasks" page, remain here, else go to "My Tasks" page
    # Redirect user and detach
    $c->res->redirect( $redirect_url );
    $c->detach;
}

=head1 AUTHOR

Ilya A. Chesnokov

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
