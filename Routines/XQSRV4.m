XQSRV4 ;SEA/MJM - Server utilities;;2/6/92  2:13 PM ;3/10/92  07:55;11/9/93  2:58 PM
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
 ;This routine takes a pointer to a bulletin in X and looks to
 ;see if there is an active user reachable through it's mail group.
 ;If the site has chosen a bulletin other than XQSERVER then it
 ;checks that one first, if it fails it defaults to XQSERVER.  If
 ;that fails too  the routine returns Y="".
 ;
 I '$D(X) S Y="" Q
 S U="^",Y=1,%XQGO=0
 I X]"" S X=$P($G(^XMB(3.6,+X,0)),U) I X]"" D GRP I %XQGO S XQMB=%XQB,Y=1 G KILL
 S (X,XQMB)="XQSERVER" S %=$O(^XMB(3.6,"B","XQSERVER",0)) I %="" S Y="",XQER1=" is not in bulletin file." G KILL
 D GRP
 I %XQGO S Y=1
 E  S Y=""
 ;
KILL ;Clean up and depart
 K %XQB,%XQG,%XQGO,%XQI,%XQJ,%XQN,%XQT,%XQU,X
 Q
 ;
GRP ;See if there is a legitimate mail group
 S %XQB=X,%XQN=$O(^XMB(3.6,"B",%XQB,0)) I %XQN="" S Y="" Q
 F %XQI=0:0 Q:%XQGO  S %XQI=$O(^XMB(3.6,%XQN,2,"B",%XQI)) Q:%XQI=""  I $D(^XMB(3.8,%XQI,0))#2 S %XQU="" F %XQJ=0:0 S %XQU=$O(^XMB(3.8,%XQI,1,"B",%XQU)) Q:%XQU=""  D USER Q:%XQGO
 I %XQGO S Y=%XQU
 E  S Y=""
 Q
 ;
BULL ;Set up the bulletin parameters and/or reply mail and fire 'em off
 S XMB=XQMB,XMB(1)=XQDATE,XMB(2)=XMFROM,XMB(3)=XQSOP,XMB(4)=XQSUB,XMB(5)=XQMSG
 S:XQER[";;" XQER=$P(XQER,";;",2)
 S XMB(6)=XQMB6,XMB=XQMB
 I XMB(6)="  " S XMB(6)="No errors detected by the Menu System.",XMB(7)="OK"
 E  S XMB(7)="ERROR"
 I $D(XQSTXT) S XMTEXT="XQSTXT("
 S XQJ=$P(XQ220,U,3) I $L(XQJ),$D(^XMB(3.8,XQJ,0)) S XQN="" F XQI=0:0 S XQN=$O(^XMB(3.8,XQJ,1,"B",XQN)) Q:XQN=""  S XMY(XQN)=""
 I $D(XMFROM),XMFROM=+XMFROM,$D(^VA(200,XMFROM,0)) S XMFROM=$P(^(0),U)
 D:'XQNOUSR ^XMB K XMY
 Q
 ;
USER ;See if this User is still active
 Q:'$D(^VA(200,%XQU,0))#2  Q:$P(^(.1),U,2)=""  S %XQT=$P(^(0),U,11) I %XQT'="" Q:DT>%XQT
 S %XQGO=1
 Q
