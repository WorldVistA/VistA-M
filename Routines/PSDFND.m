PSDFND ;BIR/JPW-Pharm Filled Not Delivered Report ; 29 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSJ RNURSE",DUZ)):2,$D(^XUSEC("PSJ PHARM TECH",DUZ)):1,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Coordinator for access to",!,?12,"review this narcotics report.",!!,"PSJ RPHARM, PSJ RNURSE, or PSJ PHARM TECH security key required.",! K OK Q
ASKD ;ask dispensing location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) SUM
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: ",DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
SUM ;if summary only
 K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Do you want to print the summary totals only",DIR("B")="NO"
 S DIR("?",1)="Answer 'YES' to print only the summary totals for this report,",DIR("?")="answer 'NO' to print the report and the summary totals."
 D ^DIR K DIR G:$D(DIRUT) END S SUM=Y
DEV ;ask device and queue info
 W !!,"This report is designed for a 132 column format.",!,"You may queue this report to print at a later time.",!!
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=$S($G(OK)=2:"",1:Y)
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDFND",ZTDESC="CS Filled Not Delivered Report" S (ZTSAVE("SUM"),ZTSAVE("PSDS"),ZTSAVE("PSDSN"))="" D ^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;compile data
 K ^TMP("PSDFND",$J),^TMP("PSDFNDT",$J)
 F PSD=0:0 S PSD=$O(^PSD(58.81,"AD",3,PSD)) Q:'PSD  F PSDA=0:0 S PSDA=$O(^PSD(58.81,"AD",3,PSD,PSDA)) Q:'PSDA  I $D(^PSD(58.81,PSDA,0)),$P(^(0),"^",3)=+PSDS D
 .I $D(^PSD(58.81,PSDA,5)),+^(5) Q
 .S NODE=^PSD(58.81,PSDA,0),PSDPN=$S($P(NODE,"^",17)]"":$P(NODE,"^",17),1:"UNKNOWN")
 .S NAOU=+$P(NODE,"^",18),NAOUN=$S($P($G(^PSD(58.8,NAOU,0)),"^")]"":$P(^(0),"^"),1:"ZZ/"_NAOU) I NAOUN'="UNKNOWN" S NAOUN=$E(NAOUN,1,10)
 .S DRUG=+$P(NODE,"^",5),DRUGN=$S($P($G(^PSDRUG(DRUG,0)),"^")]"":$P(^(0),"^"),1:"ZZ/"_DRUG)
 .S QTY=$P(NODE,"^",6) I $D(^PSD(58.81,PSDA,4)),+$P(^(4),"^",3) S QTY=$P(^(4),"^",3)
 .S:'$D(^TMP("PSDFNDT",$J,DRUGN)) ^TMP("PSDFNDT",$J,DRUGN)=0
 .S ^TMP("PSDFNDT",$J,DRUGN)=^TMP("PSDFNDT",$J,DRUGN)+QTY Q:SUM
 .S PHARM=$P($G(^PSD(58.81,PSDA,1)),"^"),PHARMN=$S($P($G(^VA(200,+PHARM,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN") I PHARMN'="UNKNOWN" S PHARMN=$P(PHARMN,",")_","_$E($P(PHARMN,",",2))
 .S PSDST=$P(NODE,"^",4),PSDDT="" I PSDST S Y=$E(PSDST,1,7) X ^DD("DD") S PSDDT=Y
 .S ^TMP("PSDFND",$J,PSDPN,PSDA)=DRUGN_"^"_NAOUN_"^"_QTY_"^"_PSDDT_"^"_PHARMN
PRINT ;print filled not delivered log
 D NOW^%DTC S Y=X X ^DD("DD") S RPDT=Y
 I SUM D ^PSDFND1 G DONE
 S (PG,PSDOUT)=0
 K LN S $P(LN,"-",132)="" I '$D(^TMP("PSDFND",$J)) D HDR W !!,?40,"****  NO PENDING DELIVERIES FOR THIS DISPENSING LOCATION  ****",! G DONE
 D HDR S NUM="" F  S NUM=$O(^TMP("PSDFND",$J,NUM)) Q:NUM=""!(PSDOUT)  D:$Y+4>IOSL HDR Q:PSDOUT  D
 .F PSD=0:0 S PSD=$O(^TMP("PSDFND",$J,NUM,PSD)) Q:'PSD!(PSDOUT)  D:$Y+4>IOSL HDR Q:PSDOUT  S NODE=^TMP("PSDFND",$J,NUM,PSD) W !,NUM,?15,$P(NODE,"^"),?65,$J($P(NODE,"^",3),6),?80,$P(NODE,"^",4),?95,$P(NODE,"^",2),?112,$P(NODE,"^",5)
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR S DIR(0)="EA",DIR("A")="Press <RET> to return to display the summary totals" D ^DIR K DIR I 'Y S PSDOUT=1 G DONE
 D:'PSDOUT ^PSDFND1
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END ;
 K %,%DT,%H,%I,%ZIS,C,DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DRUG,DRUGN,DUOUT,LN,NAOU,NAOUN,NODE,NUM
 K OK,PG,PHARM,PHARMN,POP,PSD,PSDA,PSDDT,PSDEV,PSDOUT,PSDPN,PSDS,PSDSN,PSDST,QTY,RPDT,SUM,X,Y,ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDFND",$J),^TMP("PSDFNDT",$J) D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HDR ;header for log
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF W !,?45,"Narcotics Filled Not Delivered Report",?115,"Page: ",PG,!,?45,"Dispensing Vault: "_PSDSN,!,?56,RPDT,!
 W !!,?65,"QUANTITY",?82,"DATE",?97,"NAOU"
 W !,"DISP #",?15,"DRUG",?65,"DISPENSED",?80,"DISPENSED",?94,"DISPENSED TO",?112,"DISPENSED BY"
 W !,LN,!
 Q
