#!/bin/sh
#script for reading SMS from SIMM card
#reset modem

LOG=log.txt
TMP=tmp.txt
MSGLOG=msgLog.txt

chat -Vs TIMEOUT 10 "" "ATZ" "OK" > /dev/modem < /dev/modem 2>> $LOG

#set modem to text mode only
chat -Vs TIMEOUT 3 "" "AT+CMGF=1" "OK" > /dev/modem < /dev/modem 2>> $LOG

##get listing of all messages
(chat -Vs TIMEOUT 6 "" "AT+CMGL=\"all\"" "OK" > /dev/modem < /dev/modem) 2> $TMP

cat $TMP >> $LOG


# Loog messages
grep "^+CMGL" $TMP | while read LINE; do

  MSGNO=`echo $LINE | awk '{ print $2 }' | awk -F, '{ print $1 }'`

  HEADER=`grep "^+CMGL: $MSGNO" $TMP`
  TEXT=`grep -A 1 "^+CMGL: $MSGNO" $TMP | tail -1`

  NUMBER=`echo $HEADER | ./csvfix order -f 3` 
  DATE=`echo $HEADER | ./csvfix order -f 5` 

  echo "$NUMBER,$DATE,\"${TEXT%?}\"" | tee -a $MSGLOG
  chat -Vs TIMEOUT 6 "" "AT+CMGD=$MSGNO" "OK" > /dev/modem < /dev/modem 2>> $LOG

done

rm $TMP
