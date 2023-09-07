#!/bin/sh

set_password_authentication(){
  if [ "${U_PERMIT_PASSWORD_LOGIN}" == "TRUE" ]; then
      sed -i "s/{PASSWORD_AUTHENTICATION}/yes/" /etc/ssh/sshd_config
  else
      sed -i "s/{PASSWORD_AUTHENTICATION}/no/" /etc/ssh/sshd_config
  fi
}

main(){
  export U_PERMIT_PASSWORD_LOGIN=$(echo $PERMIT_PASSWORD_LOGIN | tr 'a-z' 'A-Z')
  set_password_authentication
}

main
