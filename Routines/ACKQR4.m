ACKQR4 ;AUG/JLTP BIR/PTD-Procedure Cost Statistics ; [ 12/07/95   9:52 AM ]
 ;;3.0;QUASAR;**8**;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
OPTN ;  Introduce option.
 W @IOF,!,"This option produces a report of all CPT-4 codes used within a selected date",!,"range and their associated costs.",!
 ;
 ; get Division
 S ACKDIV=$$DIV^ACKQUTL2(3,.ACKDIV,"AI") G:+ACKDIV=0 EXIT
 ;
 ; get date range
 D DTRANGE^ACKQRU G:$D(DIRUT) EXIT
 ;
DEV W !!,"The right margin for this report is 80.",!,"You can queue it to run at a later time.",!
 K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED." G EXIT
 I $D(IO("Q")) K IO("Q") S ZTRTN="DQ^ACKQR4",ZTDESC="QUASAR - Cost Comparison Report",ZTSAVE("ACK*")="" D ^%ZTLOAD D HOME^%ZIS K ZTSK G EXIT
DQ ; Entry point when queued.
 U IO
 D SORT,PRINT G EXIT
SORT ;
 N ACKTME
 K ^TMP("ACKQR4",$J) S ACKPG=0
 D NOW^%DTC
 S ACKXDT=$$NUMDT^ACKQUTL(%)_" at "_$$FTIME^ACKQUTL(%),ACKTME=$P(%,".",1)
 F ACKD=ACKBD:0 S ACKD=$O(^ACK(509850.6,"B",ACKD)) Q:'ACKD!(ACKD>ACKED)  S ACKV=0 F  S ACKV=$O(^ACK(509850.6,"B",ACKD,ACKV)) Q:'ACKV  D
 .S ACKHDR5=^ACK(509850.6,ACKV,5)
 .; get division and make sure it was selected
 .S ACKVDIV=$P(ACKHDR5,U,1) I '$D(ACKDIV(ACKVDIV)) Q
 .S ACKCSC=$P($G(^ACK(509850.6,ACKV,2)),U) Q:ACKCSC=""
 .I ACKCSC'="A",ACKCSC'="AT",ACKCSC'="S",ACKCSC'="ST" Q
 .S ACKP=0 F  S ACKP=$O(^ACK(509850.6,ACKV,3,ACKP)) Q:'ACKP  D
 ..S ACKPD=^ACK(509850.6,ACKV,3,ACKP,0),ACKPP=+ACKPD
 ..S ACKPN=$P($G(^ICPT(ACKPP,0)),U) Q:ACKPN=""  S ACKPDSC=$$PROCTXT^ACKQUTL8(ACKPP,ACKTME)
 ..S ACKPC=$P(^ACK(509850.4,ACKPP,0),U,6)
 ..; Get the Volume of times the Procedure was administered
 ..S ACKVOL=$P(ACKPD,U,3) I ACKVOL="" S ACKVOL=1
 ..S ACKM=0
 ..S:'$D(^TMP("ACKQR4",$J,0,ACKVDIV,ACKPP,ACKM)) ^(ACKM)=ACKPN_U_ACKPDSC_U_ACKPC
 ..S ^TMP("ACKQR4",$J,1,ACKVDIV,ACKCSC,ACKPP,ACKM)=$G(^TMP("ACKQR4",$J,1,ACKVDIV,ACKCSC,ACKPP,ACKM))+ACKVOL
 K ACKVDIV
 Q
PRINT ;
 I '$D(^TMP("ACKQR4",$J,1)) D  Q
 . D DHD("")
 . W !!,"No data found for report specifications."
 . D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
 ; print the report for each division
 S ACKDIV="" K ACKDCNT S ACKDCNT=0
 F  S ACKDIV=$O(ACKDIV(ACKDIV)) Q:ACKDIV=""!($D(DIRUT))  D PRINT2 Q:$D(DIRUT)
 I '$D(DIRUT) I ACKDCNT>0 D TOTALS
 Q
 ;
PRINT2 ; print for a single division
 I '$D(^TMP("ACKQR4",$J,1,ACKDIV)) D  Q
 . D DHD(1)
 . W !!,"No data found for report specifications.",!!
 . D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
 D DHD(1)
 ;
 S ACKCSC="",ACKT=0
 F  S ACKCSC=$O(^TMP("ACKQR4",$J,1,ACKDIV,ACKCSC)) Q:ACKCSC=""!($D(DIRUT))  D
 .I $Y>(IOSL-9) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D DHD(1)
 .S ACKCSX=$S(ACKCSC="A":"Audiology",ACKCSC="S":"Speech Pathology",ACKCSC="AT":"Audiology Telephone",ACKCSC="ST":"Speech Telephone",1:"")
 .W !!,"STOP CODE: ",ACKCSX S ACKT(ACKCSC)=0
 .S ACKPC=0 F  S ACKPC=$O(^TMP("ACKQR4",$J,1,ACKDIV,ACKCSC,ACKPC)) Q:'ACKPC!($D(DIRUT))  S ACKM="" F  S ACKM=$O(^TMP("ACKQR4",$J,1,ACKDIV,ACKCSC,ACKPC,ACKM)) Q:ACKM=""!($D(DIRUT))  S ACKD=^TMP("ACKQR4",$J,0,ACKDIV,ACKPC,ACKM) D
 ..I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D DHD(1)
 ..S ACKQQ=^TMP("ACKQR4",$J,1,ACKDIV,ACKCSC,ACKPC,ACKM),ACKTC=ACKQQ*$P(ACKD,U,3)
 ..S ACKT=ACKT+ACKTC,ACKT(ACKCSC)=ACKT(ACKCSC)+ACKTC
 ..W !,$J(ACKQQ,4),?6,$P(ACKD,U),?15,$P(ACKD,U,2),$S(ACKM]0:" "_$E(ACKM,1,29),1:"")
 ..W ?50,$J("$"_$J($P(ACKD,U,3),0,2),8),?60,$J("$"_$J(ACKTC,0,2),10)
 .W !!,ACKCSX," Total:",?60,$J("$"_$J(ACKT(ACKCSC),0,2),10)
 Q:$D(DIRUT)
 I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D DHD(1)
 W !!,"Grand Total: ",?60,$J("$"_$J(ACKT,0,2),10)
 D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
 S ACKDCNT=ACKDCNT+ACKT
 S ACKDCNT(ACKDIV)=ACKT
 Q
DHD(ACKDHD) ;
 W:($E(IOST)="C")!(ACKPG>0) @IOF
 S ACKPG=ACKPG+1
 W "Printed: ",ACKXDT,?(IOM-8),"Page: ",ACKPG,!
 F X="Procedure Cost Comparison","for Date Range",ACKXBD_" to "_ACKXED W ! D CNTR^ACKQUTL(X)
 I ACKDHD W ! D CNTR^ACKQUTL("For Division: "_$$DIVNAME(ACKDIV))
 W !!,"QUAN",?6,"CODE",?15,"DESCRIPTION",?54,"COST",?65,"TOTAL"
 S X="",$P(X,"-",IOM)="-" W !,X
 Q
 ;
EXIT ;
 K ACKBD,ACKCSC,ACKCSX,ACKD,ACKED,ACKM,ACKMP,ACKP,ACKPC,ACKPD,ACKPDSC,ACKPG,ACKPN,ACKPP,ACKQQ,ACKT,ACKTC,ACKV,ACKXBD,ACKXDT,ACKXED,X,Y,ZTSK,^TMP("ACKQR4",$J)
 K ACKVOL,ACKHDR5,ACKDIV
 W:$E(IOST)="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
DIVNAME(ACKVDIV) ; get division name
 Q $$GET1^DIQ(40.8,ACKDIV_",",.01)
 ;
 ;
TOTALS ;  Display Totals
 S ACKPG=ACKPG+1 W @IOF,"Printed: ",ACKXDT,?(IOM-8),"Page: ",ACKPG,!
 F X="Procedure Cost Comparison","for Date Range",ACKXBD_" to "_ACKXED W ! D CNTR^ACKQUTL(X)
 W ! D CNTR^ACKQUTL("Summary") W !
 S X="",$P(X,"-",IOM)="-" W !,X,!!
 ;
 S ACKDIV=""
 F  S ACKDIV=$O(ACKDCNT(ACKDIV)) Q:ACKDIV=""  D
 . W !,?8,"Total for Division: "_$$DIVNAME(ACKDIV),?57,$J("$"_$J(ACKDCNT(ACKDIV),0,2),10)
 W !!,?8,"Grand Total for all Divisions  ",?57,$J("$"_$J(ACKDCNT,0,2),10)
 Q
