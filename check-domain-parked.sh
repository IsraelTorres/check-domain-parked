#!/bin/bash
# Israel Torres
# 20170524
# check-domain-parked.sh
# checks if a domain is parked
#
DomainName="$1"
if [[ -z "$DomainName" ]]
    then
    echo -en "usage:\tcheck-domain-parked.sh Domain_Name\n"
exit 1
else
    tURL=$(UUIDGEN)
    tChk=$(curl -s --location "$DomainName/$tURL" | head -c 60)
    genIP=$(dig "$DomainName" +noall +answer \
    | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' \
    | tail -n 1
    )
    cUrl=$(curl -s "$genIP" | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]'\
    | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//'
    )

echo -en "DN:\t$DomainName\n"
echo -en "IP:\t$genIP\n"
echo -en "URL:\t$cUrl\n"
echo -en "Chk:\t$tChk\n"
fi
#
#EOF