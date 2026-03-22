#!/bin/bash

# creates a backup of ~/.bash_history 
# places it in ~/history_backups/ directory
# names it after the date that the commands were executed on
# in yymmdd format
# also compares disk usage of / 

pd=$(<$HOME/history_backups/naming)
td=$(date +"%y%m%d")
s1=$HOME/daily_scans/$pd
s2=$HOME/daily_scans/$td

if [ $pd != $td ]; then		
	cp $HOME/.bash_history $HOME/history_backups/$pd	
	sed -i '/^ls\($\| \)/{ /|/!d }' $HOME/history_backups/$pd
	truncate -s 0 $HOME/.bash_history

	sudo du --exclude=/{var,proc,sys,dev,run,tmp,nix,home/ss/daily_scans,home/ss/history_backups,home/ss/.cache,home/ss/.config/librewolf} -aS / > $s2
	diff -u $s1 $s2 > $HOME/daily_scans/d_$pd
	rm -rf $s1

	echo $td > $HOME/history_backups/naming

fi
