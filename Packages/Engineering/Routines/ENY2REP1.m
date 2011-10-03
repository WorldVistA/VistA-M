ENY2REP1 ;;(WIRMFO)/DH-Y2K Category Reports ;8.19.98
 ;;7.0;ENGINEERING;**51,55**;August 17, 1993
EN ; print counts by equipment category or manufacturer, decreasing order
 ; indicate Y2K status
 W @IOF,!,?20,"** SUMMARY OF Y2K EQUIPMENT DATA **"
 I $P($G(^DIC(6910,1,0)),U,2)']"" W !!,"There is no STATION NUMBER in your Engineering Init Parameters file.",!,"Can't proceed." Q
 W ! S DIR(0)="SM^CAT:EQUIPMENT CATEGORY;MFG:MANUFACTURER;CSN:CATEGORY STOCK NUMBER",DIR("A")="Print Summary by",DIR("B")="CAT"
 D ^DIR K DIR Q:$D(DIRUT)
 S ENTYPE=Y
 W ! S DIR(0)="YA",DIR("A")="Shall we ignore "_$S(ENTYPE="CAT":"EQUIPMENT CATEGORIES",ENTYPE="MFG":"MANUFACTURERS",1:"CATEGORY STOCK NUMBERS")_" with no Y2K issues? ",DIR("B")="YES"
 S DIR("?",1)="Enter YES if you do not wish to see counts for "_$S(ENTYPE="CAT":"EQUIPMENT CATEGORIES",ENTYPE="MFG":"MANUFACTURERS",1:"CATEGORY STOCK NUMBERS")_" for"
 S DIR("?")="which all of the equipment entries have Y2K CATEGORIES of 'NA' or 'FC'."
 D ^DIR K DIR I $D(DIRUT) K ENTYPE Q
 S ENSUP=Y
 W ! S DIR(0)="SM^A:ALPHABETICALLY;C:BY COUNT",DIR("A")="Sort List",DIR("B")="ALPHABETICALLY"
 S DIR("?")="If COUNT is specified then large groupings will be at the top of your list."
 D ^DIR K DIR I $D(DIRUT) K ENTYPE,ENSUP Q
 S ENSORT=Y
 I ENSORT="C" D  I $D(DIRUT) K ENTYPE,ENSUP,ENSORT Q
 . W ! S DIR(0)="N^1:9999:0",DIR("A")="Only print "_$S(ENTYPE="CAT":"EQUIPMENT CATEGORIES",ENTYPE="MFG":"MANUFACTURERS",1:"CATEGORY STOCK NUMBERS")_" with COUNT of at least",DIR("B")=1
 . S DIR("?")="This feature allows you to print only the high count entries."
 . D ^DIR K DIR Q:$D(DIRUT)
 . S ENSORT("MIN")=Y
 S ENSTN=0
 I $P(^DIC(6910,1,0),U,10)!($D(^DIC(6910,1,3))) D  I ENSTN="^" K ENTYPE,ENSUP,ENSORT,ENSTN Q
 . S DIR(0)="Y",DIR("A")="Do you want a breakout by station",DIR("B")="NO"
 . S DIR("?",1)="If you say 'NO' you will obtain a single report for all your equipment,"
 . S DIR("?")="regardless of which station it belongs to."
 . W ! D ^DIR K DIR I $D(DIRUT) S ENSTN="^" Q
 . S ENSTN=Y
 W !! K IO("Q") S %ZIS="QM" D ^%ZIS I POP K ENTYPE,ENSUP,ENSORT,ENSTN Q
 I $D(IO("Q")) S ZTRTN="DEQUE^ENY2REP8" D  K ENTYPE,ENSUP,ENSORT,ENSTN Q
 . S ZTSAVE("EN*")="",ZTDESC="Y2K Counts by EQUIPMENT CATEGORY"
 . S ZTIO=ION D ^%ZTLOAD,HOME^%ZIS K ZTSK
 ;
 G DEQUE^ENY2REP8
 ;ENY2REP1
