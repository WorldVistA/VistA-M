PRCPAWR0 ;WISC/RFJ/BGJ-print register approval form ;9.9.97
 ;;5.1;IFCAP;**14**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I PRCP("DPTYPE")'="W" W !,"ONLY THE WAREHOUSE CAN USE THIS OPTION." Q
 N %,PRCPFALL,PRCPMULT,TOTAL,TRANID
 ;
 ;  select list of adjustments
 K ^TMP($J,"PRCPAWR0")
 W !!,"To select ALL adjustments, press RETURN."
 S TOTAL=0 F  S TRANID=$$ADJUSTNO^PRCPAWAP Q:TRANID["^"  S ^TMP($J,"PRCPAWR0",TRANID)="",TOTAL=TOTAL+1
 I $O(^TMP($J,"PRCPAWR0",""))="" S XP="Do you want to select ALL adjustments",XH="Enter 'YES' to select ALL adjustments, 'NO' or '^' to exit." W ! S %=$$YN^PRCPUYN(1) Q:'%  I %=1 S PRCPFALL=1
 I '$G(PRCPFALL),$O(^TMP($J,"PRCPAWR0",""))="" Q
 ;
 ;  if more than one adjustment is selected, ask to print one
 ;  report or multiple reports.
 S PRCPMULT=1
 I $G(PRCPFALL)!(TOTAL>1) D  I %<1 Q
 .   S XP="DO YOU WANT TO PRINT A SEPARATE REPORT FOR EACH ADJUSTMENT (THIS WILL",XP(1)="USE A LOT OF PAPER)"
 .   S XH="ENTER 'YES' TO PRINT EACH UNAPPROVED ADJUSTMENT ON A SINGLE PIECE OF PAPER,",XH(1)="      'NO' TO PRINT ALL UNAPPROVED ADJUSTMENTS ON THE SAME REPORT."
 .   W !! S %=$$YN^PRCPUYN(2) I %=2 K PRCPMULT
 ;
 S %ZIS="Q" W ! D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK D Q Q
 .   S ZTDESC="Adjustment Approval Form",ZTRTN="DQ^PRCPAWR0"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("^TMP($J,""PRCPAWR0"",")="",ZTSAVE("ZTREQ")="@"
 ;
DQ ;  queue starts here.
 N %,%H,%I,ACCOUNT,ACCT,ADJDT,DA,DATA,INVPT,NOW,NSN,PAGE,PRCPFLAG,SCREEN,TOTAL,TRANID,VALUEINV,VALUESAL,VOUCHER,X,Y
 ;  build adjustments from ^tmp($j,"prcpawr0",tranid)=""
 D BUILD^PRCPAWR1
 ;
 ;  start printing report.
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=0,SCREEN=$$SCRPAUSE^PRCPUREP U IO
 S TRANID="A" F  S TRANID=$O(^TMP($J,"PRCPAWR0 DA",TRANID)) Q:$E(TRANID)'="A"!($D(PRCPFLAG))  K ADJDT,INVPT S DA=0 F  S DA=$O(^TMP($J,"PRCPAWR0 DA",TRANID,DA)) Q:'DA!($D(PRCPFLAG))  D
 .   S DATA=$G(^PRCP(445.2,DA,0)) I DATA="" Q
 .   S VOUCHER=$P(DATA,"^",15)
 .   I $G(PRCPMULT),'$D(ADJDT) S Y=$P(DATA,"^",17) I +Y D DD^%DT S ADJDT=Y
 .   I $G(PRCPMULT),'$D(INVPT),$P(DATA,"^",18) S INVPT=$$INVNAME^PRCPUX1($P(DATA,"^",18))
 .   I PAGE=0 S PAGE=1 D H
 .   ;
 .   S NSN=$$NSN^PRCPUX1(+$P(DATA,"^",5)),ACCT=$$ACCT1^PRCPUX1($E(NSN,1,4))
 .   W !!,NSN,?19,$E($$DESCR^PRCPUX1(PRCP("I"),$P(DATA,"^",5)),1,28),?49,"#",$P(DATA,"^",5),?60,"ACCT: ",ACCT,?73,$J($$INITIALS^PRCPUREP($P(DATA,"^",16)),6)
 .   S VALUEINV=$J($P(DATA,"^",7)*$P(DATA,"^",8),0,2),VALUESAL=$J($P(DATA,"^",7)*$P(DATA,"^",9),0,2)
 .   I $P(DATA,"^",22)'="" S VALUEINV=$J($P(DATA,"^",22),0,2),VALUESAL=$J($P(DATA,"^",23),0,2)
 .   S ACCOUNT(ACCT)=$G(ACCOUNT(ACCT))+VALUEINV
 .   W !,$P(DATA,"^",2),?13,$P(DATA,"^",19),?33,$J($P(DATA,"^",6),8),$J($P(DATA,"^",7),11),$J(VALUESAL,14,2),$J(VALUEINV,14,2)
 .   I $D(^PRCP(445.2,DA,1)) W !,$P(^(1),"^")
 .   I $Y>(IOSL-7) D:$G(SCREEN) P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   I '$D(PRCPFLAG),$G(PRCPMULT),'$O(^TMP($J,"PRCPAWR0 DA",TRANID,DA)) D END^PRCPAWR1 Q:$D(PRCPFLAG)
 I $D(PRCPFLAG) S PRCPMULT=1
 I '$D(PRCPMULT) D END^PRCPAWR1
Q D ^%ZISC K ^TMP($J,"PRCPAWR0"),^TMP($J,"PRCPAWR0 DA")
 Q
 ;
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"ADJUSTMENT APPROVAL FORM FROM ",PRCP("IN"),?(80-$L(%)),%
 I $D(INVPT) W !?5,"DISTRIBUTION TO: ",INVPT
 I $D(ADJDT) W !?5,"ADJUSTMENT DATE: ",ADJDT,?50,"VOUCHER: ",VOUCHER
 W !,"NSN",?19,"DESCRIPTION",?49,"[#MI]",?60,"ACCT CODE",?72,"INITIALS"
 S %="",$P(%,"-",81)="" W !,"TRANSID",?13,"TRANS./P.O.",?38,"U/I",?43,$J("QUANTITY",9),$J("SELL VALUE",14),$J("INV VALUE",14),!,%
 Q
 ;
 ;
PRINFORM(TRANID)   ;  print adjustment approval form
 N %,PRCPMULT
 K ^TMP($J,"PRCPAWR0")
 S ^TMP($J,"PRCPAWR0",TRANID)=""
 S PRCPMULT=1
 W !!,"Queueing Approval Form to Print on 'Fiscal (Receiving Reports)' Printer ..." S %=$O(^PRC(411,PRC("SITE"),2,"AC","FR",0))
FP I %="" W !?5,">> WARNING: DEVICE NOT FOUND IN SITE PARAMETERS FILE 411. >>",! S IOP="Q" D ^%ZIS S %=IO I '$G(IO("Q")) W !!,"MUST QUEUE OUTPUT",! S %="" G FP
 E  S ZTIO=%,ZTDTH=$H D  D ^%ZTLOAD K IOP D ^%ZISC
 .   S ZTDESC="Adjustment Approval Form (Fiscal)",ZTRTN="DQ^PRCPAWR0"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("^TMP($J,""PRCPAWR0"",")="",ZTSAVE("ZTREQ")="@"
 ;
 W !,"Queueing Approval Form to Print on 'Supply (PPM)' Printer ..." S %=$O(^PRC(411,PRC("SITE"),2,"AC","S",0))
SP I %="" W !?5,">> WARNING: DEVICE NOT FOUND IN SITE PARAMETERS FILE 411. >>",! S IOP="Q" D ^%ZIS S %=IO I '$G(IO("Q")) W !!,"MUST QUEUE OUTPUT",! S %="" G SP
 E  S ZTIO=%,ZTDTH=$H D  D ^%ZTLOAD K IOP D ^%ZISC
 .   S ZTDESC="Adjustment Approval Form (Supply)",ZTRTN="DQ^PRCPAWR0"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("^TMP($J,""PRCPAWR0"",")="",ZTSAVE("ZTREQ")="@"
 ;
 K ^TMP($J,"PRCPAWR0")
 Q
