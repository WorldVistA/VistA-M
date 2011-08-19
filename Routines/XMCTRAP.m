XMCTRAP ;(WASH ISC)/THM/CAP-Error Trap ;04/17/2002  08:14
 ;;8.0;MailMan;;Jun 28, 2002
 ;Modified for TCP/IP under INET_SERVERS of Wollongong
 ;
C ;set in XMC1
 N XMCTRAP S XMCTRAP=1
R ;set in XMRUCX
TRP N %,%E,X S (%,X)=""
 S %E=$$EC^%ZOSV()
 I '$$SCREEN^%ZTER(%E) D ^%ZTER
 ;Error Trap for Script processing (remove back-up tasks)...
 I $G(ZTQUEUED),$G(XMCTRAP) D ERRTRAP^XMTDR
 ;I $D(XMHANG),$L(XMHANG) X XMHANG
 ;D:IO'=IO(0) ^%ZISC
 S ER=1 G UNWIND^%ZTER
