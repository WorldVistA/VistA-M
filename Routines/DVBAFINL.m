DVBAFINL ;ALB/GTS-557/THM-AUTO-FINALIZE 7131 REQUESTS; 21 JUL 89
 ;;2.7;AMIE;**14**;Apr 10, 1995
 I $D(DUZ)#2=0 W *7,!!,"Your user number is not set.",!! H 3 Q
 I DUZ'>0 W *7,!!,"Your user number is invalid.  Please log off and back on.",!! H 3 Q
 ;
SETUP I '$D(DT) S %DT="",X="T" D ^%DT S DT=Y
 S OPER=$S($D(^VA(200,+DUZ,0)):$P(^(0),U,1),1:"Unknown operator"),CNT=0
 D HOME^%ZIS
 ;
EN W @IOF,!,"AUTOMATIC 7131 FINALIZATION - USER MODE",!!!,"This program will search the entire 7131 file",!,"and FINALIZE all requests that are ready."
ASK W !!,"Do you want to continue" S %=2 D YN^DICN
 I $D(%Y) I %Y["?" W !!,"Enter Y to go ahead and finalize all requests which are ready",!,"or N to exit.",!! H 1 G ASK
 G:%'=1 EXIT S %ZIS="AEQ",%ZIS("A")="Output device: " W ! D ^%ZIS K %ZIS G:POP EXIT
 I $D(IO("Q")) S ZTIO=ION,ZTRTN="EN1^DVBAFINL",ZTDESC="Automatic 7131 Finalization",ZTSAVE("OPER")="",ZTSAVE("CNT")=""
 I $D(IO("Q")) D ^%ZTLOAD W:$D(ZTSK) !!,"Request queued.",!! G EXIT
 ;
EN1 U IO W:(IOST?1"C-".E) @IOF
 W !,"The following Veterans had requests automatically finalized on " S Y=DT X ^DD("DD") W Y,!!
 W "Veteran name",?37,"Soc Sec #",?49,"Admission date",! F LINE=1:1:IOM W "-"
 W !! F DFN=0:0 S DFN=$O(^DVB(396,"B",DFN)) Q:DFN=""  F DA=0:0 S DA=$O(^DVB(396,"B",DFN,DA)) Q:DA=""  D CHK1
 W !!,"Total requests finalized: ",$J(CNT,4,0),!!
 G EXIT
 ;
CHK1 ;check status of each field
 S NOFINAL=0
 I '$D(^DVB(396,DA,1)) W !!,"Bad 7131 record for internal entry # ",DA,"!...Notify IRM!!",! Q
 Q:$P(^DVB(396,DA,1),U,12)'=""
 F ZA=9,11,13,15,17,19,21,23,26,28 I $P(^DVB(396,DA,0),U,ZA)="P" S NOFINAL=1 Q
 Q:NOFINAL=1  I $P(^DVB(396,DA,1),U,7)="P" S NOFINAL=1 Q
 Q:NOFINAL=1
 W $P(^DPT(DFN,0),U,1),?37,$P(^DPT(DFN,0),U,9),?49 S Y=$P(^DVB(396,DA,0),U,4) X ^DD("DD") W Y,! I $Y>55 D HDR
 S DIE="^DVB(396,",DR="25///"_DT_";26///"_OPER D ^DIE
 S CNT=CNT+1 Q
 ;
EXIT I $D(ZTQUEUED)&(OPER'="Auto-finalized") D KILL^%ZTLOAD
 K ZA G KILL^DVBAUTIL
 ;
HDR W @IOF,!,"Automatic 7131 finalization on " S Y=DT X ^DD("DD") W Y,!!
 Q
 ;
ZTM D NOPARM^DVBAUTL2 G:$D(DVBAQUIT) EXIT
 S OPER="Auto-finalized",CNT=0 I '$D(DT) S X="T" D ^%DT S DT=Y
 G EN1
