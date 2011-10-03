GMRVER0 ;HIRMFO/RM,YH-REPORT OF VITALS ENTERED IN ERROR FOR A PATIENT ;2/6/99
 ;;4.0;Vitals/Measurements;**7**;Apr 25, 1997
EN1 ; ENTRY FROM OPTION GMRV ERROR PRINT
 K ^TMP($J) S DIC="^DPT(",DIC(0)="AEQM" D ^DIC K DIC Q:+Y'>0  S DFN=+Y
DTS S %DT="AET",%DT("A")="Start with DATE (TIME optional): ",%DT("B")="T-7" D ^%DT K %DT I +Y'>0 G Q
 S GMRVSDT=+Y
 S %DT="AET",%DT("A")="go to DATE (TIME optional): ",%DT("B")="NOW" D ^%DT K %DT I X="^" G Q
 I +Y'>0!($P(Y,".",2)'>0&(DT=Y)) D NOW^%DTC S Y=%
 I $P(Y,".",2)'>0 S Y=Y_$S(Y[".":"2400",1:".2400")
 I GMRVSDT>+Y W !,?3,$C(7),"THE START DATE MUST BE BEFORE THE END DATE OF THIS REPORT" G DTS
 S GMRVFDT=+Y
DEV S %ZIS="Q" D ^%ZIS K %ZIS G:POP Q I $E(IOST)="P",'$D(IO("Q")),'$D(IO("S")) D ^%ZISC W !,?3,"PRINTED REPORTS MUST BE QUEUED!!",$C(7) G DEV
 I $D(IO("Q")) S (ZTSAVE("DFN"),ZTSAVE("GMRVSDT"),ZTSAVE("GMRVFDT"))="",ZTIO=ION,ZTDESC="Entered in error vital/measurement report",ZTRTN="EN1^GMRVER1" D ^%ZTLOAD K IO("Q"),ZTSK,ZTIO G Q
 G EN1^GMRVER1
Q G Q^GMRVER1
ERREASON ;ERROR REASON
 Q:'$D(^GMR(120.5,+GMRVDA,2.1))
 S GER=0 F  S GER=$O(^GMR(120.5,+GMRVDA,2.1,GER)) Q:GER'>0  S GER(1)=+$G(^GMR(120.5,+GMRVDA,2.1,GER,0)) D
 . S GER(2)=$S(GER(1)=1:"incorrect date/time",GER(1)=2:"incorrect reading",GER(1)=3:"incorrect patient",GER(1)=4:"invalid record",1:"")
 . I GER(2)'="" S GREASON=GREASON_$S(GREASON'="":", ",1:"")_GER(2)
 .Q
 K GER Q
WRTDAT(TYPE,DATA) ;
 I '((TYPE="BP")!(TYPE="P")!(TYPE="R")),DATA>0 D @TYPE
 Q DATA
T S DATA=DATA_" F  ("_$J(+DATA-32*5/9,0,1)_" C)" Q
WT S DATA=DATA_" lb  ("_$J(DATA/2.2,0,2)_" kg)" Q
HT S DATA=$S(DATA\12:DATA\12_" ft ",1:"")_$S(DATA#12:DATA#12_" in",1:"")_" ("_$J(DATA*2.54,0,2)_" cm)" Q
CG S DATA=DATA_" in ("_$J(+DATA/.3937,0,2)_" cm)" Q
CVP S DATA=DATA_" cmH2O ("_$J(DATA/1.36,0,1)_" mmHg)" Q
PO2 S DATA=DATA_"%" Q
PN I DATA=0 S DATA=DATA_" No pain " Q
 I DATA=99 S DATA=DATA_" Unable to respond " Q
 I DATA=10 S DATA=DATA_" Worst imaginable pain " Q
 Q
