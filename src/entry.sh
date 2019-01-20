#!/bin/bash

echo "Starting FHEM SSH server ..."
echo -e "  1. Generating SSH server keys\n\n"
if [[ ! -f /data/ssh_host_rsa_key || $(ssh-keygen -lf /data/ssh_host_rsa_key | cut -d " " -f 1) -lt 4096 ]]; then ssh-keygen -b 4096 -f /data/ssh_host_rsa_key -N '' -t rsa; fi
if [ ! -s /data/ssh_host_ecdsa_key ]; then ssh-keygen -f /data/ssh_host_ecdsa_key -N '' -t ecdsa; fi
if [ ! -s /data/ssh_host_ed25519_key ]; then ssh-keygen -f /data/ssh_host_ed25519_key -N '' -t ed25519; fi

echo -e "\n\n  2. Enabling authorized_keys\n\n"
mkdir -p /root/.ssh
chmod 700 /root/.ssh/
[ ! -f /data/authorized_keys ] && touch /data/authorized_keys
chmod 644 /data/authorized_keys
chmod 600 /data/ssh_host_*
ln -sf /data/authorized_keys /root/.ssh/

mkdir -p /var/run/sshd
chmod 0755 /var/run/sshd

[ -z "${FHEM_HOST}" ] && FHEM_HOST=fhem
[ -z "${FHEM_PORT}" ] && FHEM_PORT=7072

echo export FHEM_HOST=${FHEM_HOST} > /etc/profile.d/fhem.sh
echo export FHEM_PORT=${FHEM_PORT} >> /etc/profile.d/fhem.sh
echo export FHEM_PASSWORD=${FHEM_PASSWORD} >> /etc/profile.d/fhem.sh

echo "Server running - configured backend service:
  Hostname: ${FHEM_HOST}
  Port: ${FHEM_PORT}
  Password: $([ -n "${FHEM_PASSWORD}" ] && echo "*****" || echo none)
"

/usr/sbin/sshd -D
