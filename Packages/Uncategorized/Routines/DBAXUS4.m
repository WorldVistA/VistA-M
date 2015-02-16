XMRONT ;(SF-ISC)/RWF - OpenM-NT TCP/IP INETD and Front End ;04/30/2002  07:24
 ;;8.0;MailMan;**27**;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; GO   XMRONT
 ;This routine starts a listener for TCP mail Connects.
 ; It takes the place of the INETD Unix process
 ;
GO ;Open port 25 in Accept mode.
 S XMRSOCK=25
 D LISTEN^%ZISTCPS(XMRSOCK,"SOC25^XMRONT")
 ;HALT
 G HALT
 ;
SOC25 ;This entry point is started as a new process by %ZISTCPS.
 S (XMRPORT,IO,IO(0))=$IO,IOT="TCP"
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D TRP^XMCTRAP"
 E  S X="TRP^XMCTRAP",@^%ZOSF("TRAP")
 N DIQUIET S DIQUIET=1 D DT^DICRW,DUZ^XUP(.5)
 S ER=0,XMCHAN="TCP/IP-MAILMAN",XMNO220=""
 U IO
 D ENT^XMR
HALT ;Unlock all locks, close the connection and quit
 ;L ;C IO  The close caused a problem under OpenM 52e, so it was removed
 G ^XUSCLEAN
 Q
