#!/bin/bash

# provided by the vendor
# change as needed
INSTALL_ID=1234

# can be 'live' or 'test'
SYSTEM=live 

PROGRAM_DIR=/usr/local/$SYSTEM

# This assumes that there are no sub-directories.
PROGRAM_DIR_FILE_LIST=$(find -type f $PROGRAM_DIR)
INSTALLER_STAGE_LOCATION=/usr/local/installer/stage/intstaller_$INSTALL_ID/
INSTALLER_STAGE_FILE_LIST=$(find -type f $INSTALLER_STAGE_LOCATION)
UNINSTALL_BACKUP_LOCATION=/usr/local/installer/uninstall_$INSTALL_ID/

# determine which files will be over-written and move them out of the way

for $program in PROGRAM_DIR_FILE_LIST
do
   for $installer_dir_program in INSTALLER_STAGE_FILE_LIST
   do 
      if [ $program == $installer_dir_program ]
      then
         mv $program $UNINSTALL_BACKUP_LOCATION
        
         # check to see if the file was moved successfully by checking the exit code for mv
         if [ $? -ne 0 ]
         then
            echo "Unable to move $program.  Check if the program is open or has a file lock on it."
            exit -1
         fi
      fi
   done
done

# install the new programs once the old programs are out of the way

for $installer_dir_program in INSTALLER_STAGE_FILE_LIST
do
   cp $installer_dir_program $PROGRAM_DIR
   if [ $? -ne 0 ]
   then
      echo "Unable to copy $installer_dir_program. Check if there is a file lock on the program."
      exit -1 
   fi
done

if [ $? -eq 0 ]
then 
   echo "Install operation completed for $INSTALL_ID"
else
   echo "Install operation completed with errors"
fi

            

