RAORD7 ;HISC/CAH AISC/RMO-Log of Scheduled Requests by Procedure ;11/8/01  08:00
 ;;5.0;Radiology/Nuclear Medicine;**15,31**;Mar 16, 1998
 ;;This routine looks at orders in file 75.1 with field 23 (Scheduled date) within the date range selected. User also selects order statuses to include.
DATE D SET^RAPSET1 I $D(XQUIT) K RAED,XQUIT Q
 S %DT("A")="Starting Scheduled Date: ",%DT="EXA" W ! D ^%DT K %DT G Q^RAORD7A:Y<0 S RALDTE1=Y
 S %DT("A")="Ending Scheduled Date: ",%DT="EXAT" W ! D ^%DT K %DT G Q^RAORD7A:Y<0 S RALDTE2=Y
 I RALDTE2<RALDTE1 W !?5,"  ?? Starting date must be before ending date.  Please try again.",! G DATE
 I RALDTE2#1=0 S RALDTE2=RALDTE2+.2359
 W !!,"Enter  *  to select all imaging locations that",!,"you are allowed here (enter ?? to view them.)"
 D OMA^RAUTL13 G Q^RAORD7A:'$L($O(RALOC(0)))!($G(RAQUIT)=1)
 S %DT="R",X="NOW" D ^%DT I Y>RALDTE1,Y'<RALDTE2 D
 . K DIR S DIR(0)="Y",DIR("A")="Include only orders not registered (no-show's)",DIR("B")="NO",DIR("?")=" "
 . S DIR("?",1)="If you have entered a date range in the past, and answer 'Yes' to this question,"
 . S DIR("?",2)="the log will only include orders that have not yet reached an 'active' status.",DIR("?",3)="In other words, the orders that appear on the log are probably no-show's." W ! D ^DIR
 . I Y=1 S RANOSHOW=1 ;User wants a no-show report
 I $D(DTOUT)!($D(DUOUT)) G Q^RAORD7A
 K DIR S DIR(0)="S^P:Procedure Name;D:Date/Time",DIR("A")="Sort by (P)rocedure Name or (D)ate/Time",DIR("B")="P" D ^DIR G:'$D(Y(0)) Q^RAORD7A S RASORT=Y(0) K DIR
 F I=1,2,6 S RANO(I)=""
 W !!!,"Scheduled requests to be included on this report are:",!
 I $D(RANOSHOW) W !,"No-show's only."
 W !,"Starting Schedule date: " W $$FMTE^XLFDT(RALDTE1,"P")
 W !,"Ending Schedule date:   " W $$FMTE^XLFDT(RALDTE2,"P")
 W !,"Locations:  " S I=0 F  S I=$O(RALOC(I)) Q:I=""  W I W:$X>(IOM-25) ! W ?($X+5)
 W !!,"Sorted by: ",RASORT,!
 K DIR S DIR(0)="Y",DIR("A")="SELECTION CRITERIA OK",DIR("B")="YES" W ! D ^DIR
 I $D(DUOUT)!($D(DTOUT)) G Q^RAORD7A
 I Y'=1 G DATE
 ;
 S:$D(RANOSHOW) ZTSAVE("RANOSHOW")=""
 S ZTRTN="START^RAORD7A",ZTSAVE("RALDTE1")="",ZTSAVE("RALDTE2")="",ZTSAVE("RAST")="",ZTSAVE("RALOC(")="",ZTSAVE("RAORST(")="",ZTSAVE("RASORT")="" W ! D ZIS^RAUTL G Q^RAORD7A:RAPOP
 G ^RAORD7A
