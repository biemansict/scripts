#!/bin/bash

# Custom script to connect to the VPN Server

#--------------------------------------------------
#
# Script Variables
#
#--------------------------------------------------

vpnhost=vpn.uvt.nl
filename=$0
storedcred=n

#-------------------------------------------------
#
# store_credentials()
# Check wether or not the credentials are stored
#
#-------------------------------------------------
store_credentials() {
if [ $storedcred = NA ]
 then
  echo "Do you want to save your credentials?"
  echo "Answer y (for yes) or n (for no)"
  read screda
  sed -i "0,/storedcred=NA/s//storedcred=$screda/" $filename
  sh $filename connect
elif [ $storedcred = y ] && [ ! -e ~/.vcreds ]
 then
   echo "Please give me your credentials"
   echo "Username: "
   read username
   echo "Password: "
   read password
   echo $username > ~/.vcreds 
   echo $password >> ~/.vcreds
   chmod 600 ~/.vcreds
   connect_vpn
 else
  connect_vpn
fi
}

#-------------------------------------------------
#
# check_client()
# Checks if the vpn client is installed
#
#-------------------------------------------------
check_client() {
if [ ! -e /opt/cisco/anyconnect/bin/vpn ];
 then 
  echo "You don't have the Cisco AnnyConnect client installed. Please install it first"
  check_server
 else
  check_server
fi
}

#-------------------------------------------------
#
# check_server()
# Checks if the vpnhost variable is set
#
#-------------------------------------------------
check_server() {
if [ $vpnhost = VPNSERVERNAME ]
 then 
  echo "Please set the servername"
  echo "Servername: "
  read servername
  sed -i "0,/VPNSERVERNAME/s//$servername/" $filename
  store_credentials 
 else store_credentials
fi
}

#-------------------------------------------------
#
# connect_vpn()
# Connect to the VPN Server
#
#-------------------------------------------------
connect_vpn() {
if [ -e ~/.vcreds ];
 then
   /opt/cisco/anyconnect/bin/vpn -s connect $vpnhost < ~/.vcreds
  else
   /opt/cisco/anyconnect/bin/vpn -s connect $vpnhost
fi
}

#-------------------------------------------------
#
# disconnect_vpn()
# Connect to the VPN Server
#
#-------------------------------------------------
disconnect_vpn() {
/opt/cisco/anyconnect/bin/vpn -s disconnect
}

#-------------------------------------------------
#
# reset_all()
# Resets all values to default
#
#-------------------------------------------------
reset_all() {
sed -i "0,/storedcred=$storedcred/s//storedcred=NA/" $filename
sed -i "0,/$vpnhost/s//VPNSERVERNAME/" $filename
if [ -e ~/.vcreds ];
 then 
  rm ~/.vcreds
fi
}

#-------------------------------------------------
#
# Script parameters section
#
#-------------------------------------------------

case "$1" in
    connect)
	check_client
        ;;
    disconnect)
        disconnect_vpn
        ;;
    reset)
       reset_all
        ;;
    *)
        echo "Usage: {connect|disconnect|reset}" >&2
        exit 1
        ;;
esac


exit 0
