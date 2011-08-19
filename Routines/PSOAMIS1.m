PSOAMIS1 ;BHAM ISC/SAB,BHW - daily amis total report ; 11/04/92 17:45
 ;;7.0;OUTPATIENT PHARMACY;**158**;DEC 1997
 ;
 W !!,"Daily AMIS Report. Prints Daily, Monthly and Quarterly AMIS Data",!!,"PLEASE PRINT ON WIDE PAPER, I.E., 132 COLUMNS."
DA W !! S %DT(0)=-DT,%DT("A")="Compute AMIS for what day: " S %DT="EXPA" D ^%DT G:"^"[X END G:Y<0 DA S PSDATE=Y,MON=$E(Y,1,5)_"00",EDT=MON+32 K %DT(0)
 S MONTH=$E(Y,4,5),MONTH=MONTH-1\3*3+1,BQTR=$E(Y,1,3)_$S($L(MONTH)<2:"0"_MONTH,1:MONTH)_"00",EQTR=$E(Y,1,3)_MONTH+2_32 I $L(EQTR)<7 S EQTR=$E(EQTR,1,3)_"0"_$E(EQTR,4,6)
DEV K %ZIS,IOP,ZTSK S %ZIS("B")="",PSOION=ION,%ZIS="QM" D ^%ZIS I POP S IOP=PSOION D ^%ZIS K IOP,PSOION G END
 I $D(IO("Q")) K PSOION S ZTDTH=$H,ZTDESC="Compile and print daily, monthly and quarterly amis totals",ZTIO=IO,ZTRTN="ENQ^PSOAMIS1" F G="PSDATE","BQTR","EQTR","MON","EDT" S:$D(@G) ZTSAVE(G)=""
 I  D ^%ZTLOAD W:$D(ZTSK) !,"Report queued to print!" K G,ZTSAVE,ZTSK,ZTIO,PSDATE,BQTR,EQTR,MON,EDT Q
ENQ ;start computations
 K ^TMP("PSOAMIS",$J) S PG=0 F DIV=0:0 S DIV=$O(^PS(59,DIV)) Q:'DIV  D
 .S (^TMP("PSOAMIS",$J,"SUB",DIV),^TMP("PSOAMIS",$J,"SUBMONTH",DIV),^TMP("PSOAMIS",$J,"SUBQTR",DIV),^TMP("PSOAMIS",$J,"GT"),^TMP("PSOAMIS",$J,"GTMON"),^TMP("PSOAMIS",$J,"GTQTR"))=0
 .S (^TMP("PSOAMIS",$J,"MTH",DIV),^TMP("PSOAMIS",$J,"QTR",DIV))=0
 I $D(^PS(59.1,PSDATE)) F I=0:0 S I=$O(^PS(59.1,PSDATE,1,I)) Q:'I  D
 . S X=^PS(59.1,PSDATE,1,I,0)
 . S ^TMP("PSOAMIS",$J,I,PSDATE)=$P(X,"^",2,3)_"^"_$P(X,"^",5)_"^"_$P(X,"^",7)_"^"_$P(X,"^",18)_"^"_$P(X,"^",8,12)_"^"_$P(X,"^",14,17)
 . F S=1:1:14 S ^TMP("PSOAMIS",$J,"SUB",I)=^TMP("PSOAMIS",$J,"SUB",I)+$P(^TMP("PSOAMIS",$J,I,PSDATE),"^",S),^TMP("PSOAMIS",$J,"GT")=$P(^TMP("PSOAMIS",$J,I,PSDATE),"^",S)+^TMP("PSOAMIS",$J,"GT")
 . Q
 E  F DIV=0:0 S DIV=$O(^PS(59,DIV)) Q:'DIV  F I=1:1:17 S $P(^TMP("PSOAMIS",$J,DIV,PSDATE),"^",I)=0
 ;monthly data
 F G=0:0 S MON=$O(^PS(59.1,MON)) Q:MON>EDT!('MON)  F I=0:0 S I=$O(^PS(59.1,MON,1,I)) Q:'I  S MT=1 D COMP
 ;quarterly data
 F G=0:0 S BQTR=$O(^PS(59.1,BQTR)) Q:'BQTR!(BQTR>EQTR)  F I=0:0 S I=$O(^PS(59.1,BQTR,1,I)) Q:'I  S MT=0 D COMP
PRI ;OUTPUT DATA
 S ZDIV="" F DIV=0:0 S DIV=$O(^PS(59,DIV)) Q:'DIV!($D(DIRUT))  D HDR F I=1:1:14 W !,$P("INPAT^SC^A&A^OTHER^NVA^CNTLD^METHA^PAT REQ^FEE^STAFF^NEW^REFILL^WINDOW^MAIL","^",I) D  Q:$D(DIRUT)  S ZDIV=DIV D:I=14 SUB
 .W ?20,$J(+$P(^TMP("PSOAMIS",$J,DIV,PSDATE),"^",I),9),?50,$J(+$P(^TMP("PSOAMIS",$J,"MTH",DIV),"^",I),9),?80,$J(+$P(^TMP("PSOAMIS",$J,"QTR",DIV),"^",I),9)
 .I $E(IOST)["C",($Y+4)>IOSL D DIR
 W:'$D(DIRUT) !!,"GRAND TOTALS",?20,$J("=========",9),?50,$J("=========",9),?80,$J("=========",9),!,?20,$J(^TMP("PSOAMIS",$J,"GT"),9),?50,$J(^TMP("PSOAMIS",$J,"GTMON"),9),?80,$J(^TMP("PSOAMIS",$J,"GTQTR"),9)
END W ! W:$E(IOST)'["C" @IOF D ^%ZISC K DIRUT,^TMP("PSOAMIS",$J),MON,S,K,PSDATE,MONTH,BQTR,EQTR,SDT,SUB,I,G,GT,%DT,GR,Y,X,POP,PG,DIV,EDT,INPAT,SC,AA,OTH,CNTLD,METH,PREQ,FEE,STAFF,NEW,REF,WIND,MAIL,ZDIV S:$D(ZTQUEUED) ZTREQ="@"
 Q
HDR ;report header
 S PG=PG+1
 U IO W @IOF,?20,"Daily/Monthly/Quarterly AMIS report for " S Y=$E(PSDATE,1,5)_"00" X ^DD("DD") W Y,!?20,"Division: "_$P(^PS(59,DIV,0),"^"),?115,"Page: "_PG
 W !,?20,$E(PSDATE,4,5)_"-"_$E(PSDATE,6,7)_"-"_$E(PSDATE,2,3),?50,"Monthly Totals",?80,"Quarterly Totals" W ! F K=1:1:132 W "-"
 W ! Q
SUB W !!,"Sub Totals",?20,$J("=========",9),?50,$J("=========",9),?80,$J("=========",9),!,?20,$J(^TMP("PSOAMIS",$J,"SUB",DIV),9),?50,$J(^TMP("PSOAMIS",$J,"SUBMONTH",DIV),9),?80,$J(^TMP("PSOAMIS",$J,"SUBQTR",DIV),9) D:$E(IOST)["C" DIR
 Q
COMP S IFN=1 F AFN=2,3,5,7,18,8,9,10,11,12,14,15,16,17 Q:IFN>14  D  S IFN=IFN+1
 .S $P(^TMP("PSOAMIS",$J,$S(MT:"MTH",1:"QTR"),I),"^",IFN)=$P(^TMP("PSOAMIS",$J,$S(MT:"MTH",1:"QTR"),I),"^",IFN)+$P(^PS(59.1,$S(MT:MON,1:BQTR),1,I,0),"^",AFN)
 .S ^TMP("PSOAMIS",$J,$S(MT:"SUBMONTH",1:"SUBQTR"),I)=^TMP("PSOAMIS",$J,$S(MT:"SUBMONTH",1:"SUBQTR"),I)+$P(^PS(59.1,$S(MT:MON,1:BQTR),1,I,0),"^",AFN)
 .S ^TMP("PSOAMIS",$J,$S(MT:"GTMON",1:"GTQTR"))=^TMP("PSOAMIS",$J,$S(MT:"GTMON",1:"GTQTR"))+$P(^PS(59.1,$S(MT:MON,1:BQTR),1,I,0),"^",AFN)
 Q
DIR K DIR,DUOUT,DTOUT,DIRUT S DIR(0)="E" D ^DIR K DIR,DUOUT,DTOUT Q
