#!/usr/bin/perl

use 5.14;
use warnings;
use strict;
use autodie qw(:all);

use Readonly;

use Test::More;
use Test::File;
use Test::Command::Simple;

Readonly my $CMD => './moirai';

Readonly my $TTL_DB_FILE => $ENV{HOME} . '/.moirai';
    # Redeclaring is part of the test, but not ultimately safe
Readonly my $TDF_BACKUP => $TTL_DB_FILE . '.testbak';

Readonly my @TESTENTRIES => (
    ['

# Get the a possibly present database file out of the way
my $have_removed_tdf = 0;
if (-e $TTL_DB_FILE) {
    rename $TTL_DB_FILE, $TDF_BACKUP;
    $have_removed_tdf = 1;
}

# Make sure there is no database file now
file_not_exists_ok($TTL_DB_FILE, 'ttl db not yet present');

# Add an entry to the database
run($CMD, 'lachesis',


done_testing(0);

# Restore the old database file if it was moved out of the way
if ($have_removed_tdf) {
    rename $TDF_BACKUP, $TTL_DB_FILE;
}
