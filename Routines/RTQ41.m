RTQ41 ;MJK/TROY ISC;Record Request Option; ; 5/5/87  8:42 AM ;
 ;;v 2.0;Record Tracking;;10/22/91 
3 ;Cancel a Request
 S RTPGM="CANCEL"
31 I '$D(RTAPL) D APL2^RTPSET D NEXT3:$D(RTAPL) K RTAPL,RTSYS Q
NEXT3 D PND^RTRPT
L3 K RTY S RTSEL="S",DIC(0)="IAEMQ",DIC("S")="S Z=^(0) I $P(Z,U,6)=""r""!($P(Z,U,6)=""n"") D SCRN^RTQ"
 D ^RTDPA2 K RT,RTSEL,RTE,RTQ D:$D(RTY) @RTPGM
Q3 K RTY,RTPGM,RTWND,RTSEL,RTESC
 K I,%DT,D0,DA,DIE,N,RTC,X1,X,Y,DR,DIC,J Q
5 ;;Reprint a Request
 S RTPGM="REPRT" G 31
 ;
REPRT S RTION="" F RTY=0:0 S RTY=$O(RTY(RTY)) Q:'RTY  S RTQ=+RTY(RTY) D RTQ^RTL1
 K RTION,RTQ Q
 ;
CANCEL S RTRD(1)="Yes^cancel",RTRD(2)="No^not cancel",RTRD("B")=2,RTRD(0)="S",RTRD("A")="Are you sure you want to cancel "_$S(RTC=1:"this request",1:"these requests")_"? " D SET^RTRD K RTRD G CANCELQ:$E(X)'="Y"
 S RTSTAT="x" F RTY=0:0 S RTY=$O(RTY(RTY)) Q:'RTY  S DA=+RTY(RTY),DIE="^RTV(190.1,",DR="[RT CHANGE REQUEST STATUS]" D ^DIE,BUL^RTUTL6 K DE,DQ W !?3,"...request #",DA," has been cancelled."
CANCELQ K RTSTAT Q
 ;
 ;
FILL ;Entry pt with RTQ defined ;if rtplty=3 
 S X="TRANSFER RETIRE" D TYPE^RTT Q:'$D(RTMV)!('$D(^RTV(190.1,RTQ,0)))  S RT=+^(0),RTSTAT="c",RTB=^TMP($J,"RTREQUESTS","RTB")
 ;S RTB=+$P(Y,"^",5),RT=+Y,RTPROV=+$P(Y,"^",14)
 S RTINACFL=1
 I $S('$D(^RT(RT,"CL")):1,'$D(^RTV(195.9,+$P(^("CL"),"^",5),0)):1,$P(^(0),"^")="2;DIC(195.4,":0,1:1) D CHG^RTT I '$D(Y) S DIE="^RTV(190.1,",DR="[RT CHANGE REQUEST STATUS]",DA=RTQ D ^DIE
 K DE,DQ,RTSTAT,RTMV,RTMV0,RTPROV,RT Q
 ;
PERP ;create appl default perpetual records from rr pull list
 I '$D(^TMP($J,"RTE")) Q
 I $D(^DIC(195.1,+RTAPL,4)),$P(^(4),"^",5) S RTRTY=$P(^(4),"^",5)
 E  Q
 S RTCOUNT=0
 S Y=RTRTY,C=$P(^DD(195.1,45,0),"^",2) D Y^DIQ S RTCOUNT("TY")=Y
 W !!,"Creating '",Y,"' records from RR Pull lists charged out",!!
 ;log record creation, print labels
 K RTBKGRD S RTADM=""
 S RTRE=0 F N=0:0 S RTRE=$O(^TMP($J,"RTE",RTRE)) Q:'RTRE  S RTE=RTRE,RTTY=+RTRTY,RTVOL=1,RTPAR="" I '$D(^RT("AT",RTTY,RTE)) D SET^RTDPA1 S RTCOUNT=RTCOUNT+1
 W !!,"   Total '",RTCOUNT("TY"),"' records created = ",RTCOUNT,!!
 K RTADM,RTCOUNT,RTRE,RTRTY,RTE,RTTY,RTVOL,RTPAR Q
