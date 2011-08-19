PSDPMFG ;BIR/JPW-Print Mfg/Lot #/Exp. Date for Stock Drugs ; 6 July 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 W !!,"=>  This report lists Manufacturer, Lot #, Expiration Date, and Narcotic ",!,"    Information for CS Stock Drugs.",!
 W !!,?5,"You may select a single NAOU, several NAOUs,",!,?5,"or enter ^ALL to select all NAOUs.",!!
 I '$O(^PSD(58.8,0)) W !!,"You MUST create NAOUs before running this report!" Q
ASKN ;ask NAOU(s)
 D NOW^%DTC S PSDT=X K DA,DIC S CNT=0,DIC("B")=$P(PSDSITE,U,4)
 F  S DIC=58.8,DIC("A")="Select NAOU: ",DIC(0)="QEA",DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>PSDT:1,1:0),$P(^(0),""^"",3)=+PSDSITE,$P(^(0),""^"",2)'=""P""" D ^DIC K DIC Q:Y<0  S NAOU(+Y)="",CNT=CNT+1
 I '$D(NAOU)&(X'="^ALL") G END
 I X="^ALL" F PSD=0:0 S PSD=$O(^PSD(58.8,PSD)) Q:'PSD  I $S('$D(^PSD(58.8,PSD,"I")):1,'^("I"):1,+^("I")>PSDT:1,1:0),$P($G(^(0)),"^",2)'="P",$P($G(^(0)),"^",3)=+PSDSITE S NAOU(+PSD)="",CNT=CNT+1
 K DA,DIR,DIRUT S DIR(0)="SO^D:DRUG/NAOU;N:NAOU/DRUG",DIR("A",1)="You may print by either of these sorting methods."
 S DIR("?",1)="Enter 'D' to print the report sorted by DRUG then NAOU",DIR("?")="Enter 'N' to print the report sorted by NAOU then DRUG."
 S DIR("A")="Select SORT ORDER for Report" D ^DIR K DIR G:$D(DIRUT) END S ANS=Y
DEV ;ask device and queueing information
 W !!,"This report is designed for a 132 column format.",!,"You may queue this report to print at a later time.",!!
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q") S PSDIO=ION,ZTIO="" K ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDPMFG",ZTDESC="Compile Mfg Data for CS PHARM Stock Drugs" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;compile mfg/lot #/exp. date/narcotic breakdown unit/pkg data
 K ^TMP("PSDPMFG",$J)
 F PSD=0:0 S PSD=$O(NAOU(PSD)) G:('PSD)&($D(ZTQUEUED)) PRTQUE G:'PSD PRINT^PSDPMFG1 I $D(^PSD(58.8,PSD,0)) F DRUG=0:0 S DRUG=$O(^PSD(58.8,PSD,1,DRUG)) Q:'DRUG  D
 .S NAOUN=$S($P($G(^PSD(58.8,PSD,0)),"^")]"":$P(^(0),"^"),1:"ZZ/"_PSD)
 .Q:'$D(^PSD(58.8,PSD,1,DRUG,0))  S NODE=^PSD(58.8,PSD,1,DRUG,0) I +$P(NODE,"^",14) D NOW^%DTC I $P(^PSD(58.8,PSD,1,DRUG,0),"^",14)'>X Q
 .Q:'$D(^PSDRUG(DRUG,0))  I $D(^PSDRUG(DRUG,0)) S DRUGN=$S($P(^PSDRUG(DRUG,0),"^")]"":$P(^(0),"^"),1:"ZZ/"_DRUG)
 .S MFG=$S($P(NODE,"^",10)]"":$P(NODE,"^",10),1:"____________________")
 .S LOT=$S($P(NODE,"^",11)]"":$P(NODE,"^",11),1:"__________"),EXP=$S($P(NODE,"^",12)]"":$P(NODE,"^",12),1:"__________")
 .S BKU=$S($P(NODE,"^",8)]"":$P(NODE,"^",8),1:"__________"),PKG=$S($P(NODE,"^",9)]"":$P(NODE,"^",9),1:"__________") I +EXP S Y=EXP X ^DD("DD") S EXP=Y
 .I (CNT=1)!(ANS="N") S ^TMP("PSDPMFG",$J,NAOUN,DRUGN)=MFG_"^"_LOT_"^"_EXP_"^"_BKU_"^"_PKG
 .I ANS="D",CNT'=1 S ^TMP("PSDPMFG",$J,DRUGN,NAOUN)=MFG_"^"_LOT_"^"_EXP_"^"_BKU_"^"_PKG
 Q
PRTQUE ;queues print after data is compiled
 K ZTSAVE,ZTIO S ZTIO=PSDIO,ZTRTN="PRINT^PSDPMFG1",ZTDESC="Print Mfg Data for CS PHARM Stock Drugs",ZTDTH=$H,ZTSAVE("^TMP(""PSDPMFG"",$J,")="",ZTSAVE("ANS")="",ZTSAVE("CNT")=""
 D ^%ZTLOAD K ^TMP("PSDPMFG",$J),ZTSK
END ;
 K %,%H,%I,%ZIS,ANS,BKU,CNT,DA,DIC,DIR,DIROUT,DIRUT,DIK,DRUG,DRUGN,DTOUT,DUOUT,EXP,IO("Q"),LOT,MFG,NAOU,NAOUN,NODE,PKG,POP,PSD,PSDIO,PSDT
 K X,Y,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTRTN,^TMP("PSDPMFG",$J) D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE ;save variables for queueing
 S ZTSAVE("PSDIO")="",ZTSAVE("PSDT")="",ZTSAVE("ANS")="",ZTSAVE("PSDSITE")=""
 S ZTSAVE("CNT")="",ZTSAVE("NAOU(")="",ZTSAVE("PSD")=""
 Q
