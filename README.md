## Installation
Install iptables,ipset

Edit settings for iptables like in example-iptables file:
```
-A INPUT -p tcp -m tcp -j LOG --log-prefix "Iptables: unidentified: "
```
```
wget --no-check-certificate -O /etc/rsyslog.d/11-iptables.conf https://raw.githubusercontent.com/AndrewMarchukov/Fail2ban-defence-nmap-and-botnet-scanning/master/11-iptables.conf
wget --no-check-certificate -O /etc/fail2ban/action.d/iptables-ipset-proto6-allports.conf https://raw.githubusercontent.com/AndrewMarchukov/Fail2ban-defence-nmap-and-botnet-scanning/master/iptables-ipset-proto6-allports.conf
wget --no-check-certificate -O /etc/logrotate.d/iptables https://raw.githubusercontent.com/AndrewMarchukov/Fail2ban-defence-nmap-and-botnet-scanning/master/iptables-logrotate.d
wget --no-check-certificate -O /etc/fail2ban/filter.d/scanban-filter.conf https://raw.githubusercontent.com/AndrewMarchukov/Fail2ban-defence-nmap-and-botnet-scanning/master/scanban-filter.conf
wget --no-check-certificate -O /etc/fail2ban/jail.d/scanban-jail.conf https://raw.githubusercontent.com/AndrewMarchukov/Fail2ban-defence-nmap-and-botnet-scanning/master/scanban-jail.conf
```
and restart rsyslog, wait logs in /var/log/iptables.log then restart fail2ban

look blocked ip "ipset -L f2b-scanban"

## Tips and Tricks
Edit jail.conf:
```
[recidive]
enabled = true
logpath  = /var/log/fail2ban.log
banaction = iptables-ipset-proto6-allports
bantime  = 2592000
findtime = 86400   ; 1 day
maxretry = 3
```
Top 10 detected ip and port count:
```
cat /var/log/iptables.log| sed -r 's/.*SRC=(\S+).*PROTO=(\S+).*DPT=(\S+).*/\1 \2 \3/' | sort | uniq -c | sort -r -n|head -n 10
```
