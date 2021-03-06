#!/bin/bash
FILE="/etc/ufw/before.rules"
read -p 'Mode(iptables/ufw): ' MODE
read -p 'WAN: ' WAN
read -p 'VPN Client: ' CLIENT
read -p 'VPN Server: ' SERVER
read -p 'TCP or UDP(tcp/udp): ' TCPORUDP
read -p 'Input Port: ' INPUTPORT
read -p 'Port: ' PORT
if [["$MODE" == "ufw"]]
then
echo "Remove last line"
sed -i '$ d' $FILE
echo "# Add port forwarding from $SERVER($WAN):$INPUTPORT to $CLIENT:$PORT type $TCPORUDP and back" >> $FILE
echo " " >> $FILE
echo "Add to UFW: -A PREROUTING -d $WAN -p $TCPORUDP --dport $INPUTPORT -j DNAT --to-dest $CLIENT:$PORT"
echo "-A PREROUTING -d $WAN -p $TCPORUDP --dport $INPUTPORT -j DNAT --to-dest $CLIENT:$PORT" >> $FILE
echo "Add to UFW: -A POSTROUTING -d $CLIENT -p $TCPORUDP --dport $PORT -j SNAT --to-source $SERVER"
echo "-A POSTROUTING -d $CLIENT -p $TCPORUDP --dport $PORT -j SNAT --to-source $SERVER" >> $FILE
echo "Append line containing COMMIT"
echo " " >> $FILE
echo "COMMIT" >> $FILE
echo "Restart UFW to enable rules"
ufw enable
ufw disable
elif [["$MODE" == "iptables"]]
then
echo "iptables -t nat -A PREROUTING -d $WAN -p $TCPORUDP --dport $INPUTPORT -j DNAT --to-dest $CLIENT:$PORT"
iptables -t nat -A PREROUTING -d $WAN -p $TCPORUDP --dport $INPUTPORT -j DNAT --to-dest $CLIENT:$PORT
echo "iptables -t nat -A POSTROUTING -d $CLIENT -p $TCPORUDP --dport $PORT -j SNAT --to-source $SERVER"
iptables -t nat -A POSTROUTING -d $CLIENT -p $TCPORUDP --dport $PORT -j SNAT --to-source $SERVER
else
echo "Error: Invalid input"
fi
