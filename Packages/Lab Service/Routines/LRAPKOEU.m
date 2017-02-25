LRAPKOEU ;DSS/FHS - AP CPRS DIALOG UTILITIES ROUTINE ; 3/4/16 4:02pm
 ;;5.2;LAB SERVICE;**462**;Sep 27, 1994;Build 44
 Q
 ;
PRT ; Entry point for print File #60 AP CPRS entries.
 N I,J,X,Y,DA,DIC,DIE,DIR,DTOUT,DUOUT,DIRUT,DR,AV1,AV2,AV3,J,VAL,LRPAG,LRY
 N LREND,LRTST,LRSPEC,LRSCR,LRX,LINE,%ZIS,POP,I
 N ZTRTN,ZTIO,ZTDESC,ZTSAVE,ZTSK
 W @(IOF)
 I '$O(^LAB(60,"AV1",0)) D  Q
 . W !,"There are no AP CPRS definitions in the file"
 S DIR(0)="SO^1:Laboratory Test (#60);2:CPRS AP Screen (#67.91)"
 S DIR("A")="Sort Report by "
 S DIR("?")="How do you want the report to be sorted"
 D ^DIR
 S LRY=Y_","_Y(0) ;W !,Y,"  ",Y(0),LREND=0
 S %ZIS="QN",%ZIS("A")="Print on what Device ",%ZIS("B")="HOME"
 D ^%ZIS K %ZIS G:$G(POP) PRTEND
 I IO'=IO(0)!($D(IO("Q"))) D  G PRTEND
 . S ZTRTN="PRTTSK^LRAPKOEU",ZTIO="ION",ZTDESC="PRINT CPRS AP DIALOG LISTING "_Y(0)
 . S ZTSAVE("LRY*")="" D ^%ZTLOAD,^%ZISC
 . W !,$S($G(ZTSK):"Task # "_ZTSK,11:"Task Error")
PRTTSK ;Entry point for TASK Printing
 S VAL="^LAB(60,""AV1"")",LRPAG=0,LINE=0
 F  S VAL=$Q(@VAL) Q:$QS(VAL,2)'="AV1"  D
 . I +LRY=1 S AV1($P(^LAB(60,$QS(VAL,3),0),U)_"["_$QS(VAL,3)_"]",$P(^LAB(69.71,$QS(VAL,4),0),U))=""
 . I +LRY=2 S AV2($P(^LAB(69.71,$QS(VAL,4),0),U),$P(^LAB(60,$QS(VAL,3),0),U)_"["_$QS(VAL,3)_"]")=""
PO ;Print out put
 S LINE=1 I +LRY=1 D HDR1  D  ;Lab Test, CPRS Screen
 . S LRTST="" F  S LRTST=$O(AV1(LRTST)) Q:LRTST=""!($G(LREND))  D
 . . W !!,"TEST NAME: ",LRTST
 . . S LRSCR=""  F  S LRSCR=$O(AV1(LRTST,LRSCR)) Q:LRSCR=""!($G(LREND))  D
 . . . W !?5,"CPRS SCREEN: ",LRSCR D EPAGE Q:$G(LREND)
 I +LRY=2 D HDR1 D  ;CPRS Screen,Lab Test
 . S LRSCR="" F  S LRSCR=$O(AV2(LRSCR)) Q:LRSCR=""!($G(LREND))  D
 . . W !!,"CPRS Sreen Name: ",LRSCR  Q:$G(LREND)
 . . S LRTST="" F  S LRTST=$O(AV2(LRSCR,LRTST)) Q:LRTST=""!($G(LREND))  D
 . . . W !?5,"Laboratory Test: ",LRTST D EPAGE Q:$G(LREND)
 W !,$$CJ^XLFSTR("=================== END OF REPORT ===================",IOM)
PRTEND ;
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HDR1 ;
 ;W @IOF
 S LRPAG=$G(LRPAG)+1,LINE=3 W !!,$$CJ^XLFSTR("REPORT SORTED BY: "_$P(LRY,",",2)_"               PAGE: "_LRPAG,IOM),!,?10,"[#IEN]" Q
 ;
EPAGE ;Line counter
 S LINE=$G(LINE)+3 Q:LINE<(IOSL-3)
 K DIR,DTOUT,DUOUT,DIRUT,Y
 S LINE=2 W !
 I $E(IOST,1)="C" S DIR(0)="E" D ^DIR K DIR I $G(Y)=0 S LREND=1 Q
 D HDR1
 Q
