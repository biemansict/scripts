#!/bin/sh
#-------------------------------------------------
#
# getpubkey()
# Get your public key
#
#-------------------------------------------------
getpubkey() {

FILE=~/.ssh/id_rsa.pub

zenity --text-info \
       --title="License" \
       --filename=$FILE
}

#-------------------------------------------------
#
# connectserver()
# Create a SSH connection to the chosen server
#
#-------------------------------------------------
connectserver(){
server=`zenity --list \
  --title="Choose a server to connect to" \
  --column="Hostname" --column="IP" \
    white.uvt.nl 137.56.206.28 \
    black.uvt.nl 137.56.206.17 \
    red.uvt.nl 137.56.206.21 \
    yellow.uvt.nl 137.56.206.20`
ssh root@$server
}

#What do you wanna do
choice=`zenity --list \
  --title="What do you want to do?" \
  --column="#" --column="Option" \
    1 "Get your public key" \
    2 "SSH to a server"`

echo $choice

if [ $? -eq 1 ]
 then zenity --error \
--text="Oops you pressed Cancel"
fi

case $choice in
    1)
        getpubkey
        ;;
    2)
        connectserver
        ;;
    *)
	zenity --error \
--text="Oops you pressed Cancel"
esac
