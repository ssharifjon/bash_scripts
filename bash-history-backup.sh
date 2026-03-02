#!/bin/bash

# creates a backup of ~/.bash_history 
# places it in ~/history_backups/ directory
# names it after the date that the commands were executed on
# in YYMMDD format

	

HISTORY_FILE="$HOME/.bash_history"
BACKUP_DIR="$HOME/history_backups"
log_file="$BACKUP_DIR/naming"
previous_date="$(<$log_file)"
current_date=$(date +"%y%m%d")

if [ $previous_date != $current_date ]; then		
	cp $HISTORY_FILE $BACKUP_DIR/$previous_date	
	truncate -s 0 $HISTORY_FILE			
	echo $current_date > $log_file			
fi


