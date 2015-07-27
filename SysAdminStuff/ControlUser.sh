#!/bin/bash
#Purpose: Disable useraccount and save home data

#Set the archive filename
Fname=$1.tar

#Create empty tar file
tar cfT $1.tar /dev/null

#Directory's (comma seperated)
CUDirs="/exp,/exp2,/roaming,/home,/old_homes"

#Check what directory's exist
IFS=','
for i in $CUDirs
 do
  if [ -d $i\/$1 ]
   then tar -rvf $Fname $i\/$1
  fi
done

#Change the users password to a random one
echo $1:`tr -dc A-Za-z0-9_ < /dev/urandom | head -c32` | chpasswd

#Disable the useraccount
usermod -L $1
