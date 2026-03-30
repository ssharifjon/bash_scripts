#!/bin/bash

option=$(echo -e "power off\nreboot\ndo nothing" | dmenu -l 3 -c)
if [ "$option" = "power off" ]; then
	sudo shutdown now
elif [ "$option" = "reboot" ]; then
	sudo reboot
fi
