ECTMENU ;B'ham ISC/PTD-Interim Management Support Menu Display ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;;
 G:'$D(ECT) EXIT
 K %ZIS S IOP="HOME" D ^%ZIS K %ZIS,IOP
1 I ECT=1 W @IOF,!!?2,"* * *   D H C P   I N T E R I M   M A N A G E M E N T   S U P P O R T   * * *",!! D VER W ?17 D LINE W !!?32,"*** WARNING ***",!?17,"The data which follows is highly CONFIDENTIAL!",!!?17 D LINE W !! G EXIT
2 I ECT=2 W @IOF,!!?28,"D A I L Y   R E P O R T" W !!?17 D LINE W !!?32,"*** CAUTION ***",!?27,"Choose limited date range",!?27,"if printing to the screen.",!?27,"Advise using 'T-1'.",!!?17 D LINE W !! G EXIT
3 I ECT=3 W @IOF,!!?10,"P E R S O N N E L / S T A F F I N G   I N F O R M A T I O N",!! G EXIT
4 I ECT=4 W @IOF,!!?6,"P A I D   M A N A G E M E N T   R E P O R T S   B Y   S E R V I C E",!! G EXIT
5 I ECT=5 W @IOF,!!?20,"F I N A N C I A L   I N F O R M A T I O N",!! G EXIT
6 I ECT=6 W @IOF,!!?19,"E Q U I P M E N T   I N F O R M A T I O N",!! G EXIT
7 I ECT=7 W @IOF,!!?8,"C O N S T R U C T I O N   P R O J E C T   I N F O R M A T I O N",!! G EXIT
8 I ECT=8 W @IOF,!!?12,"S P A C E   M A N A G E M E N T   I N F O R M A T I O N",!! G EXIT
9 I ECT=9 W @IOF,!!?11,"Q U A L I T Y   A S S U R A N C E   I N F O R M A T I O N",! D QA G EXIT
10 I ECT=10 W @IOF,!!?12,"S T A T I O N   W O R K L O A D   I N F O R M A T I O N",!! G EXIT
11 I ECT=11 W @IOF,!!?12,"S E R V I C E   W O R K L O A D   I N F O R M A T I O N",!! D WARN G EXIT
12 I ECT=12 W @IOF,!!?19,"S P E C I A L   L O C A L   R E P O R T S",!! G EXIT
EXIT K ECT,J,POP,VER
 Q
 ;
LINE F J=1:1:46 W "*"
 Q
 ;
VER S VER=$P($T(V),";;",2) W ?34,"Version ",$P(VER,";"),!!
 Q
 ;
QA ;CONFIDENTIAL MESSAGE FOR QA APPLICATIONS
 I '$O(^QA(741,0)) W !!?26,"QA REPORTS ARE UNAVAILABLE!",!,"Reports work with version 2.0 of the Occurrence Screening software.",!! S XQUIT="" Q
 W !?17 D LINE
 W !!?30,"*** CONFIDENTIAL! ***",!!?15,"This information is confidential in accordance with",!?15,"Title 38 U.S.C. 3305 and will be released only if",!?15,"requirements of VA Regulation 6518(C) are met.",!
 W !?17 D LINE W !!
 Q
 ;
WARN ;WARNING TO QUEUE REPORTS
 W !?17 D LINE
 W !!?32,"*** WARNING! ***",!!?20,"Reports on this menu should be QUEUED",!?20,"to print during the evening hours.  All",!?20,"require considerable time to generate;",!?20,"some display 132 columns of data.",!
 W !?17 D LINE W !!
 Q
 ;
LR ;CHECK VERSION OF LAB IN PACKAGE FILE - V5 DOES NOT REQUIRE ACCESSION AREA QUESTION
 S VDA=$O(^DIC(9.4,"C","LR",0)) I 'VDA K VDA W *7,!,"Unable to determine version of LAB operating on your system." Q
 S:$D(^DIC(9.4,VDA,"VERSION")) VER=+(^("VERSION")) I '$D(VER) K VDA,VER W *7,!,"Unable to determine version of LAB operating on your system." Q
 I VER<5 S DIC=68,DIC(0)="QEAM" D ^DIC K DIC I Y>0 S LRAA=+Y,LRAA(1)=$P(Y,U,2)
 K VDA,VER,Y
 Q
 ;
