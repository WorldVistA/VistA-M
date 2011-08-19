PSDPSTK ;BIR/JPW-Print Data for CS Stock Drugs ; 7 Sept 92
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 W !!,"This report lists data stored for CS Stock Drugs.",!!,"This report is designed for a 132 column format.",!,"You may queue this report to print at a later time.",!!
 I '$O(^PSD(58.8,0)) W !!,"You MUST create NAOUs before running this report!" Q
 D NOW^%DTC S PSDT=X
DEV ;ask device and queueing information
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q") S PSDIO=ION,ZTIO="" K ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDPSTK",ZTDESC="Compile Data for CS PHARM Stock Drugs",ZTSAVE("PSDIO")="",ZTSAVE("PSDSITE")="",ZTSAVE("PSDT")="" D ^%ZTLOAD K ZTSK G END
 U IO
START ;compile data for stock drug report
 K ^TMP("PSDPSTK",$J)
 F NAOU=0:0 S NAOU=$O(^PSD(58.8,NAOU)) G:('NAOU)&($D(ZTQUEUED)) PRTQUE G:'NAOU PRINT^PSDPSTK1 I $D(^PSD(58.8,NAOU,0)),$P(^(0),"^",3)=+PSDSITE,$P(^(0),"^",2)'="P" F DRUG=0:0 S DRUG=$O(^PSD(58.8,NAOU,1,DRUG)) Q:'DRUG  D
 .Q:'$D(^PSD(58.8,NAOU,1,DRUG,0))  I +$P(^PSD(58.8,NAOU,1,DRUG,0),"^",14) D NOW^%DTC I $P(^PSD(58.8,NAOU,1,DRUG,0),"^",14)'>X Q
 .Q:'$D(^PSDRUG(DRUG,0))  I $D(^PSDRUG(DRUG,0)) S DRUGN=$S($P(^PSDRUG(DRUG,0),"^")]"":$P(^(0),"^"),1:"ZZ/"_DRUG)
 .I $D(^PSD(58.8,NAOU,"I")),$P(^("I"),"^"),$P(^("I"),"^")'>PSDT S ^TMP("PSDPSTK",$J,DRUGN,NAOU,0)="I^"_$P(^("I"),"^") Q
 .S NODE=^PSD(58.8,NAOU,1,DRUG,0),LOC=$S($P(NODE,"^",2)]"":$P(NODE,"^",2),1:"NONE"),STK=$S($P(NODE,"^",3)]"":$P(NODE,"^",3),1:"NONE")
 .S TYPE="" F TYP=0:0 S TYP=$O(^PSD(58.8,NAOU,1,DRUG,2,TYP)) Q:'TYP  S TYPE=TYPE_";;"_TYP
 .S WARD="" F WRD=0:0 S WRD=$O(^PSD(58.8,NAOU,1,DRUG,1,WRD)) Q:'WRD  S WARD=WARD_";;"_WRD
 .S:TYPE="" TYPE=";;NONE" S:WARD="" WARD=";;NONE" S ^TMP("PSDPSTK",$J,DRUGN,NAOU,0)=LOC_"^"_STK_"^"_TYPE
 .S ^TMP("PSDPSTK",$J,DRUGN,NAOU,1)=WARD
 Q
END ;
 K %,%H,%I,%ZIS,DA,DATEI,DIK,DRUG,DRUGN,IO("Q"),LOC,NAOU,NODE,POP,PSDIO,PSDT,STK,TYP,TYPE,WARD,WRD
 K X,Y,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTRTN,^TMP("PSDPSTK",$J) D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
PRTQUE ;queues print after data is compiled
 K ZTSAVE,ZTIO S ZTIO=PSDIO,ZTRTN="PRINT^PSDPSTK1",ZTDESC="Print Data for CS PHARM Stock Drugs",ZTDTH=$H,ZTSAVE("^TMP(""PSDPSTK"",$J,")=""
 D ^%ZTLOAD K ^TMP("PSDPSTK",$J) K ZTSK G END
