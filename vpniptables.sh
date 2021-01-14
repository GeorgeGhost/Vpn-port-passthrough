#!/bin/bash
read -p 'WAN: ' WAN
read -p 'VPN Client: ' CLIENT
read -p 'VPN Server: ' SERVER
read -p 'TCP or UDP(tcp/udp): ' TCPORUDP
read -p 'Input Port: ' INPUTPORT
read -p 'Port: ' PORT
echo "iptables -t nat -A PREROUTING -d $WAN -p $TCPORUDP --dport $INPUTPORT -j DNAT --to-dest $CLIENT:$PORT"
iptables -t nat -A PREROUTING -d $WAN -p $TCPORUDP --dport $INPUTPORT -j DNAT --to-dest $CLIENT:$PORT
echo "iptables -t nat -A POSTROUTING -d $CLIENT -p $TCPORUDP --dport $PORT -j SNAT --to-source $SERVER"
iptables -t nat -A POSTROUTING -d $CLIENT -p $TCPORUDP --dport $PORT -j SNAT --to-source $SERVER
