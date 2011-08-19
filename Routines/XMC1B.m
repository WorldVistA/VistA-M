XMC1B ;(WASH ISC)/THM-Script Interpreter (Open/Close) ;06/11/2002  09:33
 ;;8.0;MailMan;;Jun 28, 2002
 ; In:
 ; XMB
 ; XMC1
OPEN ;OPEN Command
 ; O H=FORUM.VA.GOV,P=TCP/IP-MAILMAN
 N XMI,XMCP,XMCP1,XMCP2
 F XMI=1:1:$L(XMC1,",") S XMCP=$P(XMC1,",",XMI) D  Q:ER
 . S XMCP1=$P(XMCP,"=",1),XMCP2=$P(XMCP,"=",2)
 . I XMCP1=$E("HOST",1,$L(XMCP1)) D HOST(XMCP2) Q
 . I XMCP1=$E("PROTOCOL",1,$L(XMCP1)) D PROT(XMCP2) Q
 . D ERTRAN^XMC1(42245,XMCP1) ;Invalid parameter: '|1|'
 Q:ER
 I $G(XMPROT)="" D PROT("SCP")
 D DEVICE Q:ER
 Q
HOST(X) ; Host - Set IP address used by transmission scripts in file 4.6
 S XMHOST=$P(XMB("SCR REC"),U,6)
 I XMHOST="" S XMHOST="NO-IP"
 Q
PROT(XMCHAN) ; Communications Protocol
 N Y
 D GET^XML
 Q
DEVICE ;
 S XMCP2=$S($D(ZTQUEUED)&$L($G(ZTIO)):ZTIO,$D(ZTQUEUED)&$L($G(ION)):ION,$L($G(XMIO)):XMIO,1:$P(XMB("SCR REC"),U,5))
 Q:XMCP2=""
 D TRYDEV(XMCP2) Q:'ER
 I $G(XMIO)="",$G(XMIO)=$G(ZTIO),$G(XMIO)'=XMCP2 D TRYDEV(XMIO)
 Q
TRYDEV(X) ; Device specification parsing
 S ER=0 I $D(ZTQUEUED),IO'="" U IO D D1 Q
 I X="" S ER=1 Q
 S %ZIS="R",IOP=X D ^%ZIS K IOP
 I POP D ERTRAN^XMC1(42246,X) Q  ;Device '|1|' could not be opened by %ZIS.
 S XMHANG("OPEN")=9
 D D1
 Q
D1 ;
 S XMC("DEVICE")=$P(^%ZIS(1,IOS,0),U),XMC("MODEM")=$P(^(0),U,6)
 I $L(XMC("MODEM")),$D(^%ZIS(2,XMC("MODEM"),50)) S XMDIAL=^(50),XMHANG=^(51),XMSTAT=$G(^(52))
 Q:IOT="RES"
 U IO X ^%ZOSF("EOFF") S X=255 X ^%ZOSF("RM") X ^%ZOSF("TYPE-AHEAD")
 Q
CLOSE ; Close channel
 I $G(XMHANG)'="" X XMHANG D:$L(IO) FLUSH^XMC1
 ;|1| sent, |2| received, |3| retransmissions.
 D DOTRAN^XMC1($S($G(XMTLER):42248,1:42247),+$G(XMC("S")),+$G(XMC("R")),$G(XMTLER))
 I '$D(ZTQUEUED),$G(XMHANG("OPEN"))=9 D ^%ZISC
 S IOP="HOME" D ^%ZIS
 ; Instead of the above line, v7.1 does this: *******************
 ; I '$D(ZTQUEUED) D HOME^%ZIS
 ; I $D(ZTQUEUED) S IO("C")=1 D ^%ZISC
 I $G(XMINST),$D(^XMBS(4.2999,XMINST,3)) S $P(^(3),U,1,6)="^^^^^"
 Q
