#!/bin/bash

echo "Have you installed XCode and Sublime Text? (y/n)"
read userInstallResponse

source installOtherApps.sh

if [ $userInstallResponse == "y" ] 
	then
	echo "sudo if you please"
	[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"
	ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/bin/subl 
fi
