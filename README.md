# Vpn-port-passthrough
Simple bash script to pass port over to vpn client and pass it back using iptables or ufw.

This script takes user input and then passes 2 iptables commands to make port passthrough work. 

This script is to be run on the machine acting as VPN Server!

For example you can have VPS server acting as vpn server, and access ssh of the vpn client from outside world using this script.

You must set net.ipv4.ip_forward=1 to make both scripts work

## Variables:
* Mode - choose which script to use (iptables or ufw). (Only available in vpncombined.sh)
* Input Port - port you want to access from outside world.
* Port - port which you want to access on VPN client (eg ssh server port)
* WAN - WAN of your VPS (VPN Server)
* Client - Internal vpn ip address of your VPN client (run ip addr on your VPN Client to check, (tun0 section))
* Server - Internal vpn ip address of your VPN server (run ip addr on your VPN Server to check, (tun0 section))

## Iptables:
This script:
* Runs 2 commands to add rules to  iptables
### These commands are useful to remove unwanted iptables rules:
* List PREROUTING rules with line numbers: ` iptables -t nat -v -L PREROUTING -n --line-number `
* Remove PREROUTING roule with given number: ` iptables -t nat -D PREROUTING NUMBER `
* List POSTROUTING rules with line numbers:  ` iptables -t nat -v -L POSTROUTING -n --line-number `
* Remove POSTROUTING roule with given number: ` iptables -t nat -D POSTROUTING NUMBER `

## UFW:
### To make this script work:
* You must have 'DEFAULT_FORWARD_POLICY="ACCEPT"' in /etc/default/ufw
* This must be set this manually at the end of /etc/ufw/before.rules
```
*nat
:PREROUTING ACCEPT [0:0]
:POSTROUTING ACCEPT [0:0]

-F

COMMIT
```
* COMMIT must be the last line of the file in order for script to work correctly

### This script:
* Removes COMMIT at the end of /etc/ufw/before.rules
* Adds rules for port passthrough at the end of the file
* Adds comment above added rules to explain what they do
* Adds COMMIT at the end of /etc/ufw/before.rules
