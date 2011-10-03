RTP1 ;MJK/TROY ISC;Pull List Option; ; 5/5/87  8:40 AM ;
 ;;v 2.0;Record Tracking;;10/22/91 
5 ;Designate Requests as 'Not Fillable'
 D PND^RTRPT S RTINACFL=""
51 S DIC(0)="IEQ",DIC("S")="S Z=^(0) I $P(Z,U,6)=""r""!($P(Z,U,6)=""n"") D SCRN^RTQ",RTSEL="DSO" R !!,"Select Request: ",X:DTIME G Q5:"^"[X S RTN=0 D ^RTDPA2 G 51:'$D(RTY)
 F RTY=0:0 S RTY=+$O(RTY(RTY)) Q:'RTY  S RTQ=+RTY(RTY) I $D(^RTV(190.1,RTQ,0)) S S=$P(^(0),"^",6) D NOT I $D(RTQ) S DIE="^RTV(190.1,",DR="[RT CHANGE REQUEST STATUS]",DA=RTQ D ^DIE K DE,DQ
 K RTY,RTQ G 51
Q5 K DIC,RTSEL,RTWND,RTN,RTSTAT,RTPULL,RTESC,RTINACFL
 K DA,D0,POP,DIE,POP,RTC,N,DR,J Q
NOT D EQUALS^RTUTL3 W !,"Current status of request is '",$S(S="r":"REQUESTED",1:"NOT FILLABLE"),"'." S RTSTAT=S
 S RTRD(1)="Yes^change request status",RTRD(2)="No^do not change status",RTRD(0)="S",RTRD("B")=1,RTRD("A")="Do you want to change status to '"_$S(S="r":"NOT FILLABLE",1:"REQUESTED")_"' ? " D SET^RTRD K RTRD D EQUALS^RTUTL3
 I $E(X)="N"!($E(X)="^") K RTQ,RTSTAT Q
 S RTSTAT=$S(RTSTAT="r":"n",1:"r") Q
 ;
8 ;Cancel Individual Requests from a Pull List
 D LIST^RTP Q:Y<0  S RTSTAT="x"
81 K RTY S DIC(0)="IEQ",DIC("S")="I $P(^(0),U,10)=RTPULL,$P(^(0),U,6)=""r""!($P(^(0),U,6)=""n"")",RTSEL="DSO" R !!,"Select Request: ",X:DTIME S RTN=0 D HELP^RTP2:X["?" G 81:'$D(X),Q8:"^"[X D ^RTDPA2 K RTSEL G 81:'$D(RTY)
 D CAN G 81:$E(X)'="Y" S RTSTAT="x"
 F RTY=0:0 S RTY=+$O(RTY(RTY)) Q:'RTY  S RTQ=+RTY(RTY) I $D(^RTV(190.1,RTQ,0)) S DIE="^RTV(190.1,",DR="[RT CHANGE REQUEST STATUS]",DA=RTQ D ^DIE K DE,DQ W !?3,"...request has been cancelled"
 K RTSTAT,RTY,RTQ G 81
Q8 K DIC,RTSEL,RTN,RTSTAT,RTPULL,RTESC,NEW,A,DA,D0,DIE,N,POP,RT,RTC,RTE
 K X,Y,C,I,X1,RTQ,T,DR Q
CAN S RTRD(1)="Yes^cancel request(s)",RTRD(2)="No^do cancel request(s)",RTRD(0)="S",RTRD("B")=2,RTRD("A")="Are you sure you want to cancel "_$S(RTC=1:"this",1:"these")_" request"_$S(RTC=1:"",1:"s")_"? " D SET^RTRD K RTRD Q
 ;
9 ;Modify Pull List Comments
 W ! S DIC("S")="I $P(^(0),U,2)'<DT,$P(^(0),U,6)=""r"",$P(^(0),U,15)=+RTAPL",DIC(0)="IAEMQ",DIC="^RTV(194.2," D ^DIC K DIC G Q9:Y<0
 S DA=+Y,DR="100",DIE="^RTV(194.2," D ^DIE K DE,DQ
Q9 K DA,D0,DIE,DR,POP,DIC,J Q
