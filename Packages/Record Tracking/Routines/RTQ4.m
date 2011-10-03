RTQ4 ;MJK/TROY ISC;Record Request Option; ; 5/14/87  1:24 PM ;
 ;;v 2.0;Record Tracking;;10/22/91 
2 ;Edit Request
 I '$D(RTAPL) D APL2^RTPSET D NEXT2:$D(RTAPL) K RTAPL,RTSYS Q
NEXT2 D PND^RTRPT
L2 S RTSEL="S",DIC(0)="IAEMQ",DIC("S")="S Z=^(0) I $P(Z,U,6)=""r""!($P(Z,U,6)=""n""),'$P(Z,U,10),'$P(Z,U,13) D SCRN^RTQ"
 D ^RTDPA2 K RT,RTE,RTQ G Q2:"^"[X,L2:'$D(RTY)
 F RTY=0:0 S RTY=$O(RTY(RTY)) Q:'RTY  S DA=+RTY(RTY),DIE="^RTV(190.1,",DR="[RT EDIT REQUEST]" D NOW^%DTC S RTNOW=% K RTFL1 D ^DIE K DE,DQ,RTNOW
 K RTY G L2
Q2 K RTWND,RTSEL,RTESC,RTFL1,RTFL,X
 K I,N,POP,RTC,RTX,X,Y,X1,Y1,DR,DIE,DA,RTDUZ,RT0,J,P Q
4 ;Fill a Request
 K ^TMP($J,"RT") S RTN=0,RTPCE=9 D WINDOW^RTRPT K RTPCE
SEL K RTDEL R !!,"Fill Which Request: ",X:DTIME D HELP:$E(X)="?" G SEL:'$D(X),SELQ:X=""!(X["^") S:$E(X)="-" RTDEL="",X=$E(X,2,99)
 S RTSEL="S",DIC(0)="IEMQ",DIC("S")="S Z=^(0) I $P(Z,U,6)=""r""!($P(Z,U,6)=""n"") D SCRN1^RTQ"
 K RTY D ^RTDPA2 K RTE,RTC G SEL:'$D(RTY)
 F RTY=0:0 S RTY=$O(RTY(RTY)) Q:'RTY  S RT=+^RTV(190.1,+RTY(RTY),0) D MISS1^RTQ1 I $D(RT) S RTQ=+RTY(RTY) D CANCEL^RTQ1:$P(^RTV(190.1,RTQ,0),"^",6)="x" I $D(RTQ) S Y=RTQ D ARRAY1^RTUTL1 K RT,RTQ
 K RTY G SEL
SELQ I X["^",RTN S RTRD(1)="Yes^fill record requests",RTRD(2)="No^not fill record requests",RTRD("B")=2,RTRD("A")="Do you still wish to 'fill' selected record requests? ",RTRD(0)="S" D SET^RTRD K RTRD G SELQ1:$E(X)'="Y"
 D QUE:RTN>$P(RTSYS,"^",2) G SELQ1:'RTN!(RTN>$P(RTSYS,"^",2)) W !!,"Will now fill requests selected..."
 F RTN=0:0 S RTN=$O(^TMP($J,"RT","AR",RTN)) Q:'RTN  S RTQ=^(RTN) D RTQ K RTQ
SELQ1 K RTSEL,RTWND,RTSTAT,RTN,RTESC
 K I,RT,%DT,DA,D0,DIE,DR,N,I1 Q
RTQ D FILL S RT=+^RTV(190.1,RTQ,0) D DEMOS^RTUTL1 W !?3,"...request for ",RTD("N"),"'s ",RTD("T"),"filled" K RTD Q
 ;
FILL ;Entry pt with RTQ defined
 S X="CHARGE-OUT" D TYPE^RTT Q:'$D(RTMV)!('$D(^RTV(190.1,RTQ,0)))  S Y=^(0),RTSTAT="c",RTB=+$P(Y,"^",5),RT=+Y,RTPROV=+$P(Y,"^",14)
 I $S('$D(^RT(RT,"CL")):1,'$D(^RTV(195.9,+$P(^("CL"),"^",5),0)):1,$P(^(0),"^")="2;DIC(195.4,":0,1:1) D CHG^RTT I '$D(Y) S DIE="^RTV(190.1,",DR="[RT CHANGE REQUEST STATUS]",DA=RTQ D ^DIE
 K DE,DQ,RTSTAT,RTMV,RTMV0,RTB,RT,RTPROV Q
 ;
HELP Q:'RTN  S X="Y",RTLC=1,RTIOSL=$S('$D(IOSL):24,'IOSL:24,1:IOSL)
 W !!,"Requests already selected to be filled during this session:" D LINE^RTUTL3
 F N=0:0 S N=$O(^TMP($J,"RT","AR",N)) Q:'N  S RTQ=+^(N) D HELP1 Q:X'="Y"
 W:X="Y" !!?3,"Also, you can delete a selected request by entering a",!?3,"'minus' sign(-) before the request number (eg. Select Request: -342)."
 D MORE^RTB2:X="Y"&(RTLC>1) S X=$S($E(X)="Y":"?",1:"") K:X'="?" X K RTLC,RTIOSL,N Q
 ;
HELP1 S Y=$S($D(^RT(+^RTV(190.1,RTQ,0),0)):$P(^(0),"^"),1:"UNKNOWN") D NAME^RTB W !?3,Y,"  " S Y=RTQ K RTQ D DISP1^RTUTL1:$D(^RTV(190.1,Y,0)) S Y=+^RTV(190.1,Y,0) D DISP^RTUTL1:$D(^RT(Y,0)),LINE^RTUTL3
 S X="Y",RTLC=RTLC+5 I (RTLC+5)>RTIOSL D MORE^RTB2 S RTLC=1,X=$E(X)
 Q
 ;
QUE X ^%ZOSF("UCI") S ZTRTN="DQ^RTQ4",ZTUCI=Y,ZTDTH=$H
 S:$D(DUZ(0)) ZTSAVE("DUZ(0)")="" D NOW^%DTC S ZTSAVE("RTQUEDT")=%,ZTSAVE("RTAPL")="",ZTDESC="Filling Record Requests"
 F I=0:0 S I=$O(^TMP($J,"RT","AR",I)) Q:'I  S RTAR(I)=^(I)
 S ZTSAVE("RTAR(")="",ZTIO=""
 W !!?3,"...requests have been QUEUED to be filled.",! D ^%ZTLOAD K RTAR Q
 ;
DQ S RTBKGRD=""
 F RTN=0:0 S RTN=$O(RTAR(RTN)) Q:'RTN  S RTQ=+RTAR(RTN),X=$S('$D(^RTV(190.1,RTQ,0)):0,'$D(^RT(+^(0),"CL")):0,1:+$P(^("CL"),"^",6)) I X'>RTQUEDT D FILL K RTQ
 K RTAR,RTQUEDT,RTN,RTBKGRD,RTAPL Q
