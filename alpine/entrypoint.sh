#!/bin/bash
set -e
source /usr/local/bin/addusers.sh
printf "\n\033[0;44m---> Starting the SSH server.\033[0m\n"

# Start SSH in foreground
#rc-service sshd start
#rc-service sshd status
/usr/sbin/sshd -D -e
