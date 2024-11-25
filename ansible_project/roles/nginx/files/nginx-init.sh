#!/bin/bash
#
# nginx - this script starts and stops the nginx daemon in a Docker container
#
# chkconfig: - 85 15
# description: NGINX is an HTTP(S) server, HTTP(S) reverse proxy, and IMAP/POP3 proxy server
# processname: nginx
# config: /etc/nginx/nginx.conf
# pidfile: /var/run/nginx.pid

### BEGIN INIT INFO
# Provides:          nginx
# Required-Start:    $local_fs $network $syslog
# Required-Stop:     $local_fs $network $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start and stop nginx
### END INIT INFO

# Define paths
NGINX_PATH="/usr/sbin/nginx"
PID_FILE="/var/run/nginx.pid"
CONF_FILE="/etc/nginx/nginx.conf"

# Check if nginx binary exists
if [ ! -x $NGINX_PATH ]; then
    echo "Error: $NGINX_PATH binary not found!"
    exit 1
fi

# Functions to start, stop, and restart nginx
start() {
    echo "Starting nginx..."
    if [ -f $PID_FILE ]; then
        echo "nginx is already running."
    else
        $NGINX_PATH -c $CONF_FILE
        echo "nginx started."
    fi
}

stop() {
    echo "Stopping nginx..."
    if [ -f $PID_FILE ]; then
        kill -QUIT $(cat $PID_FILE)
        rm -f $PID_FILE
        echo "nginx stopped."
    else
        echo "nginx is not running."
    fi
}

restart() {
    echo "Restarting nginx..."
    stop
    start
}

status() {
    if [ -f $PID_FILE ]; then
        echo "nginx is running with PID $(cat $PID_FILE)."
    else
        echo "nginx is not running."
    fi
}

# Command parsing
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
