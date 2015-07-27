#!/bin/bash
#Purpose: Disable useraccount and save home data

# Make sure we are root
if [ `id | sed -e 's/(.*//'` != "uid=0" ]; then
  echo "Sorry, you need super user privileges to run this script."
  exit 1
fi

#Set variables
#Archive filename
Fname=$1.tar
#Directory's (comma seperated)
CUDirs="/exp,/exp2,/roaming,/home,/old_homes"
#Random password
CUPass=`tr -dc A-Za-z0-9_ < /dev/urandom | head -c32` 

#Create empty tar file
tar cfT $1.tar /dev/null

#Directory's (comma seperated)
CUDirs="/exp,/exp2,/roaming,/home,/old_homes"

#Check what directory's exist
IFS=','
for i in $CUDirs
 do
  if [ -d $i\/$1 ]
   then tar -rf $Fname $i\/$1 #Non verbose
   #then tar -rvf $Fname $i\/$1 #Verbose
  fi
done

#TO BE IMPLEMENTED REMOVE THE DIRS AFTER ARCHIVING

#Change the users password to a random one
echo $1:$CUPass | chpasswd

#Disable the useraccount
usermod -L $1

echo "The new random password for $1 is $CUPass"
