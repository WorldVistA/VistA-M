DGPMBSAR ;ALB/LM/MJK - RECALC ENTRY POINTS; 16 JAN 91
 ;;5.3;Registration;**85**;Aug 13, 1993
 ;
A D PCHK^DGPMGL I E G ERR^DGPMGL ;  Parameter check
 D RCCK G:'$D(RCCK) Q ;  Check for ReCalc already running
 D PAR^DGPMGL ;  Display parameters
 ;
ASK W ! S %DT("A")="RECALCULATE TOTALS FROM WHICH DATE: ",%DT="APE",%DT(0)=-(DT-1) D ^%DT K %DT G Q:Y'>0
 S RC=+Y,X=$S($P(DGPM("G"),"^",7):$P(DGPM("G"),"^",7),1:+DGPM("G")) ; X=Earliest date ReCalc can be run ;
 I RC<X S Y=X X ^DD("DD") W !!?4,*7,"Can't Recalculate data prior to ",Y,"!" G ASK
 D DEFS
 ;
RPD ;W !!,"Recalculation of patient days could take up to 30 minutes longer per date..."
PR ;W !,"DO YOU WANT TO RECALCULATE PATIENT DAYS" S %=2 D YN^DICN
 ;I %=1!(%=2) S:%=1 REM=1 G QUE
 ;I %=-1 G Q
 ;W !?4,"Answer YES to recalculate patient days or NO to avoid this lengthy process.",!?4,"If you don't recalculate patient days then the appropriate statistical data"
 ;W !?4,"will be calculated based on the prior days remaining totals and the current",!?4,"(recalculation) days actual gains and losses.  Unless you have a lot of"
 ;W !?4,"time on your hands or an obvious error exists recalculation of patient days",!?4,"is not normally recommended.",!
 ;G PR
 ;
QUE ;  Recalculation Queue
 S ZTRTN="GO1^DGPMBSAR",ZTIO="",ZTDESC="BSR RECALCULATION" F I="DGPM(""G"")","RC","RD","PD","REM","GL","BS","TSR","TSRI","DIV","MT","TS","CP","RM","OS","VN","SF","TSD","SNM","RCCK","GLS" S ZTSAVE(I)=""
 K ZTSK D ^%ZTLOAD I $D(ZTSK) D UP43^DGPMBSR W !!,"Request Queued!"
 G Q
 ;
GO1 S DIE="^DG(43,",DA=1,DR="54////@;55////@;56////@" D ^DIE K DIE,DR,DA
GO D DAT,^DGPMBSR
Q K RCCK G DONE^DGPMGLG
 Q
 ;
DAT ; -- get params and chk data
 D DAT^DGPMGL,DEFS S E=0
 I DGPM(0)="" S E=1 G DATQ
 F I=2,3,4,6:1:9 S C=I*.01 I $P(DGPM("G"),U,I)="" S E=1 ; modified re FORUM [#16205729]
DATQ Q
 ;
CLEAN ; -- clean up corrections file
 S DGCDT=0,X=$P(DGPM(0),U,29) I X S X1=DT,X2=-X D C^%DTC S DGCDT=X
 F DGI=0:0 S DGI=$O(^DGS(43.5,DGI)) Q:'DGI!(DGI>DGCDT)  S DA=DGI,DIK="^DGS(43.5," D ^DIK
 K DA,DIK
 F DGCDT=0:0 S DGCDT=$O(^DGS(43.5,"AGL",DGCDT)) Q:'DGCDT!(DGCDT>EGL)  F DGI=0:0 S DGI=$O(^DGS(43.5,"AGL",DGCDT,DGI)) Q:'DGI  S DR=".08///@",DA=DGI,DIE="^DGS(43.5," D ^DIE
 K DR,DA,DIE,DQ,DE,DG,DGCDT
 Q
 ;
WDCHK ; -- chk first ward
 S %=+$O(^DIC(42,"AGL",0)),WD=+$O(^(%,0))
 S X=RC F J=1:1 S X1=X,X2=-1 D C^%DTC Q:X'>EGL!($D(^DG(41.9,WD,"C",X)))
 S RC=X I X'=EGL S X1=X,X2=1 D C^%DTC S RC=X
 K WD,%
 Q
 ;
RCCK ;  Check for ReCalc already running
 K RCCK
 I $P(DGPM("GLS"),"^",3) D RCR^DGPMGL Q  ;  ReCalc running
 I $P(DGPM("GLS"),"^",5),$P(DGPM("GLS"),"^",4),$P(DGPM("GLS"),"^",6)]"" S ZTSK=$P(DGPM("GLS"),"^",4),ZTCPU=$P(DGPM("GLS"),"^",6)
 D ISQED^%ZTLOAD
 I ZTSK(0) S Y=$P(DGPM("GLS"),"^",5) X ^DD("DD") W !,"ReCalc Already Scheduled for ",Y,! Q
 I $P(DGPM("GLS"),"^",5) S Y=$P(DGPM("GLS"),"^",5) X ^DD("DD") W !,"ReCalc appears to be scheduled for ",Y,!,"Do you wish to continue" S %=2 D YN^DICN Q:%=2!(%=-1)  G RCCK:'%
 S RCCK=1
 Q
 ;
DEFS ; -- defaults for recalc
 S %DT="",X="T" D ^%DT K %DT S DT=Y
 S X1=DT,X2=-1 D C^%DTC S RD=X
 S X1=X,X2=-1 D C^%DTC S PD=X
 S (REM,GL,BS,TSR)=0
 Q
 ;
VAR ;  RC=ReCalc from date  ;  RD=Report Date ;
 ;  PD=Previous Date  ;  REM=Recalc patient days ;
