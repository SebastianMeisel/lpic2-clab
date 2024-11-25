#!/bin/bash
# squid-init.sh - Simple init script for Squid proxy

### BEGIN INIT INFO
# Provides:          squid
# Required-Start:    $network $local_fs
# Required-Stop:     $network $local_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Squid Proxy
### END INIT INFO

SQUID_BIN="/usr/sbin/squid"
SQUID_CONF="/etc/squid/squid.conf"
SQUID_PID="/var/run/squid.pid"

start() {
    echo "Starting Squid proxy..."
    $SQUID_BIN -f $SQUID_CONF
}

stop() {
    echo "Stopping Squid proxy..."
    kill -TERM $(cat $SQUID_PID)
}

restart() {
    echo "Restarting Squid proxy..."
    stop
    start
}

status() {
    if [ -f $SQUID_PID ]; then
        echo "Squid is running (PID $(cat $SQUID_PID))"
    else
        echo "Squid is not running"
    fi
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    status)
        status
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
        ;;
esac
exit 0
