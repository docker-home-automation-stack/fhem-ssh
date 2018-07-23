#!/bin/bash

. /etc/profile

if [ -z "${SSH_ORIGINAL_COMMAND}" ] || [ "${SSH_ORIGINAL_COMMAND}" =~ ^inform..+ ]; then
  /fhem-telnet.exp $FHEM_HOST $FHEM_PORT $FHEM_PASSWORD "${SSH_ORIGINAL_COMMAND}"
else
  perl /fhem.pl $FHEM_HOST:$FHEM_PORT $FHEM_PASSWORD "${SSH_ORIGINAL_COMMAND}"
fi

exit 0
