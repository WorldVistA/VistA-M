PSDNTR ;BIR/BJW-CS Transfer Between NAOUs Report ; 11 Feb 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8,71**;13 Feb 97;Build 29
 ;**Y2K compliance**,"P" added to date input string 
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSJ RPHARM",DUZ))&('$D(^XUSEC("PSD TECH ADV",DUZ))) W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to print",!,?12,"CS reports.  PSJ RPHARM or PSD TECH ADV security key required.",! Q
 W !!,"CS Transfer Green Sheets Between NAOUs Report",!!
DATE ;ask date range
 W ! K %DT S %DT="AEP",%DT("A")="Start with Date: " D ^%DT I Y<0 S PSDOUT=1 G END
 S PSDSD=Y D D^DIQ S PSDATE=Y,%DT("A")="End with Date: " D ^%DT I Y<0 S PSDOUT=1 G END
 I Y<PSDSD W !!,"The ending date of the range must be later than the starting date." G DATE
 S PSDED=Y D D^DIQ S PSDATE=PSDATE_"^"_Y,PSDSD=PSDSD-.0001,PSDED=PSDED+.9999
ASKN ;ask NAOU(s)
 W !!,?5,"You may select a single NAOU, several NAOUs,",!,?5,"or enter ^ALL to select all NAOUs.",!
 D NOW^%DTC S PSDT=X K DA,DIC
 F  S DIC=58.8,DIC("A")="Select NAOU: ",DIC(0)="QEA",DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>PSDT:1,1:0),$P(^(0),""^"",2)=""N"",$P(^(0),""^"",3)=+PSDSITE" D ^DIC K DIC Q:Y<0  S NAOU(+Y)=""
 I '$D(NAOU)&(X'="^ALL") G END
 I X="^ALL" F PSD=0:0 S PSD=$O(^PSD(58.8,PSD)) Q:'PSD  I $S('$D(^PSD(58.8,PSD,"I")):1,'^("I"):1,+^("I")>PSDT:1,1:0),$P($G(^(0)),"^",2)="N",$P($G(^(0)),"^",3)=+PSDSITE S NAOU(PSD)=""
DEV ;dev & queue info
 W !!,"This report is designed for a 132 column format.",!,"You may queue this report to print at a later time.",!!
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDNTR",ZTDESC="CS Transfer Between NAOUs Report" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;compile data
 K ^TMP("PSDNTR",$J) S PSDOUT=0
 F PSD=PSDSD:0 S PSD=$O(^PSD(58.81,"ATRN",PSD)) Q:'PSD!(PSD>PSDED)  F PSDA=0:0 S PSDA=$O(^PSD(58.81,"ATRN",PSD,PSDA)) Q:'PSDA  I $D(^PSD(58.81,PSDA,0)),$D(^(7)) D SET
PRINT ;print transfer between naous by date
 S (PG,PSDOUT)=0
 K LN S $P(LN,"-",132)="" D NOW^%DTC S Y=+$E(%,1,12) X ^DD("DD") S RPDT=Y
 I '$D(^TMP("PSDNTR",$J)) D HDR W !!,?45,"****  NO TRANSFER BETWEEN NAOUs DATA FOR THIS REPORT  ****" G DONE
 D HDR
 S PSD="" F  S PSD=$O(^TMP("PSDNTR",$J,PSD)) Q:PSD=""!(PSDOUT)  W !!,?5,"=> ",PSD,! S NUM="" F  S NUM=$O(^TMP("PSDNTR",$J,PSD,NUM)) Q:NUM=""!(PSDOUT)  F PSDA=0:0 S PSDA=$O(^TMP("PSDNTR",$J,PSD,NUM,PSDA)) Q:'PSDA!(PSDOUT)  D
 .D:$Y+5>IOSL HDR Q:PSDOUT
 .S NODE=^TMP("PSDNTR",$J,PSD,NUM,PSDA) W !,NUM,?12,$P(NODE,"^"),?38,$E($P(NODE,"^",4),1,30),?60,$J($P(NODE,"^",3),6),?80,$P(NODE,"^",2),?100,$E($P(NODE,"^",5),1,30)
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END ;
 K %,%DT,%H,%I,%ZIS,DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DRUG,DRUGN,DUOUT,LN,NAOU,NAOUN,NAOUT,NAOUTN,NODE,NODE7,NUM,OK
 K PG,POP,PSD,PSDA,PSDATE,PSDDT,PSDED,PSDOUT,PSDPN,PSDSD,PSDT,QTY,RPDT,TRFD,TRTD,X,Y,ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDNTR",$J) D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HDR ;header for log
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF W !,?35,"CS TRANSFER GREEN SHEETS BETWEEN NAOUs REPORT",?120,"Page: ",PG
 W !,?35,"FOR PERIOD ",$P(PSDATE,"^")," TO ",$P(PSDATE,"^",2)
 W !,?40,"PRINTED ",RPDT,!!,?5,"=> DRUG",!
 W ?16,"DATE",?36,"NAOU",?86,"DATE",?104,"NAOU",!
 W "DISP #",?11,"TRANSFERRED FROM",?32,"TRANSFERRED FROM",?62,"QUANTITY",?82,"TRANSFERRED IN",?100,"TRANSFERRED IN",!,LN,!
 Q
SAVE S (ZTSAVE("PSDSITE"),ZTSAVE("PSDSD"),ZTSAVE("PSDED"),ZTSAVE("PSDATE"))=""
 S:$D(NAOU) ZTSAVE("NAOU(")=""
 Q
SET ;set data for printing
 S NODE=^PSD(58.81,PSDA,0),DRUG=+$P(NODE,"^",5),NAOU=+$P(NODE,"^",18) Q:'$D(NAOU(NAOU))
 S PSDPN=$S($P(NODE,"^",17)]"":$P(NODE,"^",17),1:"UNKNOWN")
 S DRUGN=$S($D(^PSDRUG(DRUG,0)):$P(^(0),"^"),1:"DRUG NAME MISSING")
 S NAOUN=$S($D(^PSD(58.8,NAOU,0)):$P(^(0),"^"),1:"NAOU NAME MISSING")
 S NODE7=^PSD(58.81,PSDA,7),TRFD=+$P(NODE7,"^"),TRTD=+$P(NODE7,"^",4)
 Q:'TRTD!('TRFD)  S Y=TRFD X ^DD("DD") S TRFD=Y
 S Y=TRTD X ^DD("DD") S TRTD=Y
 S NAOUT=+$P(NODE7,"^",3),NAOUTN=$S($D(^PSD(58.8,NAOUT,0)):$P(^(0),"^"),1:"NAOU NAME MISSING")
 S QTY=+$P(NODE7,"^",7)
 S ^TMP("PSDNTR",$J,DRUGN,PSDPN,PSDA)=TRFD_"^"_TRTD_"^"_QTY_"^"_NAOUN_"^"_NAOUTN
 Q
