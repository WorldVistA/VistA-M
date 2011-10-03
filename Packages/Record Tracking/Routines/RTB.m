RTB ;TROY ISC/MJK-Entity Lookup ; 3/31/87  12:10 PM ; 1/30/03 8:34am
 ;;2.0;Record Tracking;**29,33**;10/22/91 
IN N RTSEC S Y=-1 Q:'$D(^DIC(195.1,RTA,0))  S RTA0=^(0),RTXZ=X
 I X=" " G Q:'$D(^DISV($S($D(DUZ)'[0:DUZ,1:0),"RT",RTA)) S X=^(RTA) D SPACE^RTB2 G Q
 I $S(X'?.ANP:1,X[".":0,X["?":1,1:0) S Y=-1 Q
 S RTX1=X I $E(X,2)="." D FILE G Q:'$D(RTVP) S RTX=$P(RTX1,".",2,99),RTSTUFF=1 D DIC G Q
 S I=$O(^DD(190,.01,"V","O",0)) I I,'$O(^(I)) S RTVP=+$O(^(I,0)),RTDIC=+^DD(190,.01,"V",RTVP,0) I $D(^DIC(195.1,RTA,"ENTITY","B",RTDIC)) S RTX=RTX1,RTSTUFF=1 D DIC G Q
 S RTX=RTX1,RTSTUFF=0 F RTO=0:0 S X=RTX S RTO=$O(^DD(190,.01,"V","O",RTO)) Q:'RTO  S RTVP=+$O(^(RTO,0)),RTDIC=+^DD(190,.01,"V",RTVP,0) I $D(^DIC(195.1,RTA,"ENTITY","B",RTDIC)) D DIC Q:Y>0!(X="^")
Q I X'["^",Y<0 W:'$G(RTSEC) !?3,"No match found." S X=RTXZ
 S:$P(X,";",2)="DPT(" ^DISV($S($D(DUZ)'[0:DUZ,1:0),"^DPT(")=+X
 K RTXZ,RTVP,F,RTA0,RTSTUFF,RTDIC,RTX,RTX1,RTF1,RTO Q
 ;
DIC S X=RTX,Y=-1,F=RTDIC,DIC=^DIC(F,"0","GL"),RTDIC=$E(DIC,2,99)
 Q:'$D(^DD(190,.01,"V",RTVP,0))  S RTF1=$P(^(0),"^",2),DIC(0)="IEM"_$S($P(^(0),"^",3)="y":"L",1:"") I $P(^(0),"^",5)="y",$D(^(1)) X ^(1)
 I 'RTSTUFF,DIC(0)["E" W !,"Searching for a ",RTF1," "
DIC1 D ^DIC I $E(X)="?" S DIC(0)=DIC(0)_"AQ",DIC("A")="Select "_RTF1_": " G DIC1
 ;
 ;RT*2*33
 I RTDIC="DPT(",Y>0,'$G(DICR) D ^DGSEC I Y<0 S RTSEC=1 K DIC Q
 ;
 K DIC I Y<0 S:X="" X=RTX Q
 ;
 S RTX1=Y G DICQ:RTSTUFF
 S Y=+Y_";"_RTDIC D NAME S $P(RTX1,"^",2)=Y
 S RTRD(0)="S",RTRD(1)="Yes^accept as answer",RTRD(2)="No^reject as answer",RTRD("B")=1,RTRD("A")="Do you want the "_RTF1_" '"_$P(RTX1,"^",2)_"' as your answer? " D SET^RTRD K RTRD I $E(X)'="Y" S Y=-1 Q
DICQ S Y=RTX1,X=+Y_";"_RTDIC,^DISV($S($D(DUZ)'[0:DUZ,1:0),"RT",RTA)=X S:$S('$D(^DIC(195.4,1,"RAD")):0,1:RTA=+^("RAD")) ^DISV($S($D(DUZ)'[0:DUZ,1:0),"^RADPT(")=+X K RTF1,RTX1 Q
 ;
BOR S Y=$S($D(^RTV(195.9,+Y,0)):$P(^(0),"^"),1:"UNKNOWN")
NAME S Z="^"_$P(Y,";",2) I "^DPT(^SC(^VA(200,^DIC(4,^DIC(42,^"[(Z_"^"),$D(@(Z_+Y_",0)")) S Y=$P(^(0),"^") Q
 S RTDNAM=Y D DNAM S Y=RTDNAM S:Y["MISSING RECORD" Y="*** MISSING ***" K %,RTDNAM K %,RTDNAM Q
DNAM S RTDNAM=Y Q:'Y  S %=$P(Y,";",2),RTDNAM="^"_%_+Y_",0)" S RTDNAM=$S($D(@RTDNAM)#2:$P(^(0),U,1),1:Y),%=$S($D(@("^"_%_"0)")):$P(^(0),U,2),1:"") Q:%=""
 I %["P"!(%["S")!(%["D") S C=$P(^DD(+%,.01,0),U,2),Y=RTDNAM D Y^DIQ S RTNAM=Y Q
 Q
 ;S:$D(DIY) RTZ("DIY")=DIY S DIY=Y D NAME^DICM2 S Y=DINAME K DINAME S:Y["MISSING RECORD" Y="*** MISSING ***" S:$D(RTZ("DIY")) DIY=RTZ("DIY") K RTZ("DIY") Q
 ;S DINAME=DIY Q:'DIY  S %=$P(DIY,";",2),DINAME="^"_%_+DIY_",0)",DINAME=$S($D(@DINAME)#2:$P(^(0),U,1),1:DIY),%=$S($D(@("^"_%_"0)")):$P(^(0),U,2),1:"") Q:%=""
 ;I %["P"!(%["S")!(%["D") S C=$P(^DD(+%,.01,0),U,2),%YYY=DIY,%YY=Y,Y=DINAME D Y^DIQ S DINAME=Y,DIY=%YYY,Y=%YY,C="," K %YY,%YYY
 ;
ASK K RTESC I '$D(^DIC(195.1,RTA,0)) S Y=-1 Q
 S Y=$S($D(^DIC(195.1,RTA,3)):^(3),1:"") W !!,$S($P(Y,"^",1)]"":$P(Y,"^",1),1:"Enter Selection: ") R X:DTIME I X["^"!(X="") S X="^",Y=-1,RTESC="" Q
 I $E(X)="?" D ENTITY^RTB2 K RTY G ASK
 G IN
 ;
FILE K RTVP S X=$P(X,"."),DIC("S")="I $D(^DIC(195.1,RTA,""ENTITY"",""B"",+^(0)))",DIC(0)="IM",DIC="^DD(190,.01,""V""," D ^DIC K DIC I Y<0 S X=RTX1 Q
 S RTVP=+Y,RTDIC=+$P(Y,"^",2) Q
 ;
 ;S T=0 F  S T=$O(^RTV(195.9,T)) Q:'T  S Y=$P(^(T,0),U) D NAME^RTB W !,Y H:'$L(Y) 2 H:Y["***" 1 H:Y["(" 2
 Q
 ;S T=0 F  S T=$O(^RT(T)) Q:'T  S Y=$P(^(T,0),U) D NAME^RTB W !,Y H:'$L(Y) 2 H:Y["***" 1 H:Y["(" 2
 Q
