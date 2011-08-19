IBJDB13 ;ALB/CPM - BILLING LAG TIME REPORT (INPT PRINT) ; 02-JAN-97
 ;;2.0;INTEGRATED BILLING;**100,118**;21-MAR-94
 ;
INP ; - Print the inpatient report.
 F IBX=5,"6I",9,10,"7I","8I",11,6,7,8 I IBSEL[(","_IBX_",") D  Q:IBQ
 .I '$D(^TMP("IBJDB1",$J,IBDIV,"IN",IBX)) D  Q
 ..S IBPAG=0 D INPH I IBQ Q
 ..W !!,"There was no ",$$TITLE^IBJDB1(+IBX,0)
 ..I IBX["I" W " (Late Insurance)"
 ..W !," claim activity during this period." D PAUSE
 .;
 .S IBPAG=0 D INPH I IBQ Q
 .K IBCT,IBTL S (IBCT(IBX),IBTL(IBX))=0,IBX1=""
 .F  S IBX1=$O(^TMP("IBJDB1",$J,IBDIV,"IN",IBX,IBX1)) Q:IBX1=""  D  Q:IBQ
 ..I $Y>(IOSL-2) D PAUSE Q:IBQ  D INPH Q:IBQ
 ..D WPATI S (IBH,IBX2)=0
 ..F  S IBX2=$O(^TMP("IBJDB1",$J,IBDIV,"IN",IBX,IBX1,IBX2)) Q:'IBX2  S IBX3=$G(^(IBX2)) D  Q:IBQ
 ...I $Y>(IOSL-4) D PAUSE Q:IBQ  D INPH,WPATI Q:IBQ  S IBH=0
 ...;
 ...; - Write bill #, dates and total days.
 ...W:IBH ! I 'IBH S IBH=1
 ...W ?40,$P(IBX3,U),?50,$$DTE($P(IBX3,U,2)),$P(IBX3,U,5)
 ...W ?63,$$DTE($P(IBX3,U,3)),?76,$J($P(IBX3,U,4),4)
 ...S IBCT(IBX)=IBCT(IBX)+1,IBTL(IBX)=IBTL(IBX)+$P(IBX3,U,4)
 .;
 .D AVG,PAUSE
 ;
INPQ Q
 ;
WPATI ; - Write inpatient patient data.
 W !,$E($P(IBX1,"@@"),1,25),?27,$$SSN($P(IBX1,"@@",2))
 Q
 ;
INPH ; - Write the inpatient detail report header.
 W @IOF,*13 S IBPAG=$G(IBPAG)+1
 W !,"Inpatient Billing Lag Time Report"
 W ?48,IBRUN,?72,"Page ",$J(IBPAG,3)
 W !,$$TITLE^IBJDB1(+IBX,0) I IBX["I" W " (Late Insurance)"
 W !,"Claims w/activity from ",$$DTE(IBBDT)," to ",$$DTE(IBEDT)
 W " (*=Insurance found after trmt)"
 W:IBDIV !,"Division: ",$P($G(^DG(40.8,IBDIV,0)),U) W !!
 W:IBX=5!(IBX[7)!(IBX[8)!(IBX=11) ?50,"Date of"
 W:IBX[6 ?50,"Date PTF" W:IBX=9!(IBX=10) ?50,"Date Claim"
 W:IBX=5 ?63,"Date PTF" W:IBX[7!(IBX=10) ?63,"Date of"
 W:IBX[6!(IBX=9) ?63,"Date Claim"
 W ?76,"# of",!,"Patient",?27,"SSN",?40,"Bill #"
 W:IBX=5!(IBX[7)!(IBX[8) ?50,"Discharge"
 W:IBX[6 ?50,"Transmitted" W:IBX=9 ?50,"Authorized"
 W:IBX=10 ?51,"Activated" W:IBX=11 ?50,"First Paymt"
 W:IBX=5 ?63,"Transmitted" W:IBX[6 ?63,"Authorized"
 W:IBX[7!(IBX=10) ?63,"First Paymt" W:IBX[8!(IBX=11) ?63,"Date Closed"
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
