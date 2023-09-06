#!/bin/bash

printf "\n\033[0;44m---> Adding users to SFTP server.\033[0m\n"
declare -A user_seen
IFS="," read -ra user_array <<<"${SSH_USERS}"
for u in "${user_array[@]}"; do
    # trim
    u=$(echo $u | xargs)

    # Ignore empty
    [ -z "$u" ] && continue

    # Check if format is user:pass
    if [[ "$u" =~ ":" ]]; then
        # Split by :
        user=$(echo $u | awk -F':' '{print $1}')
        # User set pass
        passExists=1
    else
        # Format not is user:pass
        user="$u"
        # User not set pass
        passExists=0
    fi

    # Duplicate entry
    [[ ${user_seen[$user]} == 1 ]] && continue
    user_seen[$user]=1

    # Create user and add in sftp group
    adduser -D -h /home/${user} -s /bin/sh ${user}
    addgroup ${user} sftp
    printf "\n\033[0;32mUser ${user} added!\033[0m"

    # Create ssh folder if not exists
    if [ ! -d /home/${user}/.ssh ]; then
        /bin/mkdir /home/${user}/.ssh
    fi

    # Env name to UPPER
    name=$("SSH_PUB_${user}" | tr 'a-z' 'A-Z')

    # Use indirect sintax to access ssh public key
    if [ ! -z "${!name}" ]; then
        echo ${!name} >/home/${user}/.ssh/authorized_keys
        # Verify if ssh public key is valid
        if ssh-keygen -l -f /home/${user}/.ssh/authorized_keys >/dev/null 2>&1; then
            printf "\n\033[0;32mSSH public key is set to '${user}' user\033[0m"
        else
            printf "\n\031[0;32mIt seems have issue with SSH public key to '${user}' user\033[0m"
        fi
    fi
    unset name

    # Verify credentials
    password=$(echo "$u" | awk -F':' '{ print $2 }')
    if [[ ! -z $password && $passExists == 1 ]]; then
        # To password login, set credentials
        echo $u | chpasswd >/dev/null 2>&1
        printf "\n\033[0;32mPassword is set to '${user}' user\033[0m"
    else
        printf "\n\031[0;32mIt seems have issue with password to '${user}' user\033[0m"
    fi

    unset password pass

    if [ ! -d /data/${user} ]; then
        mkdir /data/${user}
        chown ${user}:root /data/${user}
        chmod 700 /data/${user}
    fi
    unset user
done
