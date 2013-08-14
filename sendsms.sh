#!/bin/sh
#script for reading SMS from SIMM card
#reset modem

NUMBER=$1
MESSAGE=$2

LOG=log.txt

chat -Vs TIMEOUT 10 "" "ATZ" "OK" > /dev/modem < /dev/modem 2>> $LOG

#set modem to text mode only
chat -Vs TIMEOUT 3 "" "AT+CMGF=1" "OK" > /dev/modem < /dev/modem 2>> $LOG

##get listing of all messages
#(chat -Vs TIMEOUT 6 "" "AT+CMGL=\"all\"" "OK" > /dev/modem < /dev/modem) 2>&1 | tee -a log.txt
#chat -Vs TIMEOUT 6 "" "AT+CMGL=\"all\"" "OK" > /dev/modem < /dev/modem 2>&1 | tee -a log.txt

chat -Vs TIMEOUT 6 "" "AT+CMGS=\"$NUMBER\"" "\>" > /dev/modem < /dev/modem 2>> $LOG
chat -Vs TIMEOUT 10 "" "$MESSAGE^Z" "RSSI" > /dev/modem < /dev/modem 2>> $LOG
