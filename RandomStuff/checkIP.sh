#!/bin/sh

############################################
#Script written by Lars Biemans            #
#Purpose check if the external IP is changed#
############################################

###########################################
#Check if the lastip control file is there#
###########################################

if [ -e /tmp/external_ip ]
 then echo "Got It" >/dev/null
  else
   echo "ehlo localhost" >/tmp/external_ip
    echo "mail from: fromuser@domain.tld" >>/tmp/external_ip
     echo "rcpt to: touser@domain.tld" >>/tmp/external_ip
      echo "data" >>/tmp/external_ip
       echo "subject: DUMMYDATA" >>/tmp/external_ip
        echo "DUMMYDATA" >>/tmp/external_ip
         echo "." >>/tmp/external_ip
fi
                                             
#####################
#Get the external IP#
#####################
                                     
wget http://checkip.dyndns.com/ 2>1 /dev/null
cat index.html | awk '{print $6}'|cut -d"<" -f1 >/tmp/current_ip
rm index.html
                                             
###############
#Set variables#
###############
                        
lastip=$(cat /tmp/external_ip | sed '1,5d' | sed '2d')
newip=$(cat /tmp/current_ip)

mail_from=fromuser@domain.tld
mail_to=touser@domain.tld 
                          
###################################
#Check if the ip is still the same#
###################################
if egrep $lastip /tmp/current_ip >/dev/null
 then echo "Got It" >/dev/null
  else
   echo "ehlo localhost" >/tmp/external_ip
    echo "mail from: $mail_from" >>/tmp/external_ip
     echo "rcpt to: $mail_to " >>/tmp/external_ip
      echo "data" >>/tmp/external_ip
       echo "subject: Your external IP" >>/tmp/external_ip
        echo "$newip" >>/tmp/external_ip
         echo "." >>/tmp/external_ip
          telnet 127.0.0.1 25 < /tmp/external_ip
fi
