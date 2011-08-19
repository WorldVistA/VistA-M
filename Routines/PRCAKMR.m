PRCAKMR ;WASH-ISC@ALTOONA,PA/CMS-Print Status PENDING ARCHIVE ;8/3/93  12:09 PM
V ;;4.5;Accounts Receivable;**78**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Loop on Pending Archive status, entry point after device selection
 NEW PG,PRCAE,PRCAT,STAT,TR,X,Y
 D HDR
 S STAT=+$O(^PRCA(430.3,"B","PENDING ARCHIVE",0))
 I $P($G(^PRCA(430.3,STAT,0)),"^",1)'="PENDING ARCHIVE" W !!,?5,"* The Pending Archive status is not defined.  Please contact IRM!",! G Q1
 F PRCAE=0:0 S PRCAE=$O(^PRCA(430,"AC",STAT,PRCAE)) Q:'PRCAE  S X="" D HDR:$Y+5>IOSL Q:X="^"  D PRNTL
 I $G(X)'="^" W !!!,?5,+$G(PRCAT)," Bills marked Pending Archive"
 G Q1
PRNTL ;
 ;Print detail data line on report
 S PRCAT=$G(PRCAT)+1
 S X=$S($D(^PRCA(430,PRCAE,0)):^(0),1:"") G:X="" PQ W !,$E($P(X,U,1),1,11)
 W ?13,$S($P(X,U,9):$E($P($$NAM^RCFN01($P(X,U,9)),U),1,21),1:"UNKNOWN")
 W ?36,$S($P(X,U,2):$P($G(^PRCA(430.2,$P(X,U,2),0)),U,2),1:"")
 W ?42,$E($P($G(^PRCA(430.3,+$P($G(^PRCA(430,PRCAE,9)),U,6),0)),U,1),1,10)
 W ?54 S Y=$G(^PRCA(430,PRCAE,7)),Y=$P(Y,"^",1)+$P(Y,"^",2)+$P(Y,"^",3)+$P(Y,"^",4)+$P(Y,"^",5) W $J(Y,0,2)
 W ?67 S Y=$$PUR^PRCAFN(PRCAE) I Y>0 S Y=$P(Y,".",1) X ^DD("DD") W Y
PQ Q
HDR ;
 ;Print header on top of page
 I $E(IOST,1,2)="C-",$G(PG) S X="" R !,"Enter '^' to exit, press any key to continue: ",X:DTIME S:'$T X="^" Q:X="^"
 W @IOF S PG=$G(PG)+1
 N %,%H,%I,X,Y
 D NOW^%DTC S Y=% D DD^%DT
 W !,"Status: PENDING ARCHIVE",?46,Y,?70,"PAGE ",PG
 W !!,?42,"Old Bill",?67,"Last Date",!,"Bill No.",?13,"Debtor",?36,"Cat.",?42,"Status",?54,"Balance",?67,"Activity"
 W ! S X="",$P(X,"-",IOM-1)="" W X,!
 Q
ST ;
 NEW ZTSK,STAT
 W !!,"This report will print the AR bills in the PENDING ARCHIVE status.",!
 L +^PRCAK("PRCAK"):1 I '$T W !!,"Another Archive process is running. This report may not be",!,"accurate.  You may want to re-run at a later time.",!
 L -^PRCAK("PRCAK")
 S %ZIS="MQ" D ^%ZIS G:POP Q1
 I '$D(IO("Q")) U IO D PRCAKMR Q
 S ZTRTN="^PRCAKMR",ZTDESC="AR PENDING ARCHIVE Listing" D ^%ZTLOAD
Q1 D ^%ZISC K POP
 Q
