PSXCSHI ;BIR/JMB-High Cost Rx Report ;03/11/98  11:01 AM
 ;;2.0;CMOP;**11,38**;11 Apr 97
 ; Reference to ^PSDRUG supported by DBIA #1983
 ;This routine compiles data for Rx's that cost over a specified dollar
 ;amount for a specified date range.
BEG W ! S %DT("A")="Beginning Date: ",%DT="APE" D ^%DT G:"^"[X EXIT G:Y<0 BEG S (%DT(0),PSXBDT)=Y
 I Y>DT W !!,"Future Dates are not allowed!",! K %DT G BEG
EN W ! S %DT("A")="Ending Date: " D ^%DT G:"^"[X EXIT G:Y<0 EN S PSXEDT=Y
 S:$E(PSXBDT,6,7)="00" PSXBDT=$E(PSXBDT,1,5)_"01" S:$E(PSXEDT,6,7)="00" PSXEDT=$E(PSXEDT,1,5)_"31"
 ;If no data in file, write error msg.
 S PSXFND=$O(^PSX(552.4,"AD",PSXBDT-1))
 I PSXFND>PSXEDT!(+PSXFND=0) S Y=PSXBDT X ^DD("DD") S PSXSDATE=Y,Y=PSXEDT X ^DD("DD") S PSXEDATE=Y
 I  W !!?4,"** There is no prescription data between "_PSXSDATE_" and "_PSXEDATE_". **" K PSXEDATE,PSXFND,PSXSDATE G EXIT
FACYN ;Gets facility
 K ^UTILITY("DIQ1",$J)
 W ! S DIR("A")="Print data for a specific facility",DIR("B")="Y",DIR(0)="Y" D ^DIR K DIR G:$G(DIRUT) EXIT G:'Y MAX
FAC K PSXEDATE,PSXSDATE S DIC(0)="AEQMZ",DIC="^DIC(4,",DIC("A")="Select FACILITY: " D ^DIC K DIC G:$G(DTOUT)!($G(DUOUT)) EXIT
 G:Y<0 FAC S XSITE=X,DA=+Y K Y
 S DIC=4,DIQ(0)="I",DR="99" D EN^DIQ1
 S PSXFAC=$G(^UTILITY("DIQ1",$J,4,DA,99,"I"))
 I 'PSXFAC S DA(1)=DA,DA=1,IENS=DA_","_DA(1),PSXFAC=$$GET1^DIQ(4.9999,IENS,.02) I +PSXFAC S PSXFAC=1_PSXFAC ;****DOD L1
 K ^UTILITY("DIQ1",$J)
 I '$D(^PSX(552.5,PSXFAC,0)) W !,"There is no data for "_XSITE G FACYN
MAX ;Gets lowest $ amt to print
 W ! S DIR("A")="Dollar Limit (Minimum Total Cost) ",DIR("B")=30,DIR(0)="N^0:9999:2",DIR("?")="Enter a dollar amount between 0-9999 with no more than two decimals"
 D ^DIR K DIR G:$G(DIRUT) EXIT S PSXMAX=Y
DEV ;Device handling
 W ! S PSXION=ION,%ZIS="QM" D ^%ZIS K %ZIS I POP S IOP=PSXION D ^%ZIS K IOP,PSXION W !,"Please try later!" G EXIT
 K PSXION I $D(IO("Q")) S ZTDESC="CMOP High Cost Report",ZTRTN="START^PSXCSHI" F PSXG="PSXBDT","PSXEDT","PSXFAC","PSXMAX" S:$D(@PSXG) ZTSAVE(PSXG)=""
 I  K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !,"Report is queued!" K ZTSK G EXIT
START ;Queued entry point
 S Y=PSXBDT X ^DD("DD") S PSXBDTR=Y,Y=PSXEDT X ^DD("DD") S PSXEDTR=Y
 ;Loops thru date range
 F PSXDT=PSXBDT-1:0 S PSXDT=$O(^PSX(552.4,"AD",PSXDT)) Q:'PSXDT!(PSXDT>PSXEDT)  F PSXIEN=0:0 S PSXIEN=+$O(^PSX(552.4,"AD",PSXDT,PSXIEN)) Q:'PSXIEN  D
 .F PSXSUB=0:0 S PSXSUB=$O(^PSX(552.4,"AD",PSXDT,PSXIEN,PSXSUB)) Q:'PSXSUB  D CHK
 U IO S PSXCNT=0,PSXPG=1,PSXFAC=$S(+$G(PSXFAC):+PSXFAC,1:$O(^TMP($J,0))) D NOW^%DTC S Y=% D DD^%DT S PSXPDT=Y
 ;If no data, print report with error msg.
 I '$D(^TMP($J)) D HD^PSXCSHI1 W !!,"<<< NO HIGH COST DATA FOUND. >>>" G EXIT
 D PRINT^PSXCSHI1
EXIT I $G(IOST)["C-" S DIR(0)="E" D ^DIR K DIR,DIRUT,DTOUT,DIROUT,DUOUT W @IOF
 W ! W:$E(IOST)'["C" @IOF D ^%ZISC G END^PSXCSUTL
CHK ;Sets ^TMP global
 Q:'$D(^PSX(552.4,PSXIEN,0))!($P($G(^PSX(552.4,PSXIEN,1,PSXSUB,0)),"^",2)=2)!($P($G(^PSX(552.4,PSXIEN,1,PSXSUB,0)),"^",4)="")
 I $D(PSXFAC) Q:+PSXFAC'=+$G(^PSX(552.1,+^PSX(552.4,PSXIEN,0),0))
 S PSXNODE=^PSX(552.4,PSXIEN,1,PSXSUB,0),PSXRXN=$P(PSXNODE,"^"),PSXFL=$P(PSXNODE,"^",12),PSXID=$P(PSXNODE,"^",4),PSXQTY=$P(PSXNODE,"^",13),PSXDRCST=$P(PSXNODE,"^",11),PSX50=+$O(^PSDRUG("AQ1",PSXID,0))
 Q:'PSX50!('$D(^PSDRUG(PSX50,0)))  S PSXDR0=^(0)
 I 'PSXDRCST S PSXDRCST=$S($P($G(^PSDRUG(PSX50,660)),"^",6):+$P(^(660),"^",6),1:0)
 S PSXCOST=PSXQTY*PSXDRCST Q:PSXCOST<PSXMAX
 S ^TMP($J,$S($G(PSXFAC):+PSXFAC,1:+$G(^PSX(552.1,+^PSX(552.4,PSXIEN,0),0))),$E($P(PSXDR0,"^"),1,34),PSXRXN,PSXIEN)=PSXFL_"^"_PSXQTY_"^"_PSXDRCST_"^"_PSXCOST
 Q
