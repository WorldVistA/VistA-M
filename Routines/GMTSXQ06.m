GMTSXQ06 ; SLC/JER - XQORM for Export w/Health Summary ;1/10/92  15:01
 ;;2.5;Health Summary;;Dec 16, 1992
XQORM ; SLC/KCM - Menu Utility ; 5/2/89  14:52 ;
 ;;6.52;Copyright 1990, DVA;
 ;From: XQOR  Entry: XQORM,{X}  Exit: X,Y,XQORM,{DIROUT}
EN K Y S Y=-1 Q:$D(XQORM)'=11  Q:XQORM'?1.N.1P.N1";".1"%"1.A1"(".ANP  Q:'$D(@("^"_$P(XQORM,";",2)_+XQORM_",99)"))  Q:$D(XQORM(0))["0"
 I $D(^XUTL("XQORM",XQORM,0)),$P(^(0),"^",1)'=$P(@("^"_$P(XQORM,";",2)_+XQORM_",99)"),"^",1) D XREF
 I '$D(^XUTL("XQORM",XQORM,0)) D XREF Q:Y<0
 L ^XUTL("XQORM",XQORM,"XQORM PROTECT",$J):30 E  W !,"Can't access menu at this time - try again later." S Y=-1 Q
 S:$D(X)[0 X="" S ORUSV=X I $S('$D(IOM):1,'$D(IOF):1,'$D(IOST):1,'IOM:1,1:0) S IOP=$S($D(ORIO):ORIO,1:"HOME") D ^%ZIS S X=ORUSV
 S (DX,DY)=0 X ^%ZOSF("XY") I $D(XQORM("H")),$L(XQORM("H")) X XQORM("H")
 S X=ORUSV D:XQORM(0)["D" DISP^XQORM1 W !
 F ORU=0:0 D:XQORM(0)["A" PRMT^XQORM1 S Y=-1 Q:'$L(X)!(X="^")!(X="^^")  D EN^XQORM2 Q:Y'<0!(XQORM(0)'["A")
 L  K DX,DY,J,ORU,ORULT,ORUSV Q
XREF N X S Y=-1 S:'$D(ORULT) ORULT=2
 I $P(XQORM,";",2)="DIC(19," D X19 Q
 S DIE="^"_$P(XQORM,";",2),DA=+XQORM,DR="99///"_$H
 L (^XUTL("XQORM",XQORM),@(DIE_DA_")")):ORULT E  S Y=-1 K DIE,DA Q
 D ^DIE S Y=1 K DIC,DIE,DA,DR,D,D0,DI,DQ
 L  Q
X19 L (^XUTL("XQORM",XQORM),^DIC(19,+XQORM)):ORULT E  S Y=-1 Q
 S DA=+XQORM D SET^XQORMX K DA S Y=1
 L  Q
