PSGWPSI ;BHAM ISC/CML-Print Data for AR/WS Stock Items ; 19 Mar 93 / 8:34 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 D NOW^%DTC S PSGWDT=$P(%,".")
 W !!!,"This report shows data stored for AR/WS Stock Items.",!!,"Right margin for this report is 132 columns.",!,"You may queue the report to print at a later time.",!!
 I '$O(^PSI(58.1,0)) W !,"You MUST create AOUs before running this report!" K %,%I,%H,PSGWDT Q
DEV K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G QUIT^PSGWPSI1
 I $D(IO("Q")) K IO("Q") S PSGWIO=ION,ZTIO="" K ZTSAVE,ZTDTH,ZTSK S ZTRTN="ENQ^PSGWPSI",ZTDESC="Compile Data for AR/WS Stock Items",ZTSAVE("PSGWIO")="",ZTSAVE("PSGWDT")=""
 I  D ^%ZTLOAD,HOME^%ZIS K ZTSK G QUIT^PSGWPSI1
 U IO
 ;
ENQ ;ENTRY POINT WHEN QUEUED
AOU K ^TMP("PSGWPSI",$J) F AOU=0:0 S AOU=$O(^PSI(58.1,AOU)) G:('AOU)&($D(ZTQUEUED)) PRTQUE G:'AOU PRINT^PSGWPSI1 D XREF
 ;
XREF F DRGDA=0:0 S DRGDA=$O(^PSI(58.1,AOU,1,"B",DRGDA)) Q:'DRGDA  F ITMDA=0:0 S ITMDA=$O(^PSI(58.1,AOU,1,"B",DRGDA,ITMDA)) Q:'ITMDA  D BUILD
 Q
BUILD ;BUILD DATA ELEMENTS
 Q:'$D(^PSI(58.1,AOU,1,ITMDA,0))  S NODE=^(0) I +$P(NODE,"^",3),+$P(NODE,"^",3)'>DT Q
 I '$O(^PSDRUG(DRGDA,0)) S DIK="^PSI(58.1,"_AOU_",1,",DA=ITMDA,DA(1)=AOU D ^DIK K DIK Q
 I $O(^PSDRUG(DRGDA,0)) S ITMNM=$S($P(^PSDRUG(DRGDA,0),"^")]"":$P(^(0),"^"),1:"ZZ/DRUG #"_DRGDA_" is missing NAME in the DRUG File.")
 I $P(NODE,"^",10)="Y",$P(NODE,"^",3)="" S $P(^PSI(58.1,AOU,1,ITMDA,0),"^",10)=""
 I $D(^PSI(58.1,AOU,"I")),$P(^("I"),"^"),$P(^("I"),"^")'>PSGWDT S ^TMP("PSGWPSI",$J,ITMNM,AOU)="I^"_$P(^("I"),"^") Q
 S LOC=$S($P(NODE,"^",8)]"":$P(NODE,"^",8),1:"NONE"),STKLEV=$S($P(NODE,"^",2):$P(NODE,"^",2),1:"NONE")
 S TYPE="" F LL=0:0 S LL=$O(^PSI(58.1,AOU,1,ITMDA,2,LL)) Q:'LL  S TYPE=TYPE_";;"_LL
 S WARD="" F LL=0:0 S LL=$O(^PSI(58.1,AOU,1,ITMDA,4,LL)) Q:'LL  S WARD=WARD_";;"_LL
SETGL ;
 S:WARD="" WARD=";;NONE" S:TYPE="" TYPE=";;NONE" S ^TMP("PSGWPSI",$J,ITMNM,AOU)=LOC_"^"_STKLEV_"^"_WARD_"^"_TYPE Q
 Q
 ;
PRTQUE ;AFTER DATA IS COMPILED, QUEUE THE PRINT
 K ZTSAVE,ZTIO S ZTIO=PSGWIO,ZTRTN="PRINT^PSGWPSI1",ZTDESC="Print Data for AR/WS Stock Items",ZTDTH=$H,ZTSAVE("^TMP(""PSGWPSI"",$J,")=""
 D ^%ZTLOAD K ^TMP("PSGWPSI",$J) G QUIT^PSGWPSI1
