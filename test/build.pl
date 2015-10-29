#!/usr/bin/perl

########################################################################
# Copyright (C) 2015  yoku0825
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
########################################################################

use strict;
use warnings;
use Carp;
use FindBin qw/$Bin/;
use Getopt::Long qw/:config bundling no_ignore_case gnu_compat/;
use Test::More;
use Test::More::Color "foreground";
use DBI;

### parse option.
my $opt= {quiet           => 1,
          no_cache        => 0,
          no_drop         => 0,
          build_directory => "$Bin/../Dockerfile",
          docker_command  => "docker",
          tag             => undef,
          version_json    => "$Bin/version.json"};

while (my $optstr= shift)
{
  if ($optstr eq "--no-cache")
  {
    $opt->{no_cache}= 1;
  }
  elsif ($optstr eq "-v")
  {
    $opt->{quiet}= 0;
  }
  elsif ($optstr eq "--no-drop")
  {
    $opt->{no_drop}= 1;
  }
  elsif ($optstr eq "--sudo")
  {
    $opt->{docker_command}= "sudo " . $opt->{docker_command};
  }
  elsif ($optstr eq "--tag")
  {
    $opt->{tag}= shift;
  }
  elsif ($optstr eq "--help" || $optstr eq "-h")
  {
    &usage();
  }
  else
  {
    die("invalid argument");
  }
}


if ($opt->{tag})
{
  test_one_dockerfile($opt->{build_directory} . "/" . $opt->{tag});
}
else
{
  foreach my $build_dir (glob $opt->{build_directory} . "/*")
  {
    test_one_dockerfile($build_dir);
  }
}

done_testing();


sub usage
{
  print << "EOF";
$0 [options]
  options:
    -h, --help   Display this message.
    -v           Verbose. Display "docker build"'s output into stdout.
    --no-cache   Don't use cache in "docker build" 
    --no-drop    Don't cleanup images created by this script.
    --sudo       Use "sudo" for "docker" command.
EOF
  exit 0;
}


sub test_one_dockerfile
{
  my ($build_dir)= @_;

  subtest "Build and Test $build_dir" => sub
  {
    ok(my $docker= Test::Mroonga->new($opt, $build_dir), "Building image from $build_dir");
    is($docker->author, "groonga", "MAINTAINER should be set 'groonga'");
    ok($docker->run, "Starting container and get ipaddr");
    ok($docker->connect_mysql, "Connecting MySQL in container");
    ok($docker->show_plugins, "SHOW PLUGINS");
    is_deeply($docker->show_version, $docker->{version}, "Compare version from directory name");
    ok($docker->create_table, "CREATE TABLES without warning");
  };
}

package Test::Mroonga;

use JSON;

sub new
{
  my ($class, $opt, $build_dir)= @_;
  my $self= {build_dir => $build_dir,
             tag       => undef,
             opt       => $opt,
             container => {id      => undef,
                           ipaddr  => undef},
             conn      => undef,
             version   => {mysql   => undef,
                           groonga => undef,
                           mroonga => undef}};
  bless $self => $class;

  $build_dir =~ /(?<tag>mysql\d+_mroonga\d+)$/;
  $self->{tag}               = $+{tag};
  $self->read_version_from_json;

  ### Make an image
  return 0 unless $self->build;

  return $self;
}


sub build
{
  my ($self)= @_;
  my $docker_build_command= sprintf("%s build %s -t %s %s %s",
                                    $self->{opt}->{docker_command},
                                    $self->{opt}->{no_cache} ? "--no-cache " : "",
                                    $self->{tag},
                                    $self->{build_dir},
                                    $self->{opt}->{quiet} ? " > /dev/null " : "");
  my $rc= system($docker_build_command);
  return !($rc);
}


sub author
{
  my ($self)= @_;
  my $docker_inspect_command= sprintf("%s inspect -f '{{.Author}}' %s",
                                      $self->{opt}->{docker_command},
                                      $self->{tag});
  my $author= `$docker_inspect_command`;
  chomp($author);

  return $author;
}


sub run
{
  my ($self)= @_;
  my $docker_run_command= sprintf("%s run -d %s",
                                  $self->{opt}->{docker_command},
                                  $self->{tag});
  my $container_id= `$docker_run_command`;
  chomp($container_id);
  return 0 unless $container_id;

  my $docker_inspect_command= sprintf("%s inspect -f '{{.NetworkSettings.IPAddress}}' %s", 
                                      $self->{opt}->{docker_command},
                                      $container_id);
  my $container_ipaddr= `$docker_inspect_command`;
  chomp($container_ipaddr);
  return 0 unless $container_ipaddr;

  $self->{container}= {id => $container_id, ipaddr => $container_ipaddr};
}


sub read_version_from_json
{
  my ($self)= @_;

  open(my $fh, "< " . $self->{opt}->{version_json});
  my @line= <$fh>;
  close($fh);

  my $json= from_json(join("\n", @line));
  $self->{version}= $json->{$self->{tag}};
}


sub connect_mysql
{
  my ($self)= @_;
  my $dsn= sprintf("dbi:mysql:;host=%s",
                   $self->{container}->{ipaddr});

  my ($conn, $n);
  while ()
  {
    ### Wait for container is ready.
    sleep 2;

    eval
    {
      $conn= DBI->connect($dsn, "root", "");
    };

    if ($@)
    {
      if ($n++ > 3)
      {
        ### retry-out.
        return 0;
      }
    }
    else
    {
      last;
    }
  }

  $self->{conn}= $conn;
}


sub show_plugins
{
  my ($self)= @_;

  foreach (@{$self->{conn}->selectall_arrayref("SHOW PLUGINS", {Slice => {}})})
  {
    if ($_->{Name} eq "Mroonga")
    {
      return 1;
    }
  }

  return 0;
}


sub show_version
{
  my ($self) = @_;
  my $version= {};

  $version->{mysql}= $self->_get_variable("version");
  $version->{mysql}=~ s/[^0-9]//g;

  $version->{groonga}= $self->_get_variable("mroonga_libgroonga_version");
  $version->{groonga}=~ s/[^0-9]//g;

  $version->{mroonga}= $self->_get_variable("mroonga_version");
  $version->{mroonga}=~ s/[^0-9]//g;

  return $version;
}


sub _get_variable
{
  my ($self, $variable)= @_;

  my $row= $self->{conn}->selectrow_hashref("SHOW GLOBAL VARIABLES LIKE ?", undef, $variable);
  return $row->{Value};
}


sub create_table
{
  my ($self)= @_;

  Test::More::subtest "Running queries" => sub 
  {
    $self->_run_query("CREATE DATABASE test_mroonga");
    $self->_run_query("CREATE TABLE test_mroonga.test (num serial, val varchar(32)) Engine= Mroonga");
    $self->_run_query("ALTER TABLE test_mroonga.test ADD FULLTEXT KEY (val)");
    $self->_run_query("ALTER TABLE test_mroonga.test ADD FULLTEXT KEY (val) Comment 'parser \"TokenBigram\"'");
    $self->_run_query("ALTER TABLE test_mroonga.test ADD FULLTEXT KEY (val) Comment 'parser \"TokenMecab\"'");
    $self->_run_query("ALTER TABLE test_mroonga.test ADD FULLTEXT KEY (val) Comment 'normalizer \"NormalizerAuto\"'");
    $self->_run_query("ALTER TABLE test_mroonga.test ADD FULLTEXT KEY (val) Comment 'normalizer \"NormalizerMySQLUnicodeCIExceptKanaCIKanaWithVoicedSoundMark\"'");
  }
}


sub _run_query
{
  my ($self, $sql)= @_;

  Test::More::ok($self->{conn}->do($sql), $sql);
  Test::More::ok(!($self->{conn}->selectrow_hashref("SHOW WARNINGS")), "$sql has no warning");
}



sub DESTROY
{
  my ($self)= @_;

  ### remove container
  if ($self->{container}->{id})
  {
    my $docker_stop_command= sprintf("%s stop %s > /dev/null",
                                     $self->{opt}->{docker_command},
                                     $self->{container}->{id});
    system($docker_stop_command);

    my $docker_rm_command= sprintf("%s rm %s > /dev/null",
                                   $self->{opt}->{docker_command},
                                   $self->{container}->{id});
    system($docker_rm_command);
  }

  return 0 if $self->{opt}->{no_drop};

  ### remove image
  my $docker_rmi_command= sprintf("%s rmi %s > /dev/null",
                                  $self->{opt}->{docker_command},
                                  $self->{tag});
  system($docker_rmi_command);
}
