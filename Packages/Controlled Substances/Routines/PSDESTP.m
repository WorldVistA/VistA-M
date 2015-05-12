PSDESTP ;BIR/BJW-Destroyed CS Drugs Report ; 28 Feb 98
 ;;3.0;CONTROLLED SUBSTANCES ;**8,62,71,75**;13 Feb 97;Build 2
 ;**Y2K compliance**,"P" added to date input string 2/9/98
 ;*Y2K* chg to print four digit year in body of report
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSJ RPHARM",DUZ))&('$D(^XUSEC("PSD TECH ADV",DUZ))) D  G END
 .W !!,"Please contact your Pharmacy Coordinator for access to",!,"the pending Controlled Substances destruction data.",!!,"PSJ RPHARM or PSD TECH ADV security key required.",!
ASKD ;ask disp location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
ASKV ;ask vault(s)
 W !!,?5,"You may select a single VAULT, several VAULT(s),",!,?5,"or enter ^ALL to select all VAULT(s).",!
 K DA,DIC D NOW^%DTC S (PSDT,Y)=X X ^DD("DD") S RPDT=Y
 F  S DIC=58.8,DIC("A")="Select VAULT: ",DIC(0)="QEA",DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>PSDT:1,1:0),$P(^(0),""^"",2)'=""N"",$P(^(0),""^"",3)=+PSDSITE" D ^DIC K DIC Q:Y<0  S PSDVAU(+Y)=""
ASKV2 ;
 I '$O(PSDVAU(0))&(X'="^ALL") G END
 I X="^ALL" F PSD=0:0 S PSD=$O(^PSD(58.8,PSD)) Q:'PSD  I $S('$D(^PSD(58.8,PSD,"I")):1,'^("I"):1,+^("I")>PSDT:1,1:0),$P($G(^(0)),"^",2)'="N",$P($G(^(0)),"^",3)=+PSDSITE S PSDVAU(PSD)=""
 S JJ=$O(PSDVAU(0)),JJ=$S($O(PSDVAU(JJ)):1,1:2)
 S DIC="^DIC(4,",DR=.01,DA=+$P($G(^XMB(1,1,"XUS")),U,17),DIQ="PSD"
 D EN^DIQ1 S PSD=PSD(4,DA,.01) K DIC,DR,DA,DIQ
 S PSDSN=$S(JJ=1:PSD,1:$P($G(^PSD(58.8,+$O(PSDVAU(0)),0)),U)) K PSD
DRUG ;ask drug
 W !!,?5,"You may select a single drug, several drugs,",!,?5,"or enter ^ALL to select all drugs.",!!
 W ! K DA,DIC
 S PSDS=$O(PSDVAU(0))
 I $O(PSDVAU(PSDS)) D  G SKIP
 .F  S DIC=50,DIC(0)="QEAM",DIC("A")="SELECT DRUG: " D ^DIC K DIC Q:Y<0  S PSDRG(+Y)=""
 F  S DIC("W")="W:$P(^PSDRUG(Y,0),""^"",9) ""   N/F"" I $P(^PSD(58.8,PSDS,1,Y,0),""^"",14)]"""",$P(^(0),""^"",14)'>DT W $C(7),""   *** INACTIVE ***""",DA(1)=+PSDS,DIC(0)="QEAM",DIC="^PSD(58.8,"_PSDS_",1," D ^DIC K DIC Q:Y<0  D
 .S PSDRG(+Y)=""
SKIP I '$D(PSDRG)&(X'="^ALL") G END
 I X="^ALL" S ALL=1
DATE ;ask date range
 W ! K %DT S %DT="AEP",%DT("A")="Start with Date: " D ^%DT I Y<0 S PSDOUT=1 G END
 S PSDSD=Y D D^DIQ S PSDATE=Y,%DT("A")="End with Date: " D ^%DT I Y<0 S PSDOUT=1 G END
 I Y<PSDSD W !!,"The ending date of the range must be later than the starting date." G DATE
 S PSDED=Y D D^DIQ S PSDATE=PSDATE_"^"_Y,PSDSD=PSDSD-.0001,PSDED=PSDED+.9999
DEV ;select device
 W !!,"This report is designed for a 80 column format.",!,"You may queue this report to print at a later time.",!!
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDESTP",ZTDESC="Destroyed CS Drug Report" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;start looping
 K ^TMP("PSDESTP",$J)
 D NOW^%DTC S Y=X X ^DD("DD") S RPDT=Y
 K LN S (CNT,PG,PSDOUT,PSDTOT)=0,$P(LN,"-",80)=""
 F PSD=PSDSD:0 S PSD=$O(^PSD(58.86,"AC",PSD)) Q:'PSD!(PSD>PSDED)   S PSDS=0 F  S PSDS=$O(^PSD(58.86,"AC",PSD,PSDS)) Q:'PSDS  D:$D(PSDVAU(PSDS))
 .F PSDR=0:0 S PSDR=$O(^PSD(58.86,"AC",PSD,PSDS,PSDR)) Q:'PSDR  D
 ..F PSDA=0:0 S PSDA=$O(^PSD(58.86,"AC",PSD,PSDS,PSDR,PSDA)) Q:'PSDA  I $D(ALL)!($D(PSDRG(+PSDR))) D SET
 I $D(ALL) F PSD=PSDSD:0 S PSD=$O(^PSD(58.86,"AD",PSD)) Q:'PSD!(PSD>PSDED)  S PSDS=0 F  S PSDS=$O(^PSD(58.86,"AD",PSD,PSDS)) Q:'PSDS  D:$D(PSDVAU(PSDS))
 .S PSDN="" F  S PSDN=$O(^PSD(58.86,"AD",PSD,PSDS,PSDN)) Q:PSDN=""  F PSDA=0:0 S PSDA=$O(^PSD(58.86,"AD",PSD,PSDS,PSDN,PSDA)) Q:'PSDA  D SET
 I CNT=0 D HDR W !!,?10,"*** NO CONTROLLED SUBSTANCE DESTRUCTIONS ***",!! G DONE
PRINT ;prints data,L-6 added 8/24/95 accum summ.total,10/20/95 chgs made
 D HDR
 F PSDA=0:0 S PSDA=$O(^TMP("PSDESTP",$J,PSDA)) D:'PSDA GTOT Q:'PSDA!(PSDOUT)  D:$Y+12>IOSL HDR Q:PSDOUT  S PSDRN="" F  S PSDRN=$O(^TMP("PSDESTP",$J,PSDA,PSDRN)) Q:PSDRN=""  D 
 .I $Y+12>IOSL D HDR Q:PSDOUT
 .S NODE=^TMP("PSDESTP",$J,PSDA,PSDRN)
 .W !,"HOLDING #: ",PSDA,! S PVAULT=$P(NODE,U,9) W:JJ=1 "=> ",$P($G(^PSD(58.8,+PVAULT,0)),U),! W "Drug: ",PSDRN W ?60 W:$P(NODE,"^",8) "GS #: ",$P(NODE,U,8) W !,"Quantity: ",$P(NODE,"^"),!,"Cost of above Qty: ",$P(NODE,U,11)
 .I $P(NODE,U,10)']"" S PSDTOT=$P(NODE,U,11)+PSDTOT
 .I $P(NODE,U,6)']"" D
 ..W !,"Date Destroyed: ",$P(NODE,U,3),!,"Destroyed By: ",$P(NODE,U,2),!,"Patient Returning Drug: ",$P(NODE,U,10),!
 ..W:$P(NODE,U,4) "Comments: ",$P(NODE,U,4),!!
 ..W:'$P(NODE,U,4) "Comments: ",$P(NODE,U,12),!!
 .I $P(NODE,U,6)]"" D
 ..W !,"Date/Time Cancelled: ",$P(NODE,U,5),!,"Cancelled By: ",$P(NODE,U,6),!,"Patient Returning Drug: ",$P(NODE,U,10),!,"Comments: ",$P(NODE,U,7),!!
DONE ;
 I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W !! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END ;
 K %,%DT,%H,%I,%ZIS,ALL,C,CNT,DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,LN,NODE
 K JJ,PG,PBACOM,PHARM,PHARMC,PHARMN,PHARMNC,POP,PPDU,PSD,PSDA,PSDATE,PSDCD,PSDCOMS,PSDCOM3,PSDED,PSDEV,PSDGS,PSDN,PSDPAT,PSDPATR,PSDPDU,PSDOUT,PSDR,PSDRG,PSDRN,PSDS,PSDTOT,PSDSD,PSDSN,PSDT,PSDTR,PSDVAU,PVAULT,PSDYR,PSDCYR
 K QTY,RPDT,X,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDESTP",$J)
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HDR ;prints header information
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF W !,?70,"PAGE: ",PG,!,?15,"DESTROYED CS DRUGS REPORT for ",PSDSN
 W !,?15,"Period From: ",$P(PSDATE,"^")," to: ",$P(PSDATE,"^",2),!,?15,"Run Date: ",RPDT,!!,"=> VAULT",!,LN,!
 Q
GTOT ;10/20/95 msg added,grand total,inserted 8/24/95
 Q:PSDOUT
 W !!!!?50,"Summary Total: ",PSDTOT
 W !!!?15,"*** Drugs returned by a patient ARE NOT ADDED to Summary Total***"
 Q
SAVE ;saves variables for queueing
 S (ZTSAVE("JJ"),ZTSAVE("PSDSD"),ZTSAVE("PSDED"),ZTSAVE("PSDATE"),ZTSAVE("PSDS"),ZTSAVE("PSDSN"),ZTSAVE("PSDTOT"))=""
 S:$D(ALL) ZTSAVE("ALL")="" S:$D(PSDRG) ZTSAVE("PSDRG(")=""
 S:$D(PSDVAU) ZTSAVE("PSDVAU(")=""
 Q
SET ;sets data;10/20/95 added bal.adj comms. PBACOM
 S CNT=CNT+1
 I '$D(PSDR) S PSDR=""  ;<- JD *62
 S (PSDGS,PBACOM)=""
 S NODE=^PSD(58.86,PSDA,0),PSDRN=$S($G(^PSD(58.86,PSDA,1))]"":$G(^PSD(58.86,PSDA,1))_"*",$P($G(^PSDRUG(+PSDR,0)),"^")]"":$P($G(^PSDRUG(+PSDR,0)),"^"),1:"#"_PSDA_" DRUG NAME MISSING")
 S PSDTR=$P(NODE,"^",9) I +PSDTR S PSDGS=$P($G(^PSD(58.81,PSDTR,0)),U,17),PBACOM=$P($G(^PSD(58.81,PSDTR,0)),U,16)
 S QTY=$P(NODE,"^",3),PHARM=+$P(NODE,"^",10),PHARMN=$S($P($G(^VA(200,PHARM,0)),"^")]"":$P(^(0),"^"),1:"")
 S PPDU=$P($G(^PSDRUG(+PSDR,660)),U,6),PSDPDU=$J(PPDU*QTY,1,3)
 S Y=PSD X ^DD("DD") S PSDYR=$P(Y,",",2)
 S PSDT=$E(PSD,4,5)_"/"_$E(PSD,6,7)_"/"_PSDYR
 S PVAULT=+$P($G(^PSD(58.86,PSDA,0)),"^",7)
 S PSDCOMS=$P($G(^PSD(58.86,PSDA,2)),"^")
 S PSDCD=$P($G(^PSD(58.86,PSDA,3)),"^") I PSDCD S Y=PSDCD X ^DD("DD") S PSDCYR=$P(Y,",",2) S PSDCD=$E(PSDCD,4,5)_"/"_$E(PSDCD,6,7)_"/"_PSDCYR
 S PHARMC=+$P($G(^PSD(58.86,PSDA,3)),"^",2),PHARMNC=$S($P($G(^VA(200,PHARMC,0)),"^")]"":$P(^(0),"^"),1:"")
 S PSDCOM3=$P($G(^PSD(58.86,PSDA,3)),"^",3)
 S PSDPAT=+$P(NODE,"^",13),PSDPATR=$S($P($G(^DPT(PSDPAT,0)),"^")]"":$P(^(0),"^"),1:"")
 S ^TMP("PSDESTP",$J,PSDA,PSDRN)=QTY_"^"_PHARMN_"^"_PSDT_"^"_PSDCOMS_"^"_PSDCD_"^"_PHARMNC_"^"_PSDCOM3_"^"_PSDGS_"^"_PVAULT_"^"_PSDPATR_"^"_PSDPDU_"^"_PBACOM
 Q
