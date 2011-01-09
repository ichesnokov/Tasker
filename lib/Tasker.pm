package Tasker;

use strict;
use warnings;

use Catalyst::Runtime '5.70';

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root 
#                 directory

use parent qw/Catalyst/;
use Catalyst qw/-Debug
                StackTrace

                ConfigLoader
                Static::Simple

                Authentication
                Authorization::Roles

                Session
                Session::Store::FastMmap
                Session::State::Cookie

                Unicode
                /;

our $VERSION = '0.01';

# Configure the application. 
#
# Note that settings in tasker.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with a external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'Tasker',
    session => {flash_to_stash => 1}
    );
__PACKAGE__->config->{authentication} = {
    default_realm => 'users',
    realms => {
        users => {
            credential => {
                class => 'Password',
                password_field => 'password',
                password_type => 'clear'
            },
            store => {
                class => 'DBIx::Class',
                user_model => 'TaskerDB::Users',
                role_relation => 'roles',
                role_field => 'role',
            }
        }
    }
};

# Start the application
__PACKAGE__->setup();


=head1 NAME

Tasker - Catalyst based application

=head1 SYNOPSIS

    script/tasker_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<Tasker::Controller::Root>, L<Catalyst>

=head1 AUTHOR

root

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
