FHASN3 ; HISC/NCA - Nutrition Status Matrix ;9/29/93  10:02
 ;;5.5;DIETETICS;;Jan 28, 2005
EN2 ; Select to print Change Overtime or Admission
 K DIR S DIR(0)="SO^1:Status Change Over a period of time;2:Status Change from Admission",DIR("A")="Select one to Display" D ^DIR G:$D(DIRUT)!($D(DIROUT)) KIL S FHX1=+Y
 S WRDS=$O(^FH(119.6,0)) I WRDS'<1,$O(^FH(119.6,WRDS))<1 S WRDS=0 G DT:FHX1=1,E2
E1 R !!,"Select WARD (or ALL): ",X:DTIME G:'$T!("^"[X) KIL D:X="all" TR^FH I X="ALL" S WRDS=0
 I X'="ALL" K DIC S DIC="^FH(119.6,",DIC(0)="EMQ" D ^DIC G KIL:$D(DTOUT),E1:Y<1 S WRDS=+Y
 I FHX1=2 S (SDT,EDT)="" G E2
DT ; Get From/To Dates
D1 K %DT S %DT="AEPX",%DT("A")="Starting Date: " W ! D ^%DT G:U[X!($D(DTOUT)) KIL G:Y<1 D1 S SDT=+Y
 I SDT'<DT W *7,"  [Must Start before Today!] " G D1
D2 K %DT S %DT="AEPX",%DT("A")=" Ending Date: " D ^%DT G:U[X!($D(DTOUT)) KIL G:Y<1 D2 S EDT=+Y
 I EDT>DT W *7,"  [Greater than Today?] " G D1
 I EDT'>SDT W *7,"  [Must End after Start] " G D1
 S X1=EDT\1,X2=SDT\1 D ^%DTC
 G:'%Y!(X<1) DT
 S NOM=+X+1
 W !!,"This Report shows the status change on the starting date and on the ending date.",!,"Excludes any Admission starting from the starting date.",!
 G L0
E2 ; Get # of Days from Admission
 W ! K DIR S DIR(0)="NAO^3:99",DIR("?")="The response must be a number from 3-99"
 S DIR("A")="Enter # of Days from Admission: "
 D ^DIR G:$D(DIRUT)!($D(DIROUT)) KIL S NOM=+Y
L0 K IOP,%ZIS S %ZIS("A")="Print on Device: ",%ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q0^FHASN4",FHLST="FHX1^NOM^SDT^EDT^WRDS" D EN2^FH G KIL
 U IO D Q0^FHASN4 D ^%ZISC K %ZIS,IOP G KIL:'WRDS,FHASN3
KIL K ^TMP($J) G KILL^XUSCLEAN
HD ; Check for end of page
 I IOST?1"C".E W:$X>1 ! W *7 K DIR S DIR(0)="E" D ^DIR I 'Y S ANS="^" Q
HDR ; Print heading
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !,HD,?72,"Page ",PG
 W !!?9,"N U T R I T I O N   S T A T U S   C H A N G E   M A T R I X"
 W !!,"WARD",?30,DTE,!,$P(NAM,"~",1)
 I FHX1=1 W !?17,"Shows Status Change on Start Date and End Date",!?17,"(Excludes Any Admission from the starting date)"
 W !!,?23,"BEG STATUS",?54,"END STATUS",?73,"STATUS"
 W !,"STATUS",?26,"TOTAL",?43,"I     II    III     IV    UNC   SAME",!,LN,! Q
