#!/bin/bash

# convience bash script to easiely create a port forwarding from the host to a VM

if [ "x$3" == "x" ]; then
  echo " "
  echo "  usage: $0 srcport dstport dstaddr"
  echo " "
  echo "    srcport = public port requests are comming in at"
  echo "    dstport = port on VM to forward traffic to"
  echo "    dstaddr = IP address of VM to forward traffic to"
  echo " "
  exit 1
fi

HOSTIP="10.11.12.13" # !!! change this to the actual IP address of your VM host
SRCPORT=$1
DSTPORT=$2
DSTADDR=$3

iptables -t nat -A PREROUTING -p tcp -d $HOSTIP --dport $SRCPORT -j DNAT --to $DSTADDR:$DSTPORT
iptables -I FORWARD -d $DSTADDR/32 -p tcp -m state --state NEW -m tcp --dport $DSTPORT -j ACCEPT
