#!/bin/bash
# A simple script to get a ppp connection over a serial line console
#
# A simple use case for this is connecting an old computer that cannot
# support a network card, but needs an Internet connection.


# Use Microsoft DNS
MS_DNS=Y

# DNS Server IP Address
MS_DNS_IP_ADDRESS=172.16.0.254

# Use CRTSCTS flow control
CRTSCTS=Y

# Proxy ARP requests
PROXY_ARP=Y

# Local and remote IP addresses
LOCAL_IP_ADDRESS=172.16.0.240
REMOTE_IP_ADDRESS=172.16.0.241


# Check for input errors

if [ $MS_DNS != "Y" ] && [ $MS_DNS != "N" ];
then
   echo "A Microsoft DNS option is required.  Aborting..."
   exit -1

elif [ $CRTSCTS != "Y" ] && [ $CRTSCTS != "N" ];
then
   echo "A CRTSCTS options is required.  Aborting..."
   exit -2

elif [ $PROXY_ARP != "Y" ] && [ $PROXY_ARP != "N" ];
then
   echo "A Proxy ARP options is required.  Aborting..."
   exit -3

elif [ -z $LOCAL_IP_ADDRESS ] || [ -z $REMOTE_IP_ADDRESS ];
then
   echo "A local and remote IP address is required.  Aborting..."
   exit -4
fi


# Generate command

pppd_command="pppd"

if [ $MS_DNS == "Y" ];
then
   pppd_command=$pppd_command" ms-dns $MS_DNS_IP_ADDRESS"
fi

if [ $CRTSCTS == "Y" ];
then
   pppd_command=$pppd_command" crtscts"
fi

if [ $PROXY_ARP == "Y" ];
then
   pppd_command=$pppd_command" proxyarp"
fi


# Add remote and local IP addresses to the command

pppd_command=$pppd_command" "$LOCAL_IP_ADDRESS":"$REMOTE_IP_ADDRESS

$pppd_command
