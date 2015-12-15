#!/bin/bash

#Create variables
#What are the keys to encrypt with 
key=KEYNAME

echo -n "Filename: "
read fname 

#The actual command
gpg --output $fname.1 --encrypt  --recipient $key $fname
mv $fname.1 $fname
