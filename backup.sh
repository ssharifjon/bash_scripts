#!/bin/bash

set -euo pipefail
card=$(lsblk -ln -o NAME,RM,TYPE | awk '$2=="1" && $3=="part" {print $1}' | head -n 1)
mounted=$(lsblk -ln -o NAME,RM,TYPE,MOUNTPOINTS | awk '$2=="1" && $3=="part" {print $4}' | head -n 1)
if [[ -n "$card" ]]; then
	echo "Found removable partition: $card"
	mkdir -p "$HOME/pendrive"

	if [[ -z "$mounted" ]]; then
		sudo mount "/dev/$card" "$HOME/pendrive"
		echo "Mount successful."
	fi

	echo "Copying files..."
	sudo rsync -ah --delete --delete-excluded --force --no-relative --exclude-from="$HOME/.local/bin/excludes" \
		"$HOME/" "$HOME/pendrive/home_backup/"
	sudo rsync -ah --delete --force \
		"/usr/local/src" "$HOME/pendrive/"
	echo "Backup complete!"

	read -p "Eject? [Y/n] " answer
	if [[ "$answer" =~ ^[Yy]$ ]]; then
		sudo umount "/dev/$card"
		echo "You can safely remove your pendrive!"
	fi

else
	echo "No removable partition found."
	exit 1
fi

