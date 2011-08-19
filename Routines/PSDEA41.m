PSDEA41 ;BIR/BJW/DJE-Destroyed CS Drugs DEA 41 Report ; 15 JAN 96
 ;;3.0; CONTROLLED SUBSTANCES ;**12,71**;13 Feb 97;Build 29
 ;
 ; Reference to PSDRUG( DBIA # 221
 ;
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSJ RPHARM",DUZ))&('$D(^XUSEC("PSD TECH ADV",DUZ))) D  G END
 .W !!,"Please contact your Pharmacy Coordinator for access to",!,"the pending Controlled Substances destruction data.",!!,"PSJ RPHARM or PSD TECH ADV security key required.",!
ASKD ;ask disp location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
ASKV ;ask vault(s),added 8/9/95
 W !!,?5,"You may select a single VAULT, several VAULT(s),",!,?5,"or enter ^ALL to select all VAULT(s).",!
 K DA,DIC D NOW^%DTC S (PSDT,Y)=X X ^DD("DD") S RPDT=Y
 F  S DIC=58.8,DIC("A")="Select VAULT: ",DIC(0)="QEA",DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>PSDT:1,1:0),$P(^(0),""^"",2)'=""N"",$P(^(0),""^"",3)=+PSDSITE" D ^DIC K DIC S PSDVAU(+Y)="" Q:Y<0
 I '$D(PSDVAU)&(X'="^ALL") G END
 ; Patch PSD*3*12
 ; Removal of the following code that checks for the presence of a vault
 ; after a certain date ie. inactivated vaults. Removed code:
 ; $S('$D(^PSD(58.8,PSD,"I")):1,'^("I"):1,+^("I")>PSDT:1,1:0),1:0)
 ; Old code:
 ;I X="^ALL" F PSD=0:0 S PSD=$O(^PSD(58.8,PSD)) Q:'PSD  I $S('$D(^PSD(58.8,PSD,"I")):1,'^("I"):1,+^("I")>PSDT:1,1:0),$P($G(^(0)),"^",2)'="N",$P($G(^(0)),"^",3)=+PSDSITE S PSDVAU(PSD)=""
 I X="^ALL" F PSD=0:0 S PSD=$O(^PSD(58.8,PSD)) Q:'PSD  I $P($G(^PSD(58.8,PSD,0)),"^",2)'="N",$P($G(^(0)),"^",3)=+PSDSITE S PSDVAU(PSD)=""
 S JJ=$O(PSDVAU(0)),JJ=$S($O(PSDVAU(JJ)):1,1:2)
 S DIC="^DIC(4,",DR=.01,DA=+$P($G(^XMB(1,1,"XUS")),U,17),DIQ="PSD"
 D EN^DIQ1 S PSD=PSD(4,DA,.01) K DIC,DR,DA,DIQ
 S PSDSN=$S(JJ=1:PSD,1:$P($G(^PSD(58.8,+$O(PSDVAU(0)),0)),U)) K PSD
DEV ;select device
 W !!,"This report is designed for a 80 column format.",!,"You may queue this report to print at a later time.",!!
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDEA41",ZTDESC="Destroyed CS Drug Report for DEA Form 41" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;start looping
 K ^TMP("PSDEA41",$J)
 D NOW^%DTC S Y=X X ^DD("DD") S RPDT=Y
 K LN S (CNT,PG,PSDOUT)=0,$P(LN,"-",80)="" D HDR
 F PSDA=0:0 S PSDA=$O(^PSD(58.86,PSDA))  Q:'PSDA  I $D(^PSD(58.86,PSDA,0)),$D(PSDVAU(+$P(^(0),"^",7))),'$P(^(0),"^",11),'$D(^PSD(58.86,PSDA,3)) D SET
 I CNT=0 W !!,?10,"*** NO CONTROLLED SUBSTANCE DESTRUCTIONS ***",!! G DONE
PRINT ;prints data
 D SIG G:PSDOUT DONE
 F PSDA=0:0 S PSDA=$O(^TMP("PSDEA41",$J,PSDA)) Q:'PSDA  D  Q:PSDOUT
 .D:$Y+4>IOSL HDR Q:PSDOUT
 .S NODE=^TMP("PSDEA41",$J,PSDA) W !,PSDA,?10,$P(NODE,"^"),?55,$J($P(NODE,"^",2),3),?60,$J($P(NODE,"^",3),6),?69,$P(NODE,"^",4)
 I 'PSDOUT D:$Y+4>IOSL HDR W !!,?25,"END OF REPORT!!",!
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END ;
 K %,%DT,%H,%I,%ZIS,ALL,C,CNT,CONT,DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,JJ,KK,LN,NODE
 K PG,POP,PSD,PSDA,PSDT,PSDATE,PSDED,PSDEV,PSDN,PSDOUT,PSDR,PSDRN,PSDS,PSDSD,PSDSN,PSDVAU,QTY,RPDT,UNIT,X,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDEA41",$J)
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HDR ;prints header information
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF W !,?15,"DESTROYED CS DRUGS REPORT for DEA FORM 41",?70,"PAGE: ",PG
 W !,?15,"Dispensing Site: ",PSDSN,!,?15,"Printed: ",RPDT
 W !,?55,"# OF",!,"HOLD #",?10,"DRUG",?55,"CONT",?63,"QTY",?69,"UNIT",!,LN,!
 Q
SAVE ;saves variables for queueing
 S (ZTSAVE("PSDS"),ZTSAVE("PSDSN"),ZTSAVE("JJ"))=""
 S:$D(ALL) ZTSAVE("ALL")="" S:$D(PSDVAU) ZTSAVE("PSDVAU(")=""
 Q
SIG ;print signature lines
 W !!!,?23,"Date: _____________________________________",!!!,?15,"Destroyed By: _____________________________________",!
 F KK=1:1:2 W !!,?15,"Witnessed By: _____________________________________",!
 W !
 Q
SET ;sets data
 S CNT=CNT+1
 S NODE=^PSD(58.86,PSDA,0),PSDR=+$P(NODE,"^",2)
 S PSDRN=$S($G(^PSD(58.86,PSDA,1))]"":$G(^PSD(58.86,PSDA,1))_"*",$P($G(^PSDRUG(+PSDR,0)),"^")]"":$P($G(^PSDRUG(+PSDR,0)),"^"),1:"#"_PSDA_" DRUG NAME MISSING")
 S QTY=$P(NODE,"^",3),CONT=$P(NODE,"^",8),UNIT=$P(NODE,"^",12)
 S ^TMP("PSDEA41",$J,PSDA)=PSDRN_"^"_CONT_"^"_QTY_"^"_UNIT
 Q
