#--------------------------------------------------
#!/bin/bash
#
# Custom script to connect to the VPN Server
#
# by l.biemans@uvt.nl
#
# Changelog
#
#
#--------------------------------------------------
#
# Script Variables
#
#--------------------------------------------------

vpnhost=VPNSERVERNAME
filename=$0

#-------------------------------------------------
#
# check_client()
# Checks if the vpn client is installed
#
#-------------------------------------------------
check_client() {
if [ ! -e /opt/cisco/anyconnect/bin/vpn ];
 then echo "You don't have the Cisco AnnyConnect client installed. Please install it first"
  else connect_vpn
fi
}

#-------------------------------------------------
#
# connect_vpn()
# Connect to the VPN Server
#
#-------------------------------------------------
connect_vpn() {
/opt/cisco/anyconnect/bin/vpn -s connect $vpnhost
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
    *)
        echo "Usage: {connect|disconnect}" >&2

        exit 1
        ;;
esac


exit 0
#/opt/cisco/anyconnect/bin/vpn -s connect
