#! /bin/bash

set -ue

DEFAULT_GROUPS='sudo'
DEFAULT_UID='1000'

echo 'Please create a default UNIX user account. The username does not need to match your Windows username.'
echo 'For more information visit: https://aka.ms/wslusers'

if getent passwd "$DEFAULT_UID" > /dev/null ; then
  echo 'User account already exists, skipping creation'
  fastfetch
  exit 0
fi

while true; do

  # Prompt from the username
  read -p 'Enter new UNIX username: ' username

  # Create the user
  if /usr/sbin/adduser --uid "$DEFAULT_UID" --shell "/bin/bash" --create-home "$username"; then
    passwd $username
    if /usr/sbin/usermod "$username" -aG "$DEFAULT_GROUPS"; then
      fastfetch
      break
    else
      /usr/bin/deluser "$username"
    fi
  fi
done
