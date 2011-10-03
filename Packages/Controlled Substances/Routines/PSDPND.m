PSDPND ;BIR/BJW-Pharm Dispensing Report ; 18 Jun 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8,10**;13 Feb 97
 ;**Y2K compliance**,"P" added to date input string
 ;mod.for nois:tua-0498-32173,start+19
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSJ PHARM TECH",DUZ)):1,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to",!,?12,"print CS reports.",!!,"PSJ RPHARM or PSJ PHARM TECH security key required.",! K OK Q
ASKD ;ask disp loc
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) DATE
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: ",DIC("B")=$P(PSDSITE,U,4)
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
DATE ;ask date range
 W ! K %DT S %DT="AEPX",%DT("A")="Start with Date: " D ^%DT I Y<0 S PSDOUT=1 G END
 S PSDSD=Y D D^DIQ S PSDATE=Y,%DT("A")="End with Date: " D ^%DT I Y<0 S PSDOUT=1 G END
 I Y<PSDSD W !!,"The ending date of the range must be later than the starting date." G DATE
 S PSDED=Y D D^DIQ S PSDATE=PSDATE_"^"_Y,PSDSD=PSDSD-.0001,PSDED=PSDED+.9999
SUM ;if sum only
 K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Do you want to print the summary totals only",DIR("B")="NO"
 S DIR("?",1)="Answer 'YES' to print only the summary totals for this report,",DIR("?")="answer 'NO' to print the report and the summary totals."
 D ^DIR K DIR G:$D(DIRUT) END S SUM=Y
DEV ;dev & queue info
 W !!,"This report is designed for a 132 column format.",!,"You may queue this report to print at a later time.",!!
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDPND",ZTDESC="Pharm Narcotic Disp Report" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;compile data
 K ^TMP("PSDND",$J),^TMP("PSDNDT",$J)
 F PSD=PSDSD:0 S PSD=$O(^PSD(58.81,"AF",PSD)) Q:'PSD!(PSD>PSDED)  F JJ=2,6,7 F PSDA=0:0 S PSDA=$O(^PSD(58.81,"AF",PSD,PSDS,JJ,PSDA)) Q:'PSDA  I $D(^PSD(58.81,PSDA,0)) D
 .S NODE=^PSD(58.81,PSDA,0),PSDPN=$S($P(NODE,"^",17)]"":$P(NODE,"^",17),1:"UNKNOWN")
 .S NAOU=+$P(NODE,"^",18),NAOUN=$S($P($G(^PSD(58.8,NAOU,0)),"^")]"":$P(^(0),"^"),1:"ZZ/"_NAOU) I NAOUN'="UNKNOWN" S NAOUN=$E(NAOUN,1,24)
 .S DRUG=+$P(NODE,"^",5),DRUGN=$S($P($G(^PSDRUG(DRUG,0)),"^")]"":$P(^(0),"^"),1:"ZZ/"_DRUG)
 .S QTY=$P(NODE,"^",6) I $D(^PSD(58.81,PSDA,4)),+$P(^(4),"^",3) S QTY=$P(^(4),"^",3)
 .I JJ=7 S QTY=0 Q:PSDPN="UNKNOWN"
 .I $D(^PSD(58.81,PSDA,5)),+^(5) S QTY=0,NAOUN="CANCELLED"
 .S:'$D(^TMP("PSDNDT",$J,DRUGN)) ^TMP("PSDNDT",$J,DRUGN)=0
 .S ^TMP("PSDNDT",$J,DRUGN)=^TMP("PSDNDT",$J,DRUGN)+QTY Q:SUM
 .I 'PSDPN S PSDPN="W/O 2638",PHARM=+$P(NODE,"^",7)
 .I $D(^PSD(58.81,PSDA,1)) S PHARM=+$P(^(1),"^")
 .S PHARMN=$S($P($G(^VA(200,+PHARM,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN") I PHARMN'="UNKNOWN" S PHARMN=$P(PHARMN,",")_","_$E($P(PHARMN,",",2))
 .S PSDST=$P(NODE,"^",4),PSDDT="" I PSDST S Y=$E(PSDST,1,7) X ^DD("DD") S PSDDT=Y
 .I JJ=6,'$D(^PSD(58.81,PSDA,6)) Q
 .I JJ=6 S PSRX=+$P(^PSD(58.81,PSDA,6),"^"),PSDPN=$S($P(^(6),"^",5)]"":$P(^(6),"^",5),$P($G(^PSRX(PSRX,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN") D
 ..S PSRXP=+$P($G(^PSRX(PSRX,0)),"^",2)
 ..K C S Y=PSRXP,C=$P(^DD(58.81,73,0),"^",2) D Y^DIQ K C
 ..S PSDRXIN=PSRX D VER^PSDOPT
 ..S NAOUN=$S('$O(^PSRX("B",PSDPN,0)):"RX DELETED",$G(PSDSTA)=13:"RX DELETED",PSRXP]"":Y,1:"UNKNOWN"),NAOUN=$E(NAOUN,1,24)
 ..K PSDSTA,PSDRXIN,PSOVR
 .S ^TMP("PSDND",$J,PSDPN,PSDA)=DRUGN_"^"_NAOUN_"^"_QTY_"^"_PSDDT_"^"_PHARMN
PRT D PRINT^PSDPND1
END ;
 K %,%DT,%H,%I,%ZIS,C,DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DRUG,DRUGN,DUOUT,JJ,LN,NAOU,NAOUN,NODE,NUM,OK
 K PG,PHARM,PHARMN,POP,PSD,PSDA,PSDATE,PSDDT,PSDED,PSDEV,PSDOUT,PSDPN,PSRX,PSRXP,PSDS,PSDSD,PSDSN,PSDST,QTY,SUM,X,Y,ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDND",$J),^TMP("PSDNDT",$J) D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE S (ZTSAVE("SUM"),ZTSAVE("PSDSN"),ZTSAVE("PSDS"),ZTSAVE("PSDSD"),ZTSAVE("PSDED"),ZTSAVE("PSDATE"))=""
 Q
