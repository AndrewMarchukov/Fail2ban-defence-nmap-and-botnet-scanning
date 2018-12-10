/var/log/iptables.log {
    daily
    rotate 14
    maxage 14
    compress
    missingok
    notifempty
    sharedscripts
}
