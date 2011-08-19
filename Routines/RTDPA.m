RTDPA ;TROY ISC/MJK - Record File Look-up ; 5/19/87  11:21 AM ; 5/23/03 4:41am
 ;;2.0;Record Tracking;**22,39,41**;10/22/91
 S DIC("S")="I $P(^(0),U,4)=+RTAPL,$S('$D(RTTY):1,$P(^RT(+Y,0),U,3)=+RTTY:1,1:0)"
RT K RTESC,RTESC,RTE,RT S:$D(DIC("A")) RTDC("A")=DIC("A") S:$D(DIC("B")) RTDC("B")=DIC("B")
 S DIC="^RT(",RTDC(0)=DIC(0) S:$D(DIC("S")) RTDC("S")=DIC("S") S X1=DIC(0),DIC(0)=$P(X1,"L")_$P(X1,"L",2,99) G RT1:DIC(0)'["A"
ASK W !!,$S($D(RTDC("A")):RTDC("A"),1:"Select Record: ") W:$D(RTDC("B")) RTDC("B"),"// " R X:DTIME I $T,X="",$D(RTDC("B")) S X=RTDC("B")
RT1 K RT1 S RTBCIFN="n",RTXR=X I "^"[$E(X) S RTESC="" G Q1
 I X?.AN1"/"1N.ANP S W=$E(X,1,$L(X)-1),RTOLD=$O(^RT("AOLDBC",W,0)) D CHAR,BCINVLD G Q:Y<0!(C'=$E(X,$L(X))) S RTSN=+W,Y=$S('RTOLD:+$P(W,"/",2),1:RTOLD),RTBCIFN="y" K:RTOLD RTSN K W,RTOLD G NUM
 I X=" " G Q:'$D(^DISV($S($D(DUZ)'[0:DUZ,1:0),"^RT(")) S Y=+^("^RT(") G NUM
 I $E(X)="?" S DIC(0)="IEQ",DIC="^RT(" S:$D(RTDC("S")) DIC("S")=RTDC("S") D ^DIC K DIC G Q
 I X?1N.N!(X?1"`"1N.N),X'?4N S Y=$S($E(X)="`":+$P(X,"`",2),1:X) G NUM
 I RTDC(0)["M",$E(X,1,2)="B."!($E(X,1,2)="b.") S X=$E(X,3,99) G BOR
 K DIC S RTA=+RTAPL D IN^RTB K RTA,DIC G Q:Y<0 S RTE=X
FIND G Q:'$D(RTE) S Y=RTE D NAME^RTB S RTSEL("A")="Select "_Y_"'s Record" D ^RTUTL2 K RTSEL("A") I $D(RTY),RTC=1 S RT=RTY(1) G RTC
 I $D(RTY),RTSEL["S"!(RTSEL["A") G Q1
 I '$D(RTY),$D(RT1) G ASK:RTDC(0)["A",Q1 ;No laygo attempted if there is at least 1 volume for application or type of record
 K RTY,RTC G Q:RTDC(0)'["L"
 I $S($D(DLAYGO):190-(DLAYGO\1),1:1),DUZ(0)'="@",$D(^DIC(190,0,"LAYGO")) F %=1:1 I DUZ(0)[$E(^("LAYGO"),%) G Q:%>$L(^("LAYGO")) Q
 G SET:'$D(RTSHOW) S Y=RTE D NAME^RTB
 S RTRD(1)="Yes^create a new record",RTRD(2)="No^do not create a new record",RTRD(0)="S",RTRD("B")=2,RTRD("A")="Do you want to create a new record for '"_Y_"' ? " D SET^RTRD K RTRD S X=$E(X) G Q:X="N"!(X="^")
SET D TYPE1^RTDPA1:$D(RTTY) I '$D(RTTY) S RTTY=+$P(RTAPL,"^",10) D TYPE^RTDPA1:'$D(^DIC(195.2,RTTY,0)) I $D(^DIC(195.2,RTTY,0)) S Y=RTTY D TYPE1^RTUTL,TYPE1^RTDPA1:$D(RTTY) K RTTY
 G FIND:$D(RT),Q
 ;
NUM I $D(^RT(Y,0)),$S('$D(RTSN):1,RTSN=+$P(^RT(Y,0),"^",2):1,1:0) D SCR I Y S RT=Y,Y=$P(^RT(RT,0),"^") I RTDC(0)["E" D NAME^RTB W "  ",Y,"  " S Y=RT X ^DD(190,0,"ID","WRITE")
 G Q:'$D(RT)
 ;
RTC S RTC=1,(RTY(1),^DISV($S($D(DUZ)'[0:DUZ,1:0),"^RT("))=RT
 S Y=RT_"^"_$P(^RT(RT,0),"^") S:RTDC(0)["Z" Y(0)=^(0)
Q I '$D(RT) W:RTXR'["?"&(RTDC(0)["Q") *7," ??" G ASK:RTDC(0)["A"
Q1 S:'$D(RT) Y=-1 S X=RTXR K RTXR,RTE,RTSN,RT1,RTS,DIC,RTDC Q
 ;
CHAR S C=0,Z="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-. $/+%" F I=1:1:$L(W) S Y=$F(Z,$E(W,I))-2 Q:Y<0  S C=C+Y
 S C=$S(Y'<0:$E(Z,(C#43)+1),1:"") K Z Q
 ;
BCINVLD Q:Y<0!(C=$E(X,$L(X)))
 N Y
 S Y=$P(W,"/",2) Q:'$D(^RT(Y,0))
 Q:$P(W,"/",1)'=$P(^RT(Y,0),U,2)
 I $D(^RT("AOLDBC",W)) S $P(X,"/",2)=$O(^RT("AOLDBC",W,0))_C Q
 I $D(^RT(Y,0)),$S('$D(RTSN):1,RTSN=+$P(^(0),"^",2):1,1:0) D
 .W !,?9,"NAME:" S RT=Y,Y=$P(^RT(RT,0),"^") I RTDC(0)["E" D NAME^RTB W "  ",Y,"  " S Y=RT X ^DD(190,0,"ID","WRITE")
 .W !,?3,*7,"...Please verify the Patient Information.",!?3,*7,"...The BAR CODE ",X," does not match the system.",!,?3,*7,"...Is this the correct Patient?"
 .N % S %=2 D YN^DICN
 .I %=1 N DIE,DR,DA S DIE="^RT(",DA=Y,DR="300////"_W D ^DIE S X=W_C W @IOF,"Select Record:"
 Q
 ;
BOR K DIC S DIC="^RTV(195.9,",DIC("A")="Select Borrower: ",DIC(0)="IEMLQ",DIC("DR")="3////"_+RTAPL,DIC("S")="I $P(^(0),U,3)="_+RTAPL D ^DIC K DIC I Y<0 G ASK:RTDC(0)["A",Q1
 S:$D(RTB) RTZZ("RTB")=RTB S RTZZ("RTSEL")=RTSEL K RTB
 S RTB=+Y,RTASK="",RTSEL=$S(RTSEL["S":"S",1:"") D START^RTRPT2 S:$D(RTZZ("RTB")) RTB=RTZZ("RTB") S RTSEL=RTZZ("RTSEL") K RTZZ I '$D(RTY) G ASK:RTDC(0)["A",Q1
 I RTC=1,$D(RTY(1)) S RT=+RTY(1) G RTC
 G Q1
 ;
SCR I $D(^DD(190,0,"SCR")) S S=^("SCR") I $D(^RT(Y,0)) X S S:'$T Y=0 K S
 I Y,$D(RTDC("S")),$D(^RT(Y,0)) X RTDC("S") S:'$T Y=0
 Q
 ;
BC ; called from 7.5 node of RECORDS file for pre-look-up massage
 ; picks up IEN for consolidated sites based on "AOLDBC" x-ref
 N RTOLD,W,C
 S W=$E(X,1,$L(X)-1),RTOLD=$O(^RT("AOLDBC",W,0))
 D CHAR
 I Y,C=$E(X,$L(X)) S X="`"_$S('RTOLD:+$P(X,"/",2),1:RTOLD)
 Q
 ;
BCDFN ; called from 7.5 node of PATIENT file for pre-look-up massage
 ; picks up IEN for consolidated sites based on "AOLDBC" x-ref
 ; of RECORDS file #190.
 N RTOLD,W,C,IEN,DFN
 S W=$E(X,1,$L(X)-1),RTOLD=$O(^RT("AOLDBC",W,0))
 D CHAR
 I Y,C=$E(X,$L(X)) D
 . S X="`"_$S('RTOLD:+$P(X,"/",2),1:RTOLD)
 . S IEN=$P(X,"`",2)
 . Q:'IEN
 . S DFN=$P($G(^RT(IEN,0)),U,9)
 . S:DFN X="`"_DFN
 Q
