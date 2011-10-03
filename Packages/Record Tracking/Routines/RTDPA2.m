RTDPA2 ;MJK/TROY ISC;Request File Look-up; ; 5/19/87  11:22 AM ; 1/30/03 9:32am
 ;;2.0;Record Tracking;**21,41**;10/22/91
RTQ K RTESC,RTQ S:$D(DIC("A")) RTQDC("A")=DIC("A") S:$D(DIC("B")) RTQDC("B")=DIC("B")
 S RTQSEL=RTSEL,DIC="^RTV(190.1,",RTQDC(0)=DIC(0) S:$D(DIC("S")) RTQDC("S")=DIC("S") S X1=DIC(0),DIC(0)=$P(X1,"^")_$P(X1,"^",2,99) G RTQ1:DIC(0)'["A"
ASK W !!,$S($D(RTQDC("A")):RTQDC("A"),1:"Select Request: ") W:$D(RTQDC("B")) RTQDC("B"),"// " R X:DTIME I $T,X="",$D(RTQDC("B")) S X=RTQDC("B")
RTQ1 S RTXQ=X I "^"[$E(X) S RTESC="" G Q1
 I X?1"REQ"1N.ANP S W=$E(X,1,$L(X)-1) D CHAR^RTDPA G Q:Y<0!(C'=$E(X,$L(X))) S Y=+$P(W,"REQ",2) K W G NUM
 I X=" " G Q:'$D(^DISV($S($D(DUZ)'[0:DUZ,1:0),"^RTV(190.1,")) S Y=+^("^RTV(190.1,") G NUM
 I $E(X)="?" D HELP K RTQ G Q
 I X?1N.N!(X?1"`"1N.N),X'?4N S Y=$S($E(X)="`":+$P(X,"`",2),1:X) G NUM
 I RTQDC(0)["M",$E(X,1,2)="B."!($E(X,1,2)="b.") S X=$E(X,3,99) G BOR
 S RTSEL="",DIC(0)="IEM" D ^RTDPA K RTBCIFN,RTY,RTC,RTSEL,DIC G Q:'$D(RT) S RTSEL=RTQSEL,RTE=$P(Y,"^",2) D RT^RTUTL4 G:'$D(RTY) ASK:RTQDC(0)["A",Q1
 I RTC=1,$D(RTY(1)) S RTQ=+RTY(1) G RTC
 I $D(RTY),RTSEL["S"!(RTSEL["A") G Q1
 K RTY,RTC I RTQDC(0)'["L"!('$D(RT)) G Q
 I $S($D(DLAYGO):190.1-(DLAYGO\1),1:1),DUZ(0)'="@",$D(^DIC(190.1,0,"LAYGO")) F %=1:1 I DUZ(0)[$E(^("LAYGO"),%) G Q:%>$L(^("LAYGO")) Q
 S Y=RTE D NAME^RTB
 S RTRD(1)="Yes^create a new request",RTRD(2)="No^do not create a new request",RTRD(0)="S",RTRD("B")=2,RTRD("A")="Do you want to create a new request for "_Y_"'s "_$S($D(^DIC(195.2,+$P(^RT(RT,0),"^",3),0)):$P(^(0),"^"),1:"UNKNOWN")_" ?"
 D SET^RTRD K RTRD S X=$E(X) G Q:X="N"!(X="^") S RTSHOW="" D SET^RTQ K RTSHOW,RTB,RTINST,RTQDT G RTC
 ;
NUM I $D(^RTV(190.1,Y,0)) S Q0=^(0) X:$D(RTQDC("S")) RTQDC("S") I $T!('$D(RTQDC("S"))) S RTQ=Y I RTQDC(0)["E" S Y=$S($D(^RT(+Q0,0)):$P(^(0),"^"),1:"UNKNOWN") D NAME^RTB W "   ",Y S Y=RTQ D DPA2^RTUTL1
 G Q:'$D(RTQ)
RTC S RTC=1,RTY(1)=RTQ,(^DISV($S($D(DUZ)'[0:DUZ,1:0),"^RTV(190.1,"),RTY(1))=RTQ
 S Y=RTQ_"^"_$P(^RTV(190.1,RTQ,0),"^") S:RTQDC(0)["Z" Y(0)=^(0)
Q I '$D(RTQ) W:RTXQ'["?"&(RTQDC(0)["Q") *7," ??" G ASK:RTQDC(0)["A"
Q1 S:'$D(RTQ) Y=-1 S X=RTXQ K Q0,RTXQ,RTIX,RTS,RTSEL,RTQSEL,DIC,RTQDC Q
 ;
HELP S:$E(X)'["?" X="?" S DIC(0)="IE",DIC="^RTV(190.1," S:$D(RTQDC("S")) DIC("S")=RTQDC("S") D ^DIC K DIC Q
 ;
BOR K DIC S DIC="^RTV(195.9,",DIC("A")="Select Borrower: ",DIC(0)="IEMLQ",DIC("DR")="3////"_+RTAPL,DIC("S")="I $P(^(0),U,3)="_+RTAPL D ^DIC K DIC I Y<0 G ASK:RTQDC(0)["A",Q1
 S:$D(RTB) RTZZ("RTB")=RTB S RTSEL=$S(RTQSEL["S":"S",1:""),RTB=+Y,RTASK="" D START^RTRPT1 S:$D(RTZZ("RTB")) RTB=RTZZ("RTB") K RTZZ I '$D(RTY) G ASK:RTQDC(0)["A",Q1
 I RTC=1,$D(RTY(1)) S RTQ=+RTY(1) G RTC
 G Q1
