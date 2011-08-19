LABERR ; SLC/FHS - ERROR TRAP FOR LABORATORY AUTO INSTRUMENTS  ;11/20/90  09:45
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**42**;Sep 27, 1994
EN ;
 ;^LA("ERR")=Last # used^Time last error^instrument/routine^Total errors todate
 ;^LA("ERR",#,0)=Time^IO^$J^DUZ^Tsk/instrument/routine^ZA^ZB^UCI^ZTSK
 ;^LA("ERR",#,"ER")=Error Description
 ;^LA("ERR",#,"ZR")=0
 ;^LA("ERR",#,"ZTSK")=ZTSK
 ;All local variables are stored in ^%ZTSK(ZTSK
 ; The data is cleared on the third day (midnight) This is the default setting
 ;Field 606 of ^LAB(69.9 allows this time to be site determined (3-30 days)
 ;The Y(x) variable are saved in LABZY(x) and X variable is saved in LABZX
 ;%ZTLOAD PROGRAM KILLS Y(x) VARIABLES.
EN1 ;
 S (LABZA,LABZB,LABZR)=0,LABZE=$$EC^%ZOSV
 S:$D(X)#2 LABZX=X S:$D(Y)#2 LABZY=Y S:$D(%DT)#2 LABZD=%DT S:$D(X1)#2 LABZX1=X1 S:$D(LABZX2)#2 LABZX2=X2 S:$D(X3)#2 LABZX3=X3 S:$D(DT)#2 LABZDT=DT
 S XS="" F Y=0:0 S XS=$O(Y(XS)) Q:XS=""  S LABZY(XS)=Y(XS)
 K XS N I,X,X1,Y,X2,DT,%DT,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S DT=$$DT^XLFDT,SY=$$NOW^XLFDT
 L ^LA("ERR")
 S:'$D(^LA("ERR"))#2 ^LA("ERR")=0 S ERR=+^LA("ERR")
 S:'$D(^LA("ERR","DT",DT)) ^(DT)=0 G:^(DT)>100 FUL S $P(^LA("ERR"),"^",2)=SY
A S ERR=ERR+1 G:$D(^LA("ERR",ERR)) A S $P(^LA("ERR"),U)=ERR,$P(^("ERR"),U,4)=1+$P(^("ERR"),U,4),^LA("ERR","DT",DT)=1+^LA("ERR","DT",DT)
 X ^%ZOSF("UCI") S LABUCI=Y
 S ^LA("ERR",ERR,0)=SY_U_$S($D(IO)#2:IO,$D(ION):ION,$D(IO(0)):IO(0),1:"")_U_$J_U_$S($D(DUZ):DUZ,1:.5)_U_$S($D(LANM):LANM,$D(LRINST):LRINST,$D(TSK):TSK,$D(T):T,1:"???")_U_LABZA_U_LABZB_U_Y
 S ^("ZR")=LABZR,^("ZE")=LABZE
 S $P(^LA("ERR"),U,3)=$P(^LA("ERR",ERR,0),U,5)
 S ^LA("ERR","B",$P(^LA("ERR",ERR,0),U,5),ERR)=""
 L
 S X2=3 I $D(^LAB(69.9,1,"ER"))#2,+^("ER")>0 S X2=^("ER")
 S X1=DT D C^%DTC S ZTDTH=X_".2359",ZTSAVE("*")="",ZTRTN="DQ^LABERR",ZTDESC="CLEAN UP LAB ERROR TRAP",ZTIO=""
LOAD ;
 S:$D(LABZX)#2 X=LABZX S:$D(LABZY)#2 Y=LABZY S:$D(LABZD)#2 %DT=LABZD S:$D(LABZX1)#2 X1=LABZX1 S:$D(LABZX2)#2 X2=LABZX2 S:$D(LABZX3)#2 X3=LABZX3 S:$D(LABZDT)#2 DT=LABZDT
 K ZTSK D ^%ZTLOAD S ZTSK=$S($D(ZTSK):ZTSK,1:"???") S $P(^LA("ERR",ERR,0),U,9)=ZTSK
 S ^LA("ERR",ERR,"ZTSK")=ZTSK
 S ^LA("ERR","C",$P(^(0),U,5),ZTSK)=""
FUL ;
 L  K ERR,X1,X2,ZTSK,ZTDTH,ZTRTN,ZTDESC,ZTIO,%DT,LABZX,LABUCI,LABZY,LABZA,LABZD,LABZX1,LABZX2,LABZX3,LABZB,LABZDT,LABZE,LABZR,SY Q
 Q
 ;
DQ ;Dequeue errors
 S:$D(ZTQUEUED) ZTREQ="@"
 I $D(ERR),$D(^LA("ERR",ERR,0)) S TSK=$S($L($P(^(0),U,5)):$P(^(0),U,5),1:0),T=+$P(^(0),".") K ^LA("ERR",ERR),^LA("ERR","B",TSK,ERR) I $P(^LA("ERR"),U,4)>0 S $P(^("ERR"),U,4)=$P(^("ERR"),U,4)-1
 I $D(TSK),$D(ZTSK) K ^LA("ERR","C",TSK,ZTSK)
 I $D(T),$D(^LA("ERR","DT",T))#2 S:^(T)>0 ^(T)=^(T)-1 I ^(T)=0 K ^(T)
 Q
