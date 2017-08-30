#!/bin/bash

# trailing slashes are needed for rsync
PROD_LOCATION=/var/prod/
TEST_LOCATION=/var/test/

TEST_CONFIG_FILENAME=/var/test/data/config
RSYNC_PARAMETERS="-av --progress"

rsync $RSYNC_PARAMETERS $PROD_LOCATION $TEST_LOCATION

# rsync
