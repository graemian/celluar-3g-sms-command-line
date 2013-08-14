celluar-3g-sms-command-line
===========================

Shell scripts to send and receive SMS via 3G / Cellular modem on the command line

Based on 

http://gin.site40.net/docs/32%20-%20Sending%20and%20Receiving%20SMS%20via%20GSM%20Modem.pdf

by tkibowen@googlemail.com, and 

http://n00bsys0p.co.uk/blog/2012/07/09/sending-recieving-sms-3g-device-linux

by n00bsys0p

Requires csvfix from https://code.google.com/p/csvfix/

Example:

![Example](example.png "Example")

    [root@shark sms]$ ./sendsms.sh +27834151642 "Dude, where's my car?"
    [root@shark sms]$ ./checksms.sh 
    "+27834151642","13/08/14,12:02:33+08","Where's your car dude"
    [root@shark sms]$
