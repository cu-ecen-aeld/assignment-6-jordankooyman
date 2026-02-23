#!/bin/sh
# Written with assistance from DeepSeek: https://chat.deepseek.com/share/bc8l0zt9bbune09m32
### BEGIN INIT INFO
# Provides:          scull
# Required-Start:    $local_fs
# Required-Stop:     $local_fs
# Default-Start:     S
# Default-Stop:      0 6
# Short-Description: Load scull kernel modules
# Description:       Load the scull and related modules.
### END INIT INFO

MODULE_DIR="/lib/modules/$(uname -r)/extra"

case "$1" in
  start)
    echo "Loading scull modules"
    # Load scull main module
    if [ -f ${MODULE_DIR}/scull.ko ]; then
        insmod ${MODULE_DIR}/scull.ko
    else
        echo "scull.ko not found"
        exit 1
    fi
    # Optional: create device nodes if needed (scull uses dynamic devices normally)
    # For static nodes, you'd need major numbers from /proc/devices, but we'll skip.
    ;;
  stop)
    echo "Unloading scull modules"
    rmmod scull.ko
    ;;
  *)
    echo "Usage: $0 {start|stop}"
    exit 1
    ;;
esac
exit 0
