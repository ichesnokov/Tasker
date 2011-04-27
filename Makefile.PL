# IMPORTANT: if you delete this file your app will not work as
# expected.  you have been warned
use inc::Module::Install;

name 'Tasker';
all_from 'lib/Tasker.pm';

requires 'Catalyst::Runtime' => '5.7014';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'parent';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
#Additional dependencies
requires (
    'Catalyst::Plugin::Authentication' => '0',
    'Catalyst::Plugin::Authorization::Roles' => '0',
    'Catalyst::Plugin::Session' => '0',
    'Catalyst::Plugin::Session::Store::FastMmap' => '0',
    'Catalyst::Plugin::Session::State::Cookie' => '0',


    'HTML::FormFu' => '0',
    'Catalyst::Plugin::Unicode' => '0',
    'Catalyst::Controller::HTML::FormFu' => '0',
    'HTML::FormFu::Model::DBIC' => '0',
    'Template::Stash::ForceUTF8' => '0',
    'DBIx::Class::UTF8Columns' => '0',
);

catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
