XMRTCP ;(WASH ISC)/THM/CAP-SMTP Receiver ;10/09/2002  14:23
 ;;8.0;MailMan;**7**;Jun 28, 2002
 ;Modified for TCP/IP under INET_SERVERS of Wollongong
 ;
POLL ;Poll all domains with flags set
 ;Fake TaskMan Env.
 S U="^",X="ERR^XMRTCP",@^%ZOSF("TRAP"),XMDUZ=.5
 K XM S IOP="NULL",%IS=0 D ^%ZIS I '$D(IOT) S IOT=""
HANG S IO(0)=IO,ZTQUEUED=$S($D(ZTQUEUED):ZTQUEUED,1:1),ZTSK=$S($D(ZTSK):ZTSK,1:"N/A"),XM="",XMLTCPT=""
 I $G(^TMP("XMRTCP",0)) S XMLTCPT=^(0) K ^(0)
L Q:$P(^XMB(1,1,0),U,18)=1
 ;
 ;Any queues flagged (x-ref is set by TCP/IP POLL FLAG in domain file)
 S XMLTCPT=$O(^DIC(4.2,"ATCP",1,XMLTCPT)) G QQ:XMLTCPT=""
 S XMINST=XMLTCPT
 ;
RQ ;Transmit messages / execute TURN command
 ;Are there messages to send ?
 I '$O(^XMB(3.7,.5,2,XMINST+1000,1,0)) G L
 ;Job out, if all slots full wait and try again.
 S %=$$CK(1) I '% S XMLTCPT=$O(^DIC(4.2,"ATCP",1,XMLTCPT),-1) H 60 G L
 D SETUP L +^XMBX("TCPCHAN",XMINST):3 E  L -^XMBX("TCPCHAN-COUNT",%) G L
 ;
 S XMRTCP("CNT")=%
 ;
 ;Change name (prevent dupe error), then JOB myself
 Q:$E($G(XMRTCP("NAME")),1,6)="MM-FTP"
 S XMRTCP("NAME")="MM-TCP-"_XMINST D REN^XMRFTP
 S X=^%ZOSF("ERRTN"),@^%ZOSF("TRAP")
 ;
 ;Deliver messages
 ;
 ;INIT
 S XMSITE=$P(^DIC(4.2,XMINST,0),"^")
 D XMTCHECK^XMKPR(XMINST,.XMB)
 S XMOKTYPE("TCPCHAN")="" ;Find and use TCP/IP channel script
 D SCRIPT^XMKPR1(XMINST,XMSITE,.XMB,.XMOKTYPE) Q:'XMB("SCR IEN")
 ; Check that last try is at least 1 minute ago.
 ; If we've completed a cycle of scripts, wait until 1 hour has passed
 ; before we start the next cycle.
 I XMB("TRIES"),$$FMDIFF^XLFDT($$NOW^XLFDT,XMB("LAST TRY"),2)\60<1 G HALT
 E  I XMB("ITERATIONS"),XMB("SCR IEN")=XMB("FIRST SCRIPT"),$$FMDIFF^XLFDT($$NOW^XLFDT,XMB("LAST TRY"),2)\60\60<1 G HALT
 S ZTIO=$P(XMB("SCRIPT"),U,5)
 D XMTAUDT^XMTDR(XMINST,.XMB)
 D ENT^XMC1
 H 30
 D KILL
 G HALT
 ;
 ;Pause between POLLINGS
QQ D KILL S X=$H*86400+$P($H,",",2) G:$O(^XMBX(4.2995,0)) FTP^XMRFTP
 S X=22-($H*86400+$P($H,",",2)-X) I X>0 H X
 G POLL
 ;
 ;Entry on dupe name
DUPNAME S X="ERR^XMRTCP",@^%ZOSF("TRAP") H 15 G L
 ;
 ;Clean up before next transmission
KILL D KL1^XMC K DIC,XMB,XMDT,ZTPAR
 L  Q
 ;
SETUP ;Set up environment
 N IO S IO="",IO(0)="" D DT^DICRW
 Q
ERR D @^%ZOSF("ERRTN") H 60
 I '$F(":MM-TCP:MM-FTP:",":"_$E($G(XMRTCP("NAME")),1,6)_":") D KILL G POLL
HALT ;
 ;I ^%ZOSF("OS")["VAX" U IO:DISCONNECT
 ;G ^XUSCLEAN  ; Writes to IO. 
 G H2^XUSCLEAN ; Supposedly doesn't write to IO.
 ;
 ;Entry for Inet_servers interface RECEIVER
 ;SMTP service request invokes MailMan
 ;
SOC25 S (XMRPORT,IO,IO(0))=%,X=$E(%_"-INETMM",1,15) D SETENV^%ZOSV
 D DT^DICRW,DUZ^XUP(.5)
 S X="ERR^ZU",@^%ZOSF("TRAP"),ER=0
 O IO:(SHARE,MAILBOX) U IO
 S XMCHAN="TCP/IP-MAILMAN",XMNO220=""
 D ENT^XMR
 G HALT
 ;
 ;Check if slot on TCP/IP to use
CK(X) S I=$P(^XMB(1,1,0),"^",17)
 F %=1:1 L +^XMBX("TCPCHAN-COUNT",%):1 Q:$T  Q:%=I
 Q $S($T:%,1:0)
JOB ;
 H 90 ;wait for RVG mounts
 S $P(^XMB(1,1,0),"^",18)="" ;Clear the TCP/IP poller run flag
START G START^XMRTCPGO
ERRSCRPT ;TRAP transmission errors
 S ER=1
 I ^%ZOSF("OS")["VAX DSM" S $ECODE=""
 Q
