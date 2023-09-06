#!/bin/sh
set -e

printf "\n\033[0;44m---> Creating SSH master user.\033[0m\n"

# Create SSH master user
adduser -D -h /home/sftp-user -s /bin/bash sftp-user
echo "sftp-user:${SSH_MASTER_PASS}" | chpasswd

# Setting environment variables
echo 'PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin"' >>/home/sftp-user/.profile

# Add individual sudo permissions for sftp-user
echo "sftp-user ALL=(root) NOPASSWD: SETENV: /usr/local/bin/entrypoint.sh" >>/etc/sudoers

# Add user to sftp group
addgroup sftp
addgroup sftp-user sftp
