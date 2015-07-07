#!/bin/bash
#Set variables
OLDRELEASE=`lsb_release -c | cut -f2`
RELEASE=jessie

#Make sure screen is installed
if [ $(dpkg-query -W -f='${Status}' screen 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get --force-yes --yes install screen
fi

# Make sure we are root
if [ `id | sed -e 's/(.*//'` != "uid=0" ]; then
  echo "Sorry, you need super user privileges to run this script."
  exit 1
fi

#Make sure we are inside a screen session
if echo $STY | grep pts
 then echo "Nice we are inside a screen session"
   else echo "Please run this script from a screen session"
	exit 1
fi

#Change /etc/apt/sources.list
sed -i 's/$OLDRELEASE/$RELEASE/g' /etc/apt/sources.list

#Update sources
apt-get -y update

#Upgrade the system
apt-get -y upgrade
