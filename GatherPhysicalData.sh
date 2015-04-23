#!/bin/bash

#Generate questions
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

#Build output
echo "|Servernaam (primaire DNS):|`hostname -f`|"
echo "|Server Type:|`sudo dmidecode | grep -A3 'System Information' | grep "Product Name" | sed "s/Product Name: //g"`|"
echo "|Jaar van aanschaf:|$yopurchase|"
echo "|Service Tag:|`sudo dmidecode|grep "Serial Number" | sed -e '2,$d' -e 's/Serial Number: //g'`|"
echo "|Servicecontract:|$scontract|"
echo "|Servicecontractnummer:|$scontractno|"
echo "|Servicecontract telefoonnummer:|$scontractpnr|"
echo "|Einddatum servicecontract:|$scontractend|"
echo "|Laatste service verzoek:|$lastreq|"
echo "|Project:|$project|"
echo "|Doel:|$purpose|"
echo "|OS:|`lsb_release -d | cut -f2`|"
echo "|Laatste update / upgrade:|`stat -c %y /var/log/apt/history.log | awk -F '.' '{print $1}'`|"
echo "|Primaire gebruiker(s):|$pusers|"
echo "|Overige DNS entry's:|$edns|"
echo "|Interfaces:|`ip a | grep link/ | wc -l`|"
echo "|Management interface naam:|$mintn|"
echo "|Interface mac:|$mintm|"
echo "|Interface IP:|$minti|"
echo "`ip a | grep -e lo -e bond -e br -e eth -e vlan -e link/ether -e inet | awk -F '<' '{print $1}' | awk -F 'brd' '{print $1}' | awk -F 'inet6' '{print $1}' | sed 's/link\/ether/|Interface mac:|/g' | sed 's/link\/loopback/|Loopback Interface mac:|/g' | sed 's/inet/|IP Address:|/g'|  sed 's/[0-9]: /|Interface Name:|/'| sed 's/[0-9]|/|/' | sed '/^\s*$/d' | sed 's/    //g' | sed 's/$/|/'`"
echo "|RAM:|`free -h | gawk  '/Mem:/{print $2}'`|"
echo "|Aantal CPU's:|`lscpu | grep 'Socket' | sed 's/Socket(s):             //g'`|"
echo "|Aantal cores per CPU|`lscpu | grep 'socket'  | sed 's/Core(s) per socket:    //g'`|"
echo "|Aantal threats:|`nproc`|"
echo "|Back-up mappen:|$bupm|"
echo "|Back-up schema:|$bups|"
echo "|Bijzondere geinstalleerde software:|$spkg|"
echo "|Bijzondere configuraties:|$scnf|"
echo "|Commentaar:|$comments|"
