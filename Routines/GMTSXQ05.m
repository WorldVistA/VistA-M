GMTSXQ05 ; SLC/JER - XQOR4 for Export w/Health Summary ;1/10/92  14:59
 ;;2.5;Health Summary;;Dec 16, 1992
XQOR4 ; SLC/KCM - Process "^^" jump ;3/27/90  16:28 ;
 ;;6.52;Copyright 1990, DVA;
DJMP ;From: STAK^XQOR1
 Q:'$D(^UTILITY("XQORS",$J,XQORS,"ITM",^UTILITY("XQORS",$J,XQORS,"ITM"),"IN"))  S X=$P(^UTILITY("XQORS",$J,XQORS,"ITM",^UTILITY("XQORS",$J,XQORS,"ITM"),"IN"),"^",4,99) D EAT^XQORM1 ;Q:$E(X,1,2)'="^^"
 S X=$P(X,"=",1),D="K.ORWARD",DIC="^ORD(101,",DIC(0)="SE" D IX^DIC K DIC,D
 I Y<0!('$D(^ORD(101,+Y,0))) W:(X'["^")&(X'["?") !!,">>>  ",X," not found or selected.  No action taken." D:(X'["^")&(X'["?") READ S X="" Q
 S ORNSV=+Y
 K X F I=1:1:XQORS I $P(^UTILITY("XQORS",$J,XQORS,"VPT"),";",2)="ORD(101,",$D(^ORD(101,+^UTILITY("XQORS",$J,XQORS,"VPT"),21)) D DJMP1
 S X="" F I=0:0 S X=$O(X(X)) Q:X=""  N @X
 S X=ORNSV_";ORD(101," K ORNSV D EN^XQOR
 Q
DJMP1 F J=0:0 S J=$O(^ORD(101,+^UTILITY("XQORS",$J,XQORS,"VPT"),21,J)) Q:J'>0  I $D(^ORD(101,+^UTILITY("XQORS",$J,XQORS,"VPT"),21,J,0)) S X=^(0) I X?1A.ANP!(X?1"%".ANP) S X(X)=""
 Q
SHDR ;Display sub-header
 Q:'$D(@(^UTILITY("XQORS",$J,XQORS,"REF")_"0)"))  S X=$P(^(0),"^",2) W !!?(36-($L(X)\2)),"--- "_X_" ---"
 Q
READ W !,"Press RETURN to continue: " R X:$S($D(DTIME):DTIME,1:300)
 Q
C19 S X0=@(^UTILITY("XQORS",$J,XQORS,"REF")_"0)"),X=$P(X0,"^",6) I $L(X),'$D(^XUSEC(X,DUZ)) W !!,"This option "_$P(X0,"^")_" is locked.",! D READ S Y=-1 Q
 S ORNSV=$P(X0,"^",9),X="NOW",%DT="T" D ^%DT S X=$P(Y,".",2) I X>$P(ORNSV,"-"),X<$P(ORNSV,"-",2) W !!,"Not Available: ",ORNSV,! K ORNSV D READ S Y=-1 Q
 K ORNSV I "QMOXAL"'[$P(^UTILITY("XQORS",$J,XQORS,"FLG"),"^") W !!,"This option type not supported by 'unwinder' routines.",! D READ S Y=-1 Q
 S Y=1 Q
