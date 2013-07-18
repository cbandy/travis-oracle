#!/bin/sh

set -e

test -L /dev/shm && ( sudo rm /dev/shm && sudo mkdir /dev/shm && sudo mount -t tmpfs shmfs -o size=2G /dev/shm )
test -f /sbin/chkconfig || ( echo '#!/bin/sh' | sudo tee /sbin/chkconfig > /dev/null && sudo chmod u+x /sbin/chkconfig )
test -d /var/lock/subsys || sudo mkdir /var/lock/subsys

