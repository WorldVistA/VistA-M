XMRFTPUX ;(WASH ISC)/THM/CAP-SMTP Receiver (RFC 821) ;04/17/2002  11:20
 ;;8.0;MailMan;;Jun 28, 2002
 ;Modified for TCP/IP under INET_SERVERS of Wollongong
 ;Send out FTP jobs that are due
FTP N %,DA,DIK,XMA0,XMC0,XMSFTP,Y,Z,XMCOM S XMA0=$H*86400+$P($H,",",2)
F1 S Z=0,Z=$O(^XMBX(4.2995,Z)) G FQ:+Z'=Z I '$D(^(Z,0)) G QQ^XMRTCP
 S Y=^XMBX(4.2995,Z,0),XMSFTP=$P(Y,U,4),XMRTCPY="MM-FTP-"_$P(Y,U),XMCOM=$P(Y,U)
 I XMCOM'?1"XM".E D RUNQ G QQ^XMRTCP
F2 F  S %=$S($G(XMC0):XMC0,1:$$CK^XMRTCP(1)) G F3:%
 ;Copy file to export directory
F3 S XMC0=% I XMSFTP S %=$$FCHK(Z,XMA0,XMSFTP) G F1:%
 S XMRTCP("NAME")=XMRTCPY D REN
 G RUN
FQ I $G(XMC0) L -^XMBX("TCPCHAN-COUNT",XMC0)
 Q
 ;Submit FTP process
RUN I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP=""
 S X="RUNQ^XMRFTP",@^%ZOSF("TRAP")
 S %=$ZC(%SPAWN,"@"_XMCOM),%=$ZC(%SPAWN,"DELETE "_XMCOM_".*")
RUNQ ;Remove from 4.2995
 I $D(Z) N DIK,DA S DIK="^XMBX(4.2995,",DA=Z K XMRTCPY D ^DIK Q
 Q
REN I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP=""
 S X="DUPNAME^XMRTCP",@^%ZOSF("TRAP")
 I ^%ZOSF("OS")["VAX" S X=$ZC(%SETPRN,$E(XMRTCP("NAME"),1,13))
 D START^XMRTCPGO
 Q
FCHK(Z,Y,F) ;Is file in export directory ?
 Q 0 ;****************
 N %,%0,%1,%2,I,X,XMIO
 S XMIO=$I,%=^XMBX(4.2995,Z,0),%0=$P(%,U,5),%2=$P(%,U,4)
 I '%0 S $P(^XMBX(4.2995,Z,0),U,5)=Y,%=$$EXPORT^MAGAPI("MAIL",F,"WAIT") Q %
 S %=$P(^MAG(2005,%2,0),U,2)
CONT S %0="XMS"_$E(Z,$L(Z)-4,$L(Z))_".LIS"
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP=""
 S X="FPQ^XMRFTP",@^%ZOSF("TRAP"),X=$ZC(%SPAWN,"PURGE "_%0)
FPQ I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP=""
 S X="Q0^XMRFTP",@^%ZOSF("TRAP"),X=$ZC(%SPAWN,"DIR/OUTPUT="_%0_" NFA0:[EXPORT.MAIL]"_%)
 O %0 U %0
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP=""
 S X="FCHKQ^XMRFTP",@^%ZOSF("TRAP")
 F  R X:9 Q:X[%
FCHKQ C %0 U XMIO
 I X'[% Q 1
 Q 0
Q0 Q 1
FER N X S X=$P($G(^XMBX(4.2995,Z,0)),U,2)
 I 'X S X=$H*86400+$P($H,",",2),$P(^(0),U,2)=X
 Q:$H*86400+$P($H,",",2)-%>99
 N Z S XMDUZ=.5,XMSUB="ERROR moving File from Image Server"
 S XMTEXT="A(",A(1)="The error was: "_%_"."
 S A(2)="The COM file being processed was: "_Y,XMY(.5)=""
 D ^XMD Q
IMAGENT(Y,F) ;
 N %,%0,XMIO,X
 I ^%ZOSF("OS")["MSM" S X=$ZOS(12,NEWPATH,"") I $P(X,U)=F QUIT "5 -IMAGE ALREADY THERE"
 S Z=$P($H,",",2)#1000,XMIO=$I,%=F
 G CONT
