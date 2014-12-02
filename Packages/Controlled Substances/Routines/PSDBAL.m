PSDBAL ;BIR/JPW - Display/Print Current Drug Balance ;29 Aug 94
 ;;3.0;CONTROLLED SUBSTANCES;**73**;13 Feb 97;Build 8
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSJ RPHARM",DUZ))&('$D(^XUSEC("PSD TECH",DUZ))) W !!,"Contact your Pharmacy Coordinator for access to display current CS drug",!,"balances.",!!,"PSJ RPHARM or PSD TECH security key required.",! Q
ASKD ;ask disp location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) CHKD
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: "
 S DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
CHKD I '$O(^PSD(58.8,PSDS,1,0)) W !!,"There are no CS stocked drugs for your dispensing vault.",!! G END
DRUG ;ask schedule/drug
 W !,"Select Schedule/Drug"
 N DIR,I,J,K
 S DIR(0)="S^1:SCHEDULES I - II;2:SCHEDULES III - V;3:SCHEDULES I - V;4:INDIVIDUAL DRUG",DIR("A")="Select Schedule(s)",DIR("B")=3
 D ^DIR
 I $D(DIRUT) G END
 K SCH S SCH=+Y I SCH<4 D  G DEV
 .S I=$S(Y=2:3,1:1),J=$S(Y=1:2,1:5) F K=I:1:J S SCH(K)=""
 W !!,?5,"You may select a single drug, several drugs,",!,?5,"or enter ^ALL to select all drugs.",!
 W ! K DA,DIC
 F  S DIC("W")="W:$P(^PSDRUG(Y,0),""^"",9) ""   N/F"" I $P(^PSD(58.8,PSDS,1,Y,0),""^"",14)]"""",$P(^(0),""^"",14)'>DT W $C(7),""   *** INACTIVE ***""",DA(1)=+PSDS,DIC(0)="QEAM",DIC="^PSD(58.8,"_PSDS_",1," D ^DIC K DIC Q:Y<0  D
 .S PSDR(+Y)=""
 S X=$$UP^XLFSTR(X)
 I '$D(PSDR)&(X'="^ALL") G END
 I X="^ALL" S ALL=1
DEV ;sel device
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 W ! K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS I POP W !!,"NO DEVICE SELECTED OR REPORT PRINTED!!",! G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDBAL",ZTDESC="CS PHARM List Stock Balances" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;entry for compile
 K ^TMP("PSDBAL",$J)
 I $D(ALL)!$G(SCH)<4 F PSD=0:0 S PSD=$O(^PSD(58.8,+PSDS,1,PSD)) Q:'PSD  I $D(^PSD(58.8,+PSDS,1,PSD,0)) D
 .S DEA=+$P($G(^PSDRUG(PSD,0)),"^",3)
 .I '$D(ALL) Q:'$D(SCH(DEA))
 .S PSDR(+PSD)=""
 F PSD=0:0 S PSD=$O(PSDR(PSD)) Q:'PSD  I $D(^PSD(58.8,+PSDS,1,PSD,0)) S NODE=^(0) D
 .S PSDOK="" I +$P(NODE,"^",14),+$P(NODE,"^",14)'>DT Q:'+$P(NODE,"^",4)  S PSDOK="*"
 .S BAL=+$P(NODE,"^",4),PSDRN=$S($P($G(^PSDRUG(+PSD,0)),"^")]"":$P(^(0),"^"),1:"ZZ/"_PSD_" NAME MISSING"),EXP=$S(+$P(NODE,"^",12):+$P(NODE,"^",12),1:"")
 .I EXP S Y=EXP X ^DD("DD") S EXP=Y
 .S ^TMP("PSDBAL",$J,PSDRN,PSD)=BAL_"^"_PSDOK_"^"_EXP_"^"_$P($G(^PSDRUG(+PSD,0)),"^",3)
PRINT ;prints data
 S (PG,PSDOUT)=0 D NOW^%DTC S Y=+$E(%,1,12) X ^DD("DD") S RPDT=Y
 K LN S $P(LN,"-",80)="" D HDR
 I '$D(^TMP("PSDBAL",$J)) W !!,?15,"**** NO STOCK BALANCE DATA AVAILABLE ****",!! G DONE
 S PSDR="" F  S PSDR=$O(^TMP("PSDBAL",$J,PSDR)) Q:PSDR=""!(PSDOUT)  F PSD=0:0 S PSD=$O(^TMP("PSDBAL",$J,PSDR,PSD)) Q:'PSD  D
 .D:$Y+4>IOSL HDR Q:PSDOUT
 .S NODE=^TMP("PSDBAL",$J,PSDR,PSD),BAL=+NODE,PSDOK=$P(NODE,"^",2),EXP=$P(NODE,"^",3)
 .W !,PSDOK,?2,PSDR,?53,$$SCH(+$P(NODE,"^",4)),?63,$J(BAL,6),! W:EXP]"" ?5,"Expiration Date: ",EXP,!
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END ;
 K %,%H,%I,%ZIS,ALL,BAL,C,DA,DIC,DTOUT,DUOUT,EXP,LN,NODE,PG,POP,PSD,PSDEV,PSDOK,PSDOUT,PSDR,PSDRN,PSDS,PSDSN,RPDT,X,Y,DEA
 K ^TMP("PSDBAL",$J),ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE S (ZTSAVE("PSDS"),ZTSAVE("PSDSN"),ZTSAVE("PSDSITE"),ZTSAVE("SCH"),ZTSAVE("SCH("))=""
 S:$D(ALL) ZTSAVE("ALL")="" S:$D(PSDR) ZTSAVE("PSDR(")=""
 Q
HDR ;header
 I $E(IOST,1,2)="C-",PG K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF W !,?12,"Current Stock Balances for ",PSDSN,?72,"Page: ",PG,!,?20,$S(SCH=1:"Schedules I - II",SCH=2:"Schedules III - V",SCH=3:"Schedules I - V",1:""),!?20,RPDT,!!
 W ?5,"DRUG",?50,"SCHEDULE",?61,"CURRENT BALANCE",!,LN,!!
 Q
SCH(X) ;Schedule conversion
 Q:(X'?.N)!(+X<1) ""
 Q $P("I^II^III^IV^V","^",X)
