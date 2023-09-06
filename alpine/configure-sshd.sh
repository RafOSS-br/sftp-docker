#!/bin/sh
set -e

# Check if permit password login
export U_PERMIT_PASSWORD_LOGIN=$(echo $PERMIT_PASSWORD_LOGIN | tr 'a-z' 'A-Z')
if [ "${U_PERMIT_PASSWORD_LOGIN}" == "TRUE" ]; then
    sed -i "s/{PASSWORD_AUTHENTICATION}/yes/" /etc/ssh/sshd_config
else
    sed -i "s/{PASSWORD_AUTHENTICATION}/no/" /etc/ssh/sshd_config
fi
