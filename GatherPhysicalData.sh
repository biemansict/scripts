#!/bin/bash

#Check if all packages are there and if not install them
if [ $(dpkg-query -W -f='${Status}' dmidecode 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get --force-yes --yes install dmidecode;
fi

if [ $(dpkg-query -W -f='${Status}' gawk 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get --force-yes --yes install gawk;
fi

if [ $(dpkg-query -W -f='${Status}' lsb-release 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get --force-yes --yes install lsb-release;
fi

#Generate questions
echo -n "Rack:"
read rno 

echo -n "Jaar van aanschaf:"
read yopurchase

echo -n "Servicecontract:"
read scontract

echo -n "Servicecontract nummer:"
read scontractno

echo -n "Servicecontract telefoonnummer:"
read scontractpnr

echo -n "Servicecontract einddatum:"
read scontractend

echo -n "Laatste service verzoek:"
read lastreq

echo -n "Project:"
read project

echo -n "Doel:"
read purpose

echo -n "Primaire gebruikers:"
read pusers

echo -n "Overige DNS entry's:"
read edns

echo -n "Management interface name (eg iDRAC):"
read mintn

echo -n "Management interface mac:"
read mintm

echo -n "Management interface IP:"
read minti

echo -n "Back-up mappen:"
read bupm

echo -n "Back-up schema:"
read bups

echo -n "Bijzonder geinstalleerde software:"
read spkg

echo -n "Bijzondere configuraties:"
read scnf

echo -n "Commentaar:"
read comments


#Check if the questions are answered
if [ -z "$rno" ]; then
     rno=-
fi

if [ -z "$yopurchase" ]; then
     yopurchase=-
fi

if [ -z "$scontract" ]; then
     scontract=-
fi

if [ -z "$scontractno" ]; then
     scontractno=-
fi

if [ -z "$scontractpnr" ]; then
     scontractpnr=-
fi

if [ -z "$scontractend" ]; then
     scontractend=-
fi

if [ -z "$lastreq" ]; then
     lastreq=-
fi

if [ -z "$project" ]; then
     project=-
fi

if [ -z "$purpose" ]; then
     purpose=-
fi

if [ -z "$pusers" ]; then
     pusers=-
fi

if [ -z "$edns" ]; then
     edns=-
fi

if [ -z "$mintn" ]; then
     mintn=-
fi

if [ -z "$mintm" ]; then
     mintm=-
fi

if [ -z "$minti" ]; then
     minti=-
fi

if [ -z "$bupm" ]; then
     bupm=-
fi

if [ -z "$bups" ]; then
     bups=-
fi

if [ -z "$spkg" ]; then
     spkg=-
fi

if [ -z "$scnf" ]; then
     scnf=-
fi

if [ -z "$comments" ]; then
     comments=-
fi

#Create variables
filename=`hostname`.txt

#Build output
echo "|Servernaam (primaire DNS):|`hostname -f`|" >>$filename
echo "|Racknummer:|$rno|" >>$filename
echo "|Server Type:|`dmidecode | grep -A3 'System Information' | grep "Product Name" | sed "s/Product Name: //g"`|" >>$filename
echo "|Jaar van aanschaf:|$yopurchase|" >>$filename
echo "|Service Tag:|`dmidecode|grep "Serial Number" | sed -e '2,$d' -e 's/Serial Number: //g'`|" >>$filename
echo "|Servicecontract:|$scontract|" >>$filename
echo "|Servicecontractnummer:|$scontractno|" >>$filename
echo "|Servicecontract telefoonnummer:|$scontractpnr|" >>$filename
echo "|Einddatum servicecontract:|$scontractend|" >>$filename
echo "|Laatste service verzoek:|$lastreq|" >>$filename
echo "|Project:|$project|" >>$filename
echo "|Doel:|$purpose|" >>$filename
echo "|OS:|`lsb_release -d | cut -f2`|" >>$filename
echo "|Laatste update / upgrade:|`stat -c %y /var/log/apt/history.log | awk -F '.' '{print $1}'`|" >>$filename
echo "|Primaire gebruiker(s):|$pusers|" >>$filename
echo "|Overige DNS entry's:|$edns|" >>$filename
echo "|Interfaces:|`ip a | grep link/ | wc -l`|" >>$filename
echo "|Management interface naam:|$mintn|" >>$filename
echo "|Interface mac:|$mintm|" >>$filename
echo "|Interface IP:|$minti|" >>$filename
echo "`ip a | grep -e lo -e bond -e br -e eth -e vlan -e link/ether -e inet | awk -F '<' '{print $1}' | awk -F 'brd' '{print $1}' | awk -F 'inet6' '{print $1}' | sed 's/link\/ether/|Interface mac:|/g' | sed 's/link\/loopback/|Loopback Interface mac:|/g' | sed 's/inet/|IP Address:|/g'|  sed 's/[0-9]: /|Interface Name:|/'| sed 's/[0-9]|/|/' | sed '/^\s*$/d' | sed 's/    //g' | sed 's/$/|/'`"
echo "|RAM:|`free -h | gawk  '/Mem:/{print $2}'`|" >>$filename
echo "|Aantal CPU's:|`lscpu | grep 'Socket' | sed 's/Socket(s):             //g'`|" >>$filename
echo "|Aantal cores per CPU|`lscpu | grep 'socket'  | sed 's/Core(s) per socket:    //g'`|" >>$filename
echo "|Aantal threats:|`nproc`|" >>$filename
echo "|Back-up mappen:|$bupm|" >>$filename
echo "|Back-up schema:|$bups|" >>$filename
echo "|Bijzondere geinstalleerde software:|$spkg|" >>$filename
echo "|Bijzondere configuraties:|$scnf|" >>$filename
echo "|Commentaar:|$comments|" >>$filename
