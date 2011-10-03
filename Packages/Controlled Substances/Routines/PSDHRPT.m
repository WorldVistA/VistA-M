PSDHRPT ;BIR/BJW-Destructions Holding file Report ; 3 Mar 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8,71**;13 Feb 97;Build 29
 ;**Y2K compliance** display 4 digit year on va forms
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSJ RPHARM",DUZ))&('$D(^XUSEC("PSD TECH ADV",DUZ))) D  G END
 .W !!,"Please contact your Pharmacy Coordinator for access to",!,"the pending Controlled Substances destruction data.",!!,"PSJ RPHARM or PSD TECH ADV security key required.",!
ASKD ;ask disp location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
ASKV ;ask vault(s)
 W !!,?5,"You may select a single VAULT, several VAULT(s),",!,?5,"or enter ^ALL to select all VAULT(s).",!
 K DA,DIC D NOW^%DTC S (PSDT,Y)=X X ^DD("DD") S RPDT=Y
 F  S DIC=58.8,DIC("A")="Select VAULT: ",DIC(0)="QEA",DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>PSDT:1,1:0),$P(^(0),""^"",2)'=""N"",$P(^(0),""^"",3)=+PSDSITE" D ^DIC K DIC S PSDVAU(+Y)="" Q:Y<0
 I '$D(PSDVAU)&(X'="^ALL") G END
 I X="^ALL" F PSD=0:0 S PSD=$O(^PSD(58.8,PSD)) Q:'PSD  I $S('$D(^PSD(58.8,PSD,"I")):1,'^("I"):1,+^("I")>PSDT:1,1:0),$P($G(^(0)),"^",2)'="N",$P($G(^(0)),"^",3)=+PSDSITE S PSDVAU(PSD)=""
 S JJ=$O(PSDVAU(0)),JJ=$S($O(PSDVAU(JJ)):1,1:2)
 S DIC="^DIC(4,",DR=.01,DA=+$P($G(^XMB(1,1,"XUS")),U,17),DIQ="PSD"
 D EN^DIQ1 K DIC,DR,DIQ
 S PSDSN=$S(JJ=1:PSD(4,DA,.01),1:$P($G(^PSD(58.8,+$O(PSDVAU(0)),0)),U))
 K DA,PSD
DEV ;select device
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDHRPT",ZTDESC="CS PHARM HOLD for DESTROY" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;start looping
 ;1/26/96 CHG L3,added chk for 3-node;dte cancelld
 D NOW^%DTC S Y=X X ^DD("DD") S RPDT=Y
 K LN S (CNT,PG,PSDOUT)=0,$P(LN,"-",132)="" D HDR
 F PSD=0:0 S PSD=$O(^PSD(58.86,PSD)) Q:'PSD  I $D(^PSD(58.86,PSD,0)),$D(PSDVAU(+$P(^(0),"^",7))),'$P(^(0),"^",11)!$D(^PSD(58.86,PSD,3)) S CNT=CNT+1 D PRINT Q:PSDOUT
 I CNT=0 W !!,?10,"*** NO HOLDING FOR DESTRUCTIONS ***",!!
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END ;
 K %I,%ZIS,ALL,C,CNT,DA,DIC,DIR,DIROUT,DIRUT,DRUG,DRUGN,DTOUT,DUOUT,JJ,LN,NODE
 K PG,PHARM,PHARMN,POP,PSD,PSDCD,PSDCYR,PSDCNL,PSDCONT,PSDCOMS,PSDGS,PSDEV,PSDOUT,PSDS,PSDSN,PSDT,PSDTR,PSDYR,PSDVAU,PVAULT,QTY,BAREAS,REAS,RPDT,X,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
PRINT ;print data
 ;58.86(2;1)"PSDCOMS" holds reason drug placed on hold,3/22/95
 ;58.86(3;3)"PSDCNL" " " HLD# was cancelled,12-11-95
 ;58.81(0;16)"BAREAS" " " reason for bal-adj,10-5-95
 ;58.81(3;6)" " " GS# placed on hold
 D:$Y+8>IOSL HDR Q:PSDOUT
 S (PSDCOMS,PSDCNL)=""
 S NODE=^PSD(58.86,PSD,0),DRUG=+$P(NODE,"^",2),PSDTR=$P(NODE,"^",9)
 S PVAULT=$P(NODE,"^",7) I JJ=1 W !,"=> ",$P($G(^PSD(58.8,+PVAULT,0)),U)
 S DRUGN=$S($G(^PSD(58.86,PSD,1))]"":$G(^PSD(58.86,PSD,1))_"*",$P($G(^PSDRUG(+DRUG,0)),"^")]"":$P($G(^PSDRUG(+DRUG,0)),"^"),1:"DRUG NAME MISSING")
 S QTY=$P(NODE,"^",3),PHARM=$P(NODE,"^",4),PHARMN=$P($G(^VA(200,+PHARM,0)),"^") I PHARMN]"" S PHARMN=$E($P(PHARMN,",",2))_$E(PHARMN)
 S PSDT=$P(NODE,"^",6) I PSDT S Y=PSDT X ^DD("DD") S PSDYR=$P(Y,",",2),PSDYR=$E(PSDYR,1,4) S PSDT=$E(PSDT,4,5)_"/"_$E(PSDT,6,7)_"/"_PSDYR
 S PSDCD=$P($G(^PSD(58.86,PSD,3)),"^") I PSDCD S Y=PSDCD X ^DD("DD") S PSDCYR=$P(Y,",",2),PSDCYR=$E(PSDCYR,1,4) S PSDCD=$E(PSDCD,4,5)_"/"_$E(PSDCD,6,7)_"/"_PSDCYR
 S PSDCONT=$P(NODE,"^",8)
 ;The next 2 lines added for E3R# 3771 to print comments 
 S:$D(^PSD(58.86,PSD,2)) PSDCOMS=$P(^(2),"^",1)
 S:'$D(^PSD(58.86,PSD,2)) PSDCOMS=""
 S:$D(^PSD(58.86,PSD,3)) PSDCNL=$P(^(3),"^",3)
 S:'$D(^PSD(58.86,PSD,3)) PSDCNL=""
 S PSDGS="",REAS="",BAREAS=""
 I +PSDTR S PSDGS=$P($G(^PSD(58.81,PSDTR,0)),U,17),REAS=$P($G(^(3)),U,6),BAREAS=$P($G(^(0)),U,16)
 W:$D(^PSD(58.86,PSD,3)) !,PSD,"(C)",?13,DRUGN,?83,PSDCONT,?92,QTY,?102,PSDT,?115,PSDCD,?128,PHARMN,!,?15,"Comments: "
 W:'$D(^PSD(58.86,PSD,3)) !,PSD,?13,DRUGN,?83,PSDCONT,?92,QTY,?102,PSDT,?115,PSDCD,?128,PHARMN,!,?15,"Comments: "
 I $D(PSDCOMS) W ?24,PSDCOMS
 I $D(REAS) W ?24,REAS
 I $D(BAREAS) W ?24,BAREAS
 I $D(PSDCNL) W ?24,PSDCNL
 W ?85,PSDGS,!
 Q
HDR ;prints header information
 ;Modified for E3R# 3771 3/22/95,mod:1/12/96
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF W !,?125,"PAGE: ",PG,!,?42,"DESTRUCTION HOLDING FILE REPORT for ",PSDSN,!,?42,"Run Date: ",RPDT,!,"=> VAULT",!
 W !,"HOLD #",?13,"DRUG",?80,"# OF CONT",?92,"QTY",?102,"TURN IN",?115,"DATE HLD#",?127,"PHARM",!,?15,"COMMENTS",?85,"GS#",?104,"DATE",?115,"CANCELLED",!,LN,!
 Q
SAVE ;4/5/95 added by bjw
 S (ZTSAVE("PSDS"),ZTSAVE("PSDGS"),ZTSAVE("PSDSN"),ZTSAVE("PSDTR"),ZTSAVE("REAS"),ZTSAVE("JJ"),ZTSAVE("BAREAS"),ZTSAVE("PSDCOMS"),ZTSAVE("PSDCNL"))=""
 S:$D(ALL) ZTSAVE("ALL")="" S:$D(PSDVAU) ZTSAVE("PSDVAU(")=""
 Q
