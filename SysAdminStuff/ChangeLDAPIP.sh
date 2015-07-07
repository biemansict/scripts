#!/bin/bash
#Set variables
OLDLDAP=<OLDLDAPIP>
NEWLDAP=<NEWLDAPIP>

#Make sure sudo-ldap is installed
if [ $(dpkg-query -W -f='${Status}' sudo-ldap 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get --force-yes --yes install sudo-ldap
fi

# Make sure we are root
if [ `id | sed -e 's/(.*//'` != "uid=0" ]; then
  echo "Sorry, you need super user privileges to run this script."
  exit 1
fi

#Change /etc/libnss-ldap.conf
sed -i 's/$OLDLDAP/$NEWLDAP/g' /etc/libnss-ldap.conf

#Change /etc/pam_ldap.conf
sed -i 's/$OLDLDAP/$NEWLDAP/g' /etc/pam_ldap.conf

#Change /etc/ldap/ldap.conf
sed -i 's/$OLDLDAP/$NEWLDAP/g' /etc/ldap/ldap.conf

#Check if sudo_ldap is configured
if cat /etc/ldap/ldap.conf | grep sudoers_base
 then echo "Nice sudo-ldap is already configured"
  else echo "sudoers_base ou=<SUDOERSOU>,dc=<EXAMPLE>,dc=<COM>" >>/etc/ldap/ldap.conf
fi
