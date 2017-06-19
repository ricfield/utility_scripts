#!/bin/bash

# A script to synchcronize an update server with a local data store

SFTP_SERVER=$1
SFTP_SERVER_DIR=$2

LOCAL_UPDATE_CACHE_DIR=$3


# check for null command line parameters
if [ -z $SFTP_SERVER || -z $SFTP_SERVER_DIR || -z $LOCAL_UPDATE_CACHE_DIR ]
then
   echo "Usage: sync_with_update_server.sh <server hostname or IP address> <directory path on server>"
   echo "       <local installer cache directory>"
   echo ""
   echo "A trailing front slash (/) must be used in this program for all directories."
   exit -1
fi


# Check input for errors
if [ $(echo -n $SFTP_SERVER_DIR | tail -c 1) != "/" ]
then
   echo "Error: server hostname directory path missing a trailing slash."
   exit -2 

elif [ $(echo -n $LOCAL_UPDATE_CACHE_DIR | tail -c 1) != "/" ]
then 
   echo "Error: local installer cache directory path missing a trailing slash."
   exit -3
   
# if all is good, run the synchronization process
else
   rsync -avt --progress $SFTP_SERVER:$SFTP_SERVER_DIR $LOCAL_UPDATE_CACHE_DIR
fi

# check if synchronization process ran sucessfully
if [ $? -eq 0 ]
then
   echo "Update synchronization process completed normally"
else
   echo "Synchronization process completed with errors"
fi



