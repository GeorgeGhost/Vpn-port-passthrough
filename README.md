# Vpn-port-passthrough
Simple bash script to pass port over to vpn client and pass it back using iptables.

This script takes user input and then passes 2 iptables commands to make port passthrough work. 

For example you can have VPS server acting as vpn server, and access ssh of the vpn client from outside world using this script.

Variables:
Input Port - port you want to access from outside world.
Port - port which you want to access on VPN client (eg ssh server port)
WAN - WAN of your VPS
Client - Internal vpn ip address of your VPN client (run ip addr on your VPN Client to check, (tun0 section))
Server - Internal vpn ip address of your VPN server (run ip addr on your VPN Server to check, (tun0 section))

These commands are useful to remove unwanted iptables rules:
List PREROUTING rules with line numbers:    iptables -t nat -v -L PREROUTING -n --line-number
Remove PREROUTING roule with given number:  iptables -t nat -D PREROUTING NUMBER
List POSTROUTING rules with line numbers:   iptables -t nat -v -L POSTROUTING -n --line-number
Remove POSTROUTING roule with given number: iptables -t nat -D POSTROUTING NUMBER
