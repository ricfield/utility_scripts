#!/bin/bash

# Trailing slashes are needed for rsync.
PROD_LOCATION=/var/system/prod/
TEST_LOCATION=/var/system/test/

TEST_INDEX_DIRECTORY=$TEST_LOCATION/indices
PROD_REFERENCE=$PROD_LOCATION/data
TEST_REFERENCE=$TEST_LOCATION/data

TEST_CONFIGURATION_FILENAME=$TEST_LOCATION/config
TEST_CONFIGURATION_FILES_BACKUP_DIRECTORY=/var/system/test.backup.configuration.files

RSYNC_PARAMETERS="-av --progress"

HISTORY_FILE_ONE=$TEST_LOCATION/data/h1.dat
HISTORY_FILE_ONE_BACKUP_NAME=$TEST_LOCATION/h1.dat.bak
HISTORY_FILE_TWO=$TEST_LOCATION/h2.dat
HISTORY_FILE_TWO_BACKUP_NAME=$TEST_LOCATION/h2.dat.bak

$SYSTEM_INDEX_COMMAND= # This will be defined later.


# Move the system configuration file out of the way before we bulldoze it.
mv $TEST_CONFIGURATION_FILENAME $TEST_CONFIGURATION_FILES_BACKUP_DIRECTORY

# Synchronize TEST data with PROD data. Get some lunch.  This will take a while.
rsync $RSYNC_PARAMETERS $PROD_LOCATION $TEST_LOCATION

# Rename some old files in case they are needed later.
mv $HISTORY_FILE_ONE $HISTORY_FILE_ONE_BACKUP_NAME
mv $HISTORY_FILE_TWO $HISTORY_FILE_TWO_BACKUP_NAME

# Find any index files and replace any references from PROD to TEST/
find $TEST_INDEX_DIRECTORY -name "*.ind" -exec sed -i.bak 's/$PROD_REFERENCE/$TEST_REFERENCE/g' {} /;
find $TEST_INDEX_DIRECTORY -name "*.ind2" -exec sed -i.bak 's/$PROD_REFERENCE/$TEST_REFERENCE/g' {} /;

# Index the system from the command line

$SYSTEM_INDEX_COMMAND
