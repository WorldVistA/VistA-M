PRCARFD3 ;WASH-ISC@ALTOONA,PA/LDB-LIST REFUNDS TO BE APPROVED ;8/19/94  3:03 PM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;;
 N D0,OUT,X,Y,STAT,POP
 S %ZIS("A")="Select the output device: ",%ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="EN^PRCARFD3",ZTDESC="REFUNDS PENDING CERTIFYING OFFICIAL'S APPROVAL",ZTDTH=$H D ^%ZTLOAD Q
EN U IO
 W:IOST?1"C".E @IOF
 D HDR
 S STAT=$O(^PRCA(430.3,"AC",113,0)) Q:'STAT
 S D0=0 F  S D0=$O(^PRCA(430,"AC",STAT,D0)),X="" Q:'D0!($D(OUT))  I $P($G(^PRCA(430,+D0,7)),"^",21)]"" W ! D ^PRCATRF W ! I ($Y+5)>IOSL D
 .I $E(IOST)="C" R !,"Press Return to continue or ""^"" to exit ",X:DTIME I X="^"!'$T S OUT=1 Q
 .I $O(^PRCA(430,"AC",STAT,D0)) W @IOF D HDR
 D ^%ZISC Q
 ;
HDR W !?15,"REFUNDS PENDING CERTIFYING OFFICIAL'S APPROVAL",!
 W !,"BILL NO.",?15,"PATIENT",?47,"REVIEWED DATE",?68,"AMOUNT",!,?47,"REVIEWED BY"
 S X="",$P(X,"-",IOM)="" W !,X,!
 Q
