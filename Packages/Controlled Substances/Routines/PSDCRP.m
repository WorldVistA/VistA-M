PSDCRP ;BIR/JPW-Green Sheet Discrepancy Report ; 29 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSJ PHARM TECH",DUZ)):1,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to",!,?12,"review this narcotics report.",!!,"PSJ RPHARM or PSJ PHARM TECH security key required.",! K OK Q
ASKD ;ask dispensing location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) ASKN
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: "
 S DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
ASKN ;ask NAOU(s)
 W !!,?5,"You may select a single NAOU, several NAOUs,",!,?5,"or enter ^ALL to select all NAOUs.",!!
 K DA,DIC
 F  S DIC=58.8,DIC("A")="Select NAOU: ",DIC(0)="QEA",DIC("S")="I $P(^(0),""^"",2)=""N"",$P(^(0),""^"",4)=+PSDS" D ^DIC K DIC Q:Y<0  S NAOU(+Y)=""
 I '$D(NAOU)&(X'="^ALL") G END
 I X="^ALL" F PSD=0:0 S PSD=$O(^PSD(58.8,PSD)) Q:'PSD  I $P($G(^PSD(58.8,PSD,0)),"^",2)="N",$P($G(^(0)),"^",4)=+PSDS S NAOU(PSD)=""
DEV ;ask device and queue info
 W !!,"This report is designed for a 132 column format.",!,"You may queue this report to print at a later time.",!!
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDCRP",ZTDESC="CS Green Sheet Discrep Report" S ZTSAVE("PSDS")="" S:$D(NAOU) ZTSAVE("NAOU(")="" D ^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;compile data
 K ^TMP("PSDCRP",$J)
 F PSD=0:0 S PSD=$O(NAOU(PSD)) Q:'PSD  F STAT=3.99:0 S STAT=$O(^PSD(58.81,"AG",STAT)) Q:'STAT!(STAT>6)  F PSDA=0:0 S PSDA=$O(^PSD(58.81,"AG",STAT,PSD,PSDA)) Q:'PSDA  I $D(^PSD(58.81,PSDA,0)),$P(^(0),"^",3)=+PSDS D
 .S NODE=^PSD(58.81,PSDA,0),PSDPN=$S($P(NODE,"^",17)]"":$P(NODE,"^",17),1:"UNKNOWN"),STATN=$P($G(^PSD(58.83,+STAT,0)),"^")
 .S NAOUN=$S($P($G(^PSD(58.8,PSD,0)),"^")]"":$P(^(0),"^"),1:"ZZ/"_PSD) I NAOUN'="UNKNOWN" S NAOUN=$E(NAOUN,1,10)
 .S DRUG=+$P(NODE,"^",5),DRUGN=$S($P($G(^PSDRUG(DRUG,0)),"^")]"":$P(^(0),"^"),1:"ZZ/"_DRUG)
 .S PHARM=$P($G(^PSD(58.81,PSDA,1)),"^",14),PHARMN=$S($P($G(^VA(200,+PHARM,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN") I PHARMN'="UNKNOWN" S PHARMN=$P(PHARMN,",")_","_$E($P(PHARMN,",",2))
 .S NURS=$P($G(^PSD(58.81,PSDA,1)),"^",10),NURSN=$S($P($G(^VA(200,+NURS,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN") I NURSN'="UNKNOWN" S NURSN=$P(NURSN,",")_","_$E($P(NURSN,",",2))
 .S REAS=$P($G(^PSD(58.81,PSDA,1)),"^",15)
 .S PSDST=$P(NODE,"^",19) I PSDST S Y=PSDST X ^DD("DD") S PSDST=Y
 .S ^TMP("PSDCRP",$J,NAOUN,PSDPN,PSDA)=DRUGN_"^"_STATN_"^"_PHARMN_"^"_NURSN_"^"_PSDST_"^"_REAS
PRINT ;print comp stat discrep report
 D NOW^%DTC S Y=X X ^DD("DD") S RPDT=Y
 S (PG,PSDOUT)=0
 K LN S $P(LN,"-",132)="" I '$D(^TMP("PSDCRP",$J)) D HDR W !!,?40,"****  NO PENDING GREEN SHEET DISCREPANCIES  ****",! G DONE
 S PSD="" F  S PSD=$O(^TMP("PSDCRP",$J,PSD)) Q:PSD=""!(PSDOUT)  D HDR W !,?2,"=> ",PSD,! S NUM="" F  S NUM=$O(^TMP("PSDCRP",$J,PSD,NUM)) Q:NUM=""!(PSDOUT)  D
 .F PSDA=0:0 S PSDA=$O(^TMP("PSDCRP",$J,PSD,NUM,PSDA)) Q:'PSDA!(PSDOUT)  D
 ..I $Y+8>IOSL D HDR Q:PSDOUT  W !,?2,"=> ",PSD,!
 ..S NODE=^TMP("PSDCRP",$J,PSD,NUM,PSDA) W !,NUM,?15,$P(NODE,"^"),?58,$P(NODE,"^",5),?80,$P(NODE,"^",2)
 ..W !!,?15,"*RPh: ",$P(NODE,"^",3),?58,"*Comp. by Nurse: ",$P(NODE,"^",4),!
 ..I $P(NODE,"^",6)]"" W ?25,"**Reason Referred: ",$P(NODE,"^",6),!
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END ;
 K %,%DT,%H,%I,%ZIS,C,DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DRUG,DRUGN,DUOUT,LN,NAOU,NAOUN,NODE,NUM,NURS,NURSN
 K OK,PG,PHARM,PHARMN,POP,PSD,PSDA,PSDEV,PSDOUT,PSDPN,PSDS,PSDSN,PSDST,REAS,RPDT,STAT,STATN,X,Y,ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDCRP",$J) D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HDR ;header for log
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF W !,?45,"Green Sheet Discrepancies Report",?115,"Page: ",PG,!,?48,"Date Printed: ",RPDT,!
 W !,?2,"=> NAOU",!,"DISP #",?15,"DRUG",?58,"DATE POSTED",?80,"COMPLETION STATUS"
 W !,LN,!
 Q
