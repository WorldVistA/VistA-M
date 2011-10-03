RTT4 ;MJK/TROY ISC;Record Transaction Selection Utility; ; 5/8/87  10:48 AM ;
 ;;v 2.0;Record Tracking;**9,21**;10/22/91 
 ;
QUE X ^%ZOSF("UCI") S ZTUCI=Y,ZTRTN="DQ^RTT4",ZTDTH=$H D NOW^%DTC S ZTSAVE("RTQUEDT")=%,ZTIO=""
 F JL="RTPAST","RTINACFL","RTB","RTMV","RTAPL","RTMV0","DUZ(0)" I $D(@JL) S ZTSAVE(JL)=""
 S ZTDESC="Record Charge-out/Recharge etc.."
 F I=0:0 S I=$O(^TMP($J,"RT","AR",I)) Q:'I  S RTAR(I)=^(I)
 I $D(RTAR) S ZTSAVE("RTAR(")=""
 S RTN1=RTN D ^%ZTLOAD K RTAR Q
 ;
DQ S RTBKGRD=""
 F RTN=0:0 S RTN=$O(RTAR(RTN)) Q:'RTN  S Y=RTAR(RTN) D PARSE^RTT:$S('$D(^RT(+Y,"CL")):0,1:+$P(^("CL"),"^",6))'>RTQUEDT
 K RTAR,RT,RTMV,RTMV0,RTB,RTPROV,RTN,RTINACFL,RTQUEDT,RTBKGRD,RTAPL Q
 ;
8 ;;Record Charge-out to Patient
 I '$D(RTDIV) D DIV1^RTPSET I '$D(RTDIV) D MES^RTP4 Q
PT W ! S DIC(0)="IAEMQ",DIC="^DPT(" D ^DIC K DIC G PTQ:Y<0 S RTA=+RTAPL,RTB=+Y_";DPT(",DFN=+Y,Y=+$O(^RTV(195.9,"ABOR",RTB,RTA,0)) D SET^RTDPA3:'Y K RTA S RTB=Y
 S X="CHARGE-OUT" D TYPE^RTT G PTQ:'$D(RTMV)
 S X=$P(^DPT(DFN,0),"^"),RTSEL="S",DIC(0)="IEMQL" K RTY,DFN D ^RTDPA S:$D(RTESC) RTC=0 I $D(RTY) W ! S RTC=0 F RTY=0:0 S RTY=$O(RTY(RTY)) Q:'RTY  S RT=+RTY(RTY) D CHK^RTT3 I $D(RT) S RTCHG="" D CHG^RTT K RTCHG I $D(RT) S RTC=RTC+1 K RT,RTBCIFN
 I $D(RTC),RTC W !?3,"...record",$S(RTC>1:"s have",1:" has")," been charged out to the patient"
PTQ K RTESC,RTMV,RTE,RTB,RTY,RTC,RT,RTSEL
 K %,%DT,%YV,D0,DA,DGO,DI,DIC,DIC1,DIE,DIYS,DK,DL,DR,I1,N,POP,RTESC,RTMV0,RTZ,RTZ0,RTBCIFN,X,Y Q
BC K RTESC S RTRD(1)="Yes^print a barcode label for this record",RTRD(2)="No^not print a barcode label for the record",RTRD("B")=2,RTRD(0)="S",RTRD("A")="Would you like to print a barcode label? " D SET^RTRD K RTRD
 I $E(X)'="Y" S:$E(X1)="^" RTESC="" G BCQ
 S RTION=$P(RTFR,"^",4) D REC^RTL1 K RTION
BCQ W ! Q
 ;
CHKIN I $P(^RT(RT,0),"^")[";DPT(",$D(^DPT(+^(0),.1)) W !?3,*7,"...patient is currently an inpatient on ward '",^(.1),"'",!
 W:$P(^RT(RT,0),"^",13)="y" !?3,*7,"...some 'loose filing' needs to be done with this folder",!
 S Y=+$P(^RT(RT,0),"^",6) Q:Y=RTB  D BOR^RTB S X=$P(RTFR,"^",15) Q:"n"[X  W !?3,*7,"...this record's home file room is '",Y,"'" I X="d" W ! Q
 I X="q" S RTRD(1)="Yes^change home location",RTRD(2)="No^do not change location",RTRD(0)="S",RTRD("B")=2,RTRD("A")="Do you want to change this record's HOME location? " D SET^RTRD K RTRD Q:$E(X)'="Y"
 S DA=RT,DIE="^RT(",DR="6////"_RTB D ^DIE W:'$D(Y) !?6,"...home file room has been changed",!
 ;
