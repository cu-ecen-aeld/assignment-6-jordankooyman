#!/bin/sh
# Written with assistance from DeepSeek: https://chat.deepseek.com/share/bc8l0zt9bbune09m32
### BEGIN INIT INFO
# Provides:          misc-modules
# Required-Start:    $local_fs
# Required-Stop:     $local_fs
# Default-Start:     S
# Default-Stop:      0 6
# Short-Description: Load misc kernel modules (faulty, hello)
### END INIT INFO

MODULE_DIR="/lib/modules/$(uname -r)/extra"

case "$1" in
  start)
    echo "Loading misc modules"
    # Load hello (can use modprobe or insmod)
    if [ -f ${MODULE_DIR}/hello.ko ]; then
        insmod ${MODULE_DIR}/hello.ko
    fi
    # Load faulty - use insmod to avoid conflict with CONFIG_MD_FAULTY
    if [ -f ${MODULE_DIR}/faulty.ko ]; then
        insmod ${MODULE_DIR}/faulty.ko
    fi
    # Load any other modules you have (like jiq, silly, etc.) if needed
    ;;
  stop)
    echo "Unloading misc modules"
    rmmod hello.ko
    rmmod faulty.ko
    ;;
  *)
    echo "Usage: $0 {start|stop}"
    exit 1
    ;;
esac
exit 0
