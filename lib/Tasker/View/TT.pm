package Tasker::View::TT;

use strict;
use base 'Catalyst::View::TT';
use Template::Stash::ForceUTF8;

__PACKAGE__->config(
    INCLUDE_PATH => [
        Tasker->path_to( 'root', 'src' ),
    ],
    TEMPLATE_EXTENSION => '.tt2',
    WRAPPER => 'wrapper.tt2',
    ENCODING => 'UTF-8',
    STASH => Template::Stash::ForceUTF8->new,
);

=head1 NAME

Tasker::View::TT - TT View for Tasker

=head1 DESCRIPTION

TT View for Tasker. 

=head1 AUTHOR

Ilya A. Chesnokov

=head1 SEE ALSO

L<Tasker>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
