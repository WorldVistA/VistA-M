IBJDB12 ;ALB/CPM - BILLING LAG TIME REPORT (OPT PRINT/SUMMARIES) ; 30-DEC-96
 ;;2.0;INTEGRATED BILLING;**69,100,118**;21-MAR-94
 ;
OPT ; - Print the outpatient report.
 F IBX=1,"2I",9,10,"3I","4I",11,2,3,4 I IBSEL[(","_IBX_",") D  Q:IBQ
 .I '$D(^TMP("IBJDB1",$J,IBDIV,"OP",IBX)) D  Q
 ..S IBPAG=0 D OPTH I IBQ Q
 ..W !!,"There was no ",$$TITLE^IBJDB1(+IBX,0)
 ..I IBX["I" W " (Late Insurance)"
 ..W !," claim activity during this period." D PAUSE
 .;
 .S IBPAG=0 D OPTH I IBQ Q
 .K IBCT,IBTL S (IBCT(IBX),IBTL(IBX))=0,IBX1=""
 .F  S IBX1=$O(^TMP("IBJDB1",$J,IBDIV,"OP",IBX,IBX1)) Q:IBX1=""  D  Q:IBQ
 ..I $Y>(IOSL-2) D PAUSE Q:IBQ  D OPTH Q:IBQ
 ..D WPAT S (IBH,IBX2)=0
 ..F  S IBX2=$O(^TMP("IBJDB1",$J,IBDIV,"OP",IBX,IBX1,IBX2)) Q:'IBX2  S IBX3=$G(^(IBX2)) D  Q:IBQ
 ...I $Y>(IOSL-4) D PAUSE Q:IBQ  D OPTH,WPAT Q:IBQ  S IBH=0
 ...;
 ...; - Write bill #, dates and total days.
 ...W:IBH ! I 'IBH S IBH=1
 ...W ?40,$P(IBX3,U),?50,$$DTE($P(IBX3,U,2)),$P(IBX3,U,5)
 ...W ?63,$$DTE($P(IBX3,U,3)),?76,$J($P(IBX3,U,4),4)
 ...S IBCT(IBX)=IBCT(IBX)+1,IBTL(IBX)=IBTL(IBX)+$P(IBX3,U,4)
 .;
 .D AVG,PAUSE
 ;
OPTQ Q
 ;
OPTH ; - Write the outpatient detail report header.
 W @IOF,*13 S IBPAG=$G(IBPAG)+1
 W !,"Outpatient Billing Lag Time Report"
 W ?48,IBRUN,?72,"Page ",$J(IBPAG,3)
 W !,$$TITLE^IBJDB1(+IBX,0) I IBX["I" W " (Late Insurance)"
 W !,"Claims w/activity from ",$$DTE(IBBDT)," to ",$$DTE(IBEDT)
 W " (*=Insurance found after trmt)"
 W:IBDIV !,"Division: ",$P($G(^DG(40.8,IBDIV,0)),U) W !!
 W:IBX[2!(IBX=11) ?50,"Date of" W:IBX=9!(IBX=10) ?50,"Date Claim"
 W:IBX=1!(IBX[3)!(IBX=10) ?63,"Date of" W:IBX[2!(IBX=9) ?63,"Date Claim"
 W ?76,"# of",!,"Patient",?27,"SSN",?40,"Bill #"
 W:IBX=1!(IBX[3)!(IBX[4) ?50,"Date of Care"
 W:IBX[2 ?50,"Check Out" W:IBX=9 ?50,"Authorized"
 W:IBX=10 ?51,"Activated" W:IBX=11 ?50,"First Paymt"
 W:IBX=1 ?63,"Check Out" W:IBX[3!(IBX=10) ?63,"First Paymt"
 W:IBX[4!(IBX=11) ?63,"Date Closed" W:IBX[2 ?63,"Authorized"
 W:IBX=9 ?64,"Activated" W ?76,"Days",!,$$DASH(80)
 S IBQ=$$STOP^IBOUTL("Billing Lag Time Report")
 Q
 ;
AVG ; - Write total days and average line.
 W !?75,"-----",!,"Average Number of Days for",?75,$J(IBTL(IBX),5)
 W !,$$TITLE^IBJDB1(+IBX,0),$S(IBX["I":" (Late Ins)",1:""),": "
 W $J($S('IBCT(IBX):0,1:IBTL(IBX)/IBCT(IBX)),0,2)
 W " (",IBCT(IBX)," claim",$S(IBCT(IBX)>1:"s",1:""),")"
 Q
 ;
WPAT ; - Write patient data.
 W !,$E($P(IBX1,"@@"),1,25),?27,$$SSN($P(IBX1,"@@",2))
 Q
 ;
SUM ; - Print the summary reports.
 D OPTS,PAUSE I IBQ G SUMQ
 D INPS,PAUSE
SUMQ Q
 ;
OPTS ; - Print the outpatient summary report.
 I $E(IOST,1,2)="C-" W @IOF,*13
 W !?32,"BILLING LAG TIME"
 D CTR("OUTPATIENT SUMMARY REPORT"_$S(IBDIV:" for "_$P($G(^DG(40.8,IBDIV,0)),U),1:""))
 D CTR("Receivables with activity from "_$$DTE(IBBDT)_" to "_$$DTE(IBEDT))
 D CTR("Run Date: "_IBRUN) W !?12,$$DASH(55)
 W !!?2,"Time Period",?50,"Average Number of days"
 W !?2,"-----------",?50,"----------------------"
 W !?2,$$TITLE^IBJDB1(1,0),?55,$J($S('IBCT(IBDIV,"OP",1):0,1:IBTL(IBDIV,"OP",1)/IBCT(IBDIV,"OP",1)),7,2)," (",IBCT(IBDIV,"OP",1)," claims)"
 W !?2,$$TITLE^IBJDB1(2,0),"-LI",?55,$J($S('IBCT(IBDIV,"OP","2I"):0,1:IBTL(IBDIV,"OP","2I")/IBCT(IBDIV,"OP","2I")),7,2)," (",IBCT(IBDIV,"OP","2I")," claims)"
 W !?2,$$TITLE^IBJDB1(9,0),?55,$J($S('IBCT(IBDIV,"OP",9):0,1:IBTL(IBDIV,"OP",9)/IBCT(IBDIV,"OP",9)),7,2)," (",IBCT(IBDIV,"OP",9)," claims)"
 W !?2,$$TITLE^IBJDB1(10,0),?55,$J($S('IBCT(IBDIV,"OP",10):0,1:IBTL(IBDIV,"OP",10)/IBCT(IBDIV,"OP",10)),7,2)," (",IBCT(IBDIV,"OP",10)," claims)"
 W !?2,$$TITLE^IBJDB1(3,0),"-LI",?55,$J($S('IBCT(IBDIV,"OP","3I"):0,1:IBTL(IBDIV,"OP","3I")/IBCT(IBDIV,"OP","3I")),7,2)," (",IBCT(IBDIV,"OP","3I")," claims)"
 W !?2,$$TITLE^IBJDB1(4,0),"-LI",?55,$J($S('IBCT(IBDIV,"OP","4I"):0,1:IBTL(IBDIV,"OP","4I")/IBCT(IBDIV,"OP","4I")),7,2)," (",IBCT(IBDIV,"OP","4I")," claims)"
 W !?2,$$TITLE^IBJDB1(11,0),?55,$J($S('IBCT(IBDIV,"OP",11):0,1:IBTL(IBDIV,"OP",11)/IBCT(IBDIV,"OP",11)),7,2)," (",IBCT(IBDIV,"OP",11)," claims)"
 W !!?2,$$TITLE^IBJDB1(2,0),"+",?55,$J($S('IBCT(IBDIV,"OP",2):0,1:IBTL(IBDIV,"OP",2)/IBCT(IBDIV,"OP",2)),7,2)," (",IBCT(IBDIV,"OP",2)," claims)"
 W !?2,$$TITLE^IBJDB1(3,0),"+",?55,$J($S('IBCT(IBDIV,"OP",3):0,1:IBTL(IBDIV,"OP",3)/IBCT(IBDIV,"OP",3)),7,2)," (",IBCT(IBDIV,"OP",3)," claims)"
 W !?2,$$TITLE^IBJDB1(4,0),"+",?55,$J($S('IBCT(IBDIV,"OP",4):0,1:IBTL(IBDIV,"OP",4)/IBCT(IBDIV,"OP",4)),7,2)," (",IBCT(IBDIV,"OP",4)," claims)"
 I $E(IOST,1,2)="C-" D
 .W !!?2,"*LI=Late Insurance (policy identified after treatment)"
 .W !?2,"+This element does not include Late Insurance claims"
 E  W !!
 Q
 ;
INPS ; - Print the inpatient summary report.
 I $E(IOST,1,2)="C-" W @IOF,*13
 W !?32,"BILLING LAG TIME"
 D CTR("INPATIENT SUMMARY REPORT"_$S(IBDIV:" for "_$P($G(^DG(40.8,IBDIV,0)),U),1:""))
 D CTR("Receivables with activity from "_$$DTE(IBBDT)_" to "_$$DTE(IBEDT))
 I $E(IOST,1,2)="C-" D CTR("Run Date: "_IBRUN)
 W !?12,$$DASH(55)
 W !!?2,"Time Period",?50,"Average Number of days"
 W !?2,"-----------",?50,"----------------------"
 W !?2,$$TITLE^IBJDB1(5,0),?55,$J($S('IBCT(IBDIV,"IN",5):0,1:IBTL(IBDIV,"IN",5)/IBCT(IBDIV,"IN",5)),7,2)," (",IBCT(IBDIV,"IN",5)," claims)"
 W !?2,$$TITLE^IBJDB1(6,0),"-LI",?55,$J($S('IBCT(IBDIV,"IN","6I"):0,1:IBTL(IBDIV,"IN","6I")/IBCT(IBDIV,"IN","6I")),7,2)," (",IBCT(IBDIV,"IN","6I")," claims)"
 W !?2,$$TITLE^IBJDB1(9,0),?55,$J($S('IBCT(IBDIV,"IN",9):0,1:IBTL(IBDIV,"IN",9)/IBCT(IBDIV,"IN",9)),7,2)," (",IBCT(IBDIV,"IN",9)," claims)"
 W !?2,$$TITLE^IBJDB1(10,0),?55,$J($S('IBCT(IBDIV,"IN",10):0,1:IBTL(IBDIV,"IN",10)/IBCT(IBDIV,"IN",10)),7,2)," (",IBCT(IBDIV,"IN",10)," claims)"
 W !?2,$$TITLE^IBJDB1(7,0),"-LI",?55,$J($S('IBCT(IBDIV,"IN","7I"):0,1:IBTL(IBDIV,"IN","7I")/IBCT(IBDIV,"IN","7I")),7,2)," (",IBCT(IBDIV,"IN","7I")," claims)"
 W !?2,$$TITLE^IBJDB1(8,0),"-LI",?55,$J($S('IBCT(IBDIV,"IN","8I"):0,1:IBTL(IBDIV,"IN","8I")/IBCT(IBDIV,"IN","8I")),7,2)," (",IBCT(IBDIV,"IN","8I")," claims)"
 W !?2,$$TITLE^IBJDB1(11,0),?55,$J($S('IBCT(IBDIV,"IN",11):0,1:IBTL(IBDIV,"IN",11)/IBCT(IBDIV,"IN",11)),7,2)," (",IBCT(IBDIV,"IN",11)," claims)"
 W !!?2,$$TITLE^IBJDB1(6,0),"+",?55,$J($S('IBCT(IBDIV,"IN",6):0,1:IBTL(IBDIV,"IN",6)/IBCT(IBDIV,"IN",6)),7,2)," (",IBCT(IBDIV,"IN",6)," claims)"
 W !?2,$$TITLE^IBJDB1(7,0),"+",?55,$J($S('IBCT(IBDIV,"IN",7):0,1:IBTL(IBDIV,"IN",7)/IBCT(IBDIV,"IN",7)),7,2)," (",IBCT(IBDIV,"IN",7)," claims)"
 W !?2,$$TITLE^IBJDB1(8,0),"+",?55,$J($S('IBCT(IBDIV,"IN",8):0,1:IBTL(IBDIV,"IN",8)/IBCT(IBDIV,"IN",8)),7,2)," (",IBCT(IBDIV,"IN",8)," claims)"
 W !!?2,"*LI=Late Insurance (policy identified after treatment)"
 W !?2,"+This element does not include Late Insurance claims"
 Q
 ;
CTR(X) ; - Center and write text.
 W !?(80-$L(X))\2,X
 Q
 ;
DASH(X) ; - Return a dashed line.
 Q $TR($J("",X)," ","=")
 ;
PAUSE ; - Page break.
 I $E(IOST,1,2)'="C-" Q
 N IBX,DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 F IBX=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR I $D(DIRUT)!($D(DUOUT)) S IBQ=1
 Q
 ;
SSN(X) ; - Format the SSN.
 Q $S(X]"":$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,10),1:"")
 ;
DTE(X) ; - Format date (MMM DD,YYYY).
 S:'X X="" S Y=X X ^DD("DD") Q Y
