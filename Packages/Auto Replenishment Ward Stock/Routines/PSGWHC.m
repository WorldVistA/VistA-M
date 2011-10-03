PSGWHC ;BHAM ISC/PTD,CML-High Cost for Selected Date Range (Single AOU or Cumulative) ; 19 Mar 93 / 8:29 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 W !!?5,"Before printing this report, be sure accurate data exists for drug cost.",!?5,"Use ""Prepare AMIS Data"": ""Enter AMIS Data for All Drugs/All AOUs"".",!!
BDT S %DT="AEX",%DT("A")="BEGINNING date for report: " D ^%DT K %DT G:Y<0 END^PSGWHC1 S BDT=Y
EDT S %DT="AEX",%DT(0)=BDT,%DT("A")="ENDING date for report: " D ^%DT K %DT G:Y<0 END^PSGWHC1 S EDT=Y
 W !!?5,"You may select a single AOU,",!?5,"or enter ""^ALL"" to get cumulative cost for all AOUs.",!?5,"ALL will show only AOUs with ""Count on AMIS"" field set to ""YES"".",!!
ASKAOU S DIC="^PSI(58.1,",DIC(0)="QEAM" D ^DIC K DIC G:(Y<0)&(X'="^ALL") END^PSGWHC1
 I X'="^ALL" S AOU=+Y,ALL=0
 E  S AOU=0,ALL=1
CUTOFF W !!,"The High Cost Report will show all drugs with a total cost greater",!,"than a specified cut off amount. It will NOT list costs less than",!,"the amount you specify below.",!!
ASK1 R !,"Select CUT OFF amount: ",CUT:DTIME S:'$T CUT="^" G:CUT="^" END^PSGWHC1 S:CUT="" CUT=0
 I "?"[$E(CUT)!(CUT<0)!(CUT>9999)!(CUT'?1.4N) W *7,!!,"Enter a whole number between 1 and 9999.",!,"The High Cost Report will NOT show any drug with a total cost less than",!,"the amount entered here.  If you enter <return> at the"
 I  W !,"""Select CUT OFF amount"" prompt, the report will show ALL drugs.",! G ASK1
 W !!,"You may print by either of these sorting methods:",!?5,"(1) By COST (Highest to Lowest)",!?5,"(2) Alphabetical by ITEM"
ASK2 R !!,"Select SORT ORDER for report (enter 1 or 2): ",SORT:DTIME S:'$T SORT="^" G:"^"[SORT END^PSGWHC1
 I SORT?1."?"!((SORT'=1)&(SORT'=2)) W *7,!!,"Enter '1' if you wish to print this report sorted by cost (highest to lowest)",!,"Enter '2' if you wish to print this report sorted alphabetically by Item." G ASK2
 W !!,"The right margin for this report is 80.",!,"You may queue the report to print at a later time.",!!
DEV K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END^PSGWHC1
 I $D(IO("Q")) K IO("Q") S PSGWIO=ION,ZTIO="" K ZTSAVE,ZTDTH,ZTSK S ZTRTN="^PSGWHC0",ZTDESC="Compile High Cost" F G="BDT","EDT","AOU","ALL","CUT","PSGWIO","SORT" S:$D(@G) ZTSAVE(G)=""
 I  D ^%ZTLOAD,HOME^%ZIS K ZTSK G END^PSGWHC1
 U IO G ^PSGWHC0
 ;
