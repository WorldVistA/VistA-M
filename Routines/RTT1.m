RTT1 ;MJK/TROY ISC;Record Transaction Option; ; 5/7/87  12:02 PM ;
 ;;v 2.0;Record Tracking;;10/22/91 
2 ;;New Volume Creation
 S RTA=+RTAPL D ASK^RTB K RTA G Q2:$D(RTESC),2:Y<0 S RTE=X D NEW G 2
NEW D SET1 I '$D(RTS) S Y=RTE D NAME^RTB W !!?3,*7,"...currently no volume #1 for ",Y,"." Q
 W !!?5,"Record Type",?30,"Highest Volume Number",!?5,"------------",?30,"---------------------"
 S RTC=0 F T=0:0 S T=$O(RTS(T)) Q:'T  S RTC=RTC+1,X=RTS(T) W !?5,$P(X,"^",3),?40,+X
 S:$D(RTTY) RTTYX=RTTY I RTC=1 S Y=+$O(RTS(0)) D TYPE1^RTUTL
 I RTC>1 W ! S DIC="^DIC(195.2,",DIC("S")="I $D(RTS(+Y)),$S('$D(^(""I"")):1,'^(""I""):1,1:DT'>^(""I""))",DIC("A")="Select Record Type: ",DIC(0)="IAEMQZ" D ^DIC K DIC G SETQ:Y<0 S RTTY=+Y_";"_Y(0)
 S X=RTS(+RTTY),RTVOL=X+1,RTPAR=+$P(X,"^",2)
 S RTRD(1)="Yes^create new volume",RTRD(2)="No^do not create new volume",RTRD(0)="S",RTRD("B")=2,RTRD("A")="Do you want to create "_$P(X,"^",3)_" VOL # "_RTVOL_"? " D SET^RTRD K RTRD S X=$E(X) G SETQ:X'="Y"
 S RTSHOW="" D SET^RTDPA1 K RTSHOW
 D ^RTT12
SETQ K RTESC,RTC,T,V,RTPAR,RTVOL,RT,RTTY,RTS S:$D(RTTYX) RTTY=RTTYX K RTTYX Q
 ;
SET1 F I=0:0 S I=$O(^RT("AA",+RTAPL,RTE,I)) Q:'I  I $D(^RT(I,0)) S X=^(0),T=+$P(X,"^",3),V=+$P(X,"^",7) I $D(^DIC(195.2,T,0)),$P(^(0),"^",17)="y",$P(X,"^",4)=+RTAPL,$S('$D(RTTY):1,T=+RTTY:1,1:0) D SET2
 Q
SET2 S:'$D(RTS(T)) RTS(T)=V_"^^"_$P(^(0),"^") S:V=1 $P(RTS(T),"^",2)=I S:+RTS(T)'>V $P(RTS(T),"^")=V Q
 ;
Q2 K DIE,RTE,RTESC,DR,DIC,DA Q
 ;
7 ;;Flag Record as Missing
 I $S($P(RTAPL,"^",8)']"":1,'$D(^XUSEC($P(RTAPL,"^",8),DUZ)):1,1:0) W !!?3,*7,"...you are not authorized to use this option" Q
 I '$D(RTDIV) D DIV1^RTPSET I '$D(RTDIV) D MES^RTP4 Q
 K RTB,RT,RTESC S DIC("A")="Select Missing Record: ",DIC(0)="IAEMLZQ",RTSEL="" D ^RTDPA K DIC,RTSEL G Q7:'$D(RT)
 I $D(^RTV(190.2,"AM","s",RT)) S I=+$O(^(RT,0)) D APP G 7
 I $D(^RTV(190.2,"AM","m",RT)) W !!,"This record is already flagged as missing." D FND^RTT2 S X="FOUND RECORD" D TYPE^RTT G 7:'$D(RTMV) D:'$D(^RTV(190.2,"AM","m",RT)) PND K RTMV,RTMV0 G 7
 S RTRD(1)="Yes^flag record as missing",RTRD(2)="No^do not flag record as being missing",RTRD(0)="S",RTRD("B")=2
 S RTRD("A")="Are you sure you want to flag this record as missing? " D SET^RTRD K RTRD G 7:$E(X)'="Y"
 D NOW^%DTC S RTNOW=%,I=$P(^RTV(190.2,0),"^",3)
LOCK S I=I+1 S:$L(I)=4 I=10000 L +^RTV(190.2,I):1 I '$T!$D(^RTV(190.2,I)) L -^RTV(190.2,I) G LOCK
 S ^RTV(190.2,I,0)=RT,^RTV(190.2,"B",RT,I)="",^(0)=$P(^RTV(190.2,0),"^",1,2)_"^"_I_"^"_($P(^(0),"^",4)+1),^DISV($S($D(DUZ)'[0:DUZ,1:0),"^RTV(190.2,")=I L -^RTV(190.2,I)
 D MISS G 7
 ;
MISS S X="MISSING RECORD" D TYPE^RTT I '$D(RTMV) W !!,*7,"ERROR -- record has not been flagged as missing" Q
 S RTB=+$O(^RTV(195.9,"B","2;DIC(195.4,",0)),DA=I,DIE="^RTV(190.2,",DR="[RT MISSING]" D ^DIE K RTNOW,DQ,DE D CHG^RTT Q:$D(Y)
 S XMB="RT MISSING RECORD",RT0=^RT(RT,0),Y=$P(RT0,"^") D NAME^RTB S XMB(1)=Y,XMB(2)=$S($D(^DIC(195.2,+$P(RT0,"^",3),0)):$P(^(0),"^"),1:"UNKNOWN"),XMB(3)=+$P(RT0,"^",7),XMB(4)=$P($P(RTAPL,"^"),";",2)
 S XMB(5)=$S($P(RT0,";",2)["DPT(":"Social Securtiy    : "_$S($D(^DPT(+RT0,0)):$P(^(0),"^",9),1:""),1:" ") K RT0
 D SEND^RTT2 K XMB,M,I W !?3,"...record has been flagged as missing" Q
 ;
Q7 K RTBCIFN,RTMIS,RTMV,RTMV0,RT,RTB,RTESC,T,Y
 K %H,%X,%Y,%YV,D0,DA,DGO,DI,DIC1,DIE,DIYS,DK,DL,DR,DWLW,I1,N,POP,RTC,RTY,X1 Q
APP Q:'$D(^RTV(190.2,I,0))  S RTMIS=I
 S RTRD(1)="Approve^approve the finding of the record",RTRD(2)="Disapprove^disapprove the finding of the record by the user",RTRD(3)="No Action^take no action at this time",RTRD("B")=3,RTRD(0)="S"
 S RTRD("A")="Do you want to approve/disapprove the finding of the record? " D SET^RTRD K RTRD S X=$E(X) G APPQ:X="N"!(X="^")
 I X="A" S X="FOUND RECORD" D TYPE^RTT,FND1^RTT2:$D(RTMV) G APPQ
 D NOW^%DTC S RTNOW=%,I=RTMIS D MISS
APPQ K RTMV,RTMV0,RTMIS Q
 ;
PND D PND^RTRPT S RTWND=2860101 F T=0:0 S T=$O(RTWND(T)) Q:'T  S RTWND(T)=2860101
 D PND^RTT2 K RTWND Q
