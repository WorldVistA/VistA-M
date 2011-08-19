PSGWHV ;BHAM ISC/PTD,CML-High Volume for Selected Date Range (Single AOU or Cumulative) ; 19 Mar 93 / 8:30 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
BDT S %DT="AEX",%DT("A")="BEGINNING date for report: " D ^%DT K %DT G:Y<0 END^PSGWHV1 S BDT=Y
EDT S %DT="AEX",%DT(0)=BDT,%DT("A")="ENDING date for report: " D ^%DT K %DT G:Y<0 END^PSGWHV1 S EDT=Y
 W !!?5,"You may select a single AOU,",!?5,"or enter ""^ALL"" to get cumulative volume for all AOUs.",!?5,"ALL will show only AOUs with ""Count on AMIS"" field set to ""YES"".",!!
ASKAOU S DIC="^PSI(58.1,",DIC(0)="QEAM" D ^DIC K DIC G:(Y<0)&(X'="^ALL") END^PSGWHV1
 I X'="^ALL" S AOU=+Y,ALL=0
 E  S AOU=0,ALL=1
CUTOFF W !!,"The High Volume Report will show all drugs with a total quantity",!,"dispensed greater than a specified cut off amount. It will NOT list",!,"quantities less than the amount you specify below.",!!
ASK R !,"Select CUT OFF quantity: ",CUT:DTIME S:'$T CUT="^" G:CUT="^" END^PSGWHV1 S:CUT="" CUT=0
 I "?"[$E(CUT)!(CUT<0)!(CUT>9999)!(CUT'?1.4N) W *7,!!,"Enter a whole number between 1 and 9999.",!,"The High Volume Report will NOT show any drug with a total quantity"
 I  W !,"dispensed less than the amount entered here.  If you enter <return> at the",!,"""Select CUT OFF quantity"" prompt, the report will show ALL drugs.",! G ASK
 W !!,"The right margin for this report is 80.",!,"You may queue the report to print at a later time.",!!
DEV K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END^PSGWHV1
 I $D(IO("Q")) K IO("Q") S PSGWIO=ION,ZTIO="" K ZTSAVE,ZTDTH,ZTSK S ZTRTN="^PSGWHV0",ZTDESC="Compile High Volume" F G="BDT","EDT","AOU","ALL","CUT","PSGWIO" S:$D(@G) ZTSAVE(G)=""
 I  D ^%ZTLOAD,HOME^%ZIS K ZTSK G END^PSGWHV1
 U IO G ^PSGWHV0
 ;
