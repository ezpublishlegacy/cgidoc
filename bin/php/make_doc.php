#!/usr/bin/env php
<?php
/**
 * File containing the module view
 *
 * @version 1.0.1-LS
 * @package CGIDoc
 * @copyright Copyright (C) 2012-2015 CGI Digital Factory. All rights reserved.
 * @license http://www.gnu.org/licenses/gpl-2.0.html GNU General Public License v2.0
 */
require 'autoload.php';

$cli = eZCLI::instance();
$tpl = eZTemplate::factory();
$script = eZScript::instance( array(
    'description' => ( "Generate an retro documentation" .
                       "\n" .
                       "make_doc.php" ),
    'use-session' => true,
    'use-modules' => true,
    'use-extensions' => true )
);

$script->startup();
$options = $script->getOptions( "[classes][roles][output-file:][footprint][timestamp]",
                                "",
                                array( 'classes' => 'Make an eZ classes documentation',
                                       'roles' => 'Make a eZ roles documentation',
                                       'output-file' => 'Output file for documentation',
                                       'footprint' => 'Display classes footprint',
                                       'timestamp' => 'Display date of generation in title' ) );
$sys = eZSys::instance();
$script->initialize();


// Help
if( !$options['output-file'] && !$options['footprint'] )
{
    $script->showHelp();
    $script->shutdown();
    exit();
}


// Control
if ( $options['classes'] )
{
    $doc = 'classes';
    $title = "eZ classes documentation";
    $classes = array();
    $groups = eZContentClassGroup::fetchList();
    foreach ( $groups as $group)
    {
        $groupName = $group->attribute( 'name' );
        $groupID = $group->attribute( 'id' );
        $classes[$groupName] = eZContentClassClassGroup::fetchClassList( 0, $groupID, $asObject = true );
    }
    $groups = null;
    $tpl->setVariable( 'classes', $classes );
}
elseif ( $options['roles'] )
{
    $doc = 'roles';
    $title = "eZ roles documentation";
    $roles = eZRole::fetchList();
    $tpl->setVariable( 'roles', $roles );
}
else
{
    $cli->error( "\n\n" . 'You must choose between classes and roles' . "\n\n" );
    $script->showHelp();
    $script->shutdown();
    exit();
}


// timestamp
if ( $options['timestamp'] )
{
    $date = new eZDateTime();
    $title = $title . ' (' . $date->toString() . ')';
}


// Make doc
$output = $tpl-> fetch( 'design:make_doc/' . $doc . '/full.tpl' );
$footprint = md5( $output );


// Footprint
if( $options['footprint'] )
{
    $cli->output( $footprint );
    $script->shutdown();
}
// Write
elseif( $options['output-file'] )
{
    $output = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head><title>' . $title . '</title><meta http-equiv="content-type" content="text/html; charset=utf-8" /></head>
<body>
    <h1 style="text-align: center">' . $title . '</h1>
    <p><span style="color:#485255; font-weight:bold;">MD5 Footprint:</span> <span style="color:#1A41A8;">'.$footprint.'</span></p>'
    . $output .'
</body>
</html>';

    file_put_contents( $options['output-file'], $output );
    $cli->output( 'Write ' . $options['output-file'] );
    $script->shutdown();
}

?>