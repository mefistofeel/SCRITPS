#!/bin/bash
LOG=/var/log/asterisk-check.log
SERVICE=asterisk.service
DATE=`date '+%d-%m-%Y_%H:%M:%S'`
STATUS=`systemctl status ${SERVICE} | grep -i -w '.*Active:.*[a-z]*\([A-Za-z]*\)' | awk '{print $3}'`
#STATE=${STATUS} | awk '{print $3}'
# write to log file
#echo "${DATE} - ${STATE} --  ${STATUS}" >> ${LOG}

#STATE=${STATUS} | awk '{print $3}'
if [[ $STATUS == *"running"* ]]; then
  echo "${DATE} - Asterisk is OK : Status - ${STATUS}." >> ${LOG}
	exit 0
else
  echo "${DATE} - Asterisk : Status - ${STATUS}." >> ${LOG}
  systemctl stop ${SERVICE}
  sleep 10
  systemctl start ${SERVICE}
  sleep 10
  echo "${DATE} - Asterisk is !!! RESTARTED !!! : Status - ${STATUS}." >> ${LOG}
fi



