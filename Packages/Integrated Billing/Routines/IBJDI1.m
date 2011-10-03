IBJDI1 ;ALB/CPM - PERCENTAGE OF COMPLETED REGISTRATIONS ;16-DEC-96
 ;;2.0;INTEGRATED BILLING;**69,98,100,118,128,123,249**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; - Option entry point.
 ;
 W !!,"This report measures the number of registrations which are being entered"
 W !,"without inconsistencies. Please enter a date range representing the dates"
 W !,"that patients were first entered into the system.",!
 ;
DATE D DATE^IBOUTL I IBBDT=""!(IBEDT="") G ENQ
 ;
 ; - Sort by division?
 S DIR(0)="Y",DIR("B")="NO",DIR("?")="^D DHLP^IBJDI1"
 S DIR("A")="Do you wish to sort this report by division" W !
 D ^DIR S IBSORT=+Y I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G ENQ
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 ;
 I IBSORT D PSDR^IBODIV G:Y<0 ENQ ; Select division(s).
 ;
 ; - Select a detailed or summary report.
 D DS^IBJD I IBRPT["^" G ENQ
 ;
 I IBRPT="D" W !!,"You will need a 132 column printer for this report!"
 E  W !!,"This report only requires an 80 column printer."
 W !!,"Note: This report requires a search through the entire Patient file."
 W !?6,"You should queue this report to run after normal business hours.",!
 ;
 ; - Select a device.
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="DQ^IBJDI1",ZTDESC="IB - COMPLETED REGISTRATIONS"
 .F I="IB*","VAUTD","VAUTD(" S ZTSAVE(I)=""
 .D ^%ZTLOAD W !!,$S($D(ZTSK):"This job has been queued. The task number is "_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
DQ ; - Tasked entry point.
 ;
 I $G(IBXTRACT) D E^IBJDE(1,1) ; Change extract status.
 ;
 N IBQUERY K IB,^TMP("IBJDI1",$J),^TMP("IBDFN",$J),^TMP($J,"SDAMA301")
 ;
 ; - Initialize accumulators.
 S IBC="COM^DEC^INC^NOTR^NVETC^NVETI^TR^VETC^VETI^TOT",IBQ=0
 I IBSORT D
 .S I=0 F  S I=$S(VAUTD:$O(^DG(40.8,I)),1:$O(VAUTD(I))) Q:'I  D
 ..F J=1:1:10 S IB(I,$P(IBC,U,J))=0
 E  F I=1:1:10 S IB(0,$P(IBC,U,I))=0
 ;
 ; - Find data required for the report.
 S DFN=0 F  S DFN=$O(^DPT(DFN)) Q:'DFN  S IBDN=$G(^(DFN,0)) D  Q:IBQ
 .I DFN#100=0 S IBQ=$$STOP^IBOUTL("Completed Registrations Report") Q:IBQ
 .I $$TESTP(DFN) Q  ; Test patient.
 .S IBD=+$P(IBDN,U,16) I IBD<IBBDT!(IBD>IBEDT)!('$D(^DPT(DFN,"DIS"))) Q
 .D EN^IBJDI11 ; Process patient.
 ;
 I IBQ G ENQ
 ;
 ; - Extract summary data.
 I $G(IBXTRACT) D E^IBJDE(1,0) G ENQ
 ;
 ; - Print the reports.
 S IBQ=0 D NOW^%DTC S IBRUN=$$DAT2^IBOUTL(%)
 S IBDIV="" F  S IBDIV=$O(IB(IBDIV)) Q:IBDIV=""  D  Q:IBQ
 .S IBPAG=0 D:IBRPT="D" DET I 'IBQ D SUM,PAUSE
 ;
ENQ K ^TMP("IBJDI1",$J),^TMP("IBDFN",$J),^TMP($J,"SDAMA301")
 I $D(ZTQUEUED) S ZTREQ="@" G ENQ1
 ;
 D ^%ZISC
ENQ1 K IB,IBC,IBQ,IBBDT,IBEDT,IBRPT,IBD,IBDN,IBIN,IBPAG,IBRUN,IBTOC,IBDOD
 K IBDIV,IBREG,IBNEXT,IBX,IBX0,IBX1,IBINPT,IBNOTR,IBNVET,IBPER,IBSORT
 K IBFL,VAUTD,DFN,I,J,X,X1,X2,Y,%,%ZIS,POP,ZTDESC,ZTRTN,ZTSAVE
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT,IBARRAY,IBCOUNT
 Q
 ;
DET ; - Print the detailed report.
 I '$D(^TMP("IBJDI1",$J,IBDIV)) D  G DETQ
 .D HDET W !!,"There were no registrations with inconsistencies found in this date range."
 ;
 ; look up future appts now
 S IBARRAY(1)=$$NOW^XLFDT_";9999999"
 S IBARRAY(3)="R;I;NT"
 S IBARRAY(4)="^TMP(""IBDFN"",$J,"
 S IBARRAY("SORT")="P"
 S IBARRAY("FLDS")=1
 S IBCOUNT=$$SDAPI^SDAMA301(.IBARRAY)
 ;
 S IBX0="" F  S IBX0=$O(^TMP("IBJDI1",$J,IBDIV,IBX0)) Q:IBX0=""  D  Q:IBQ
 .D HDET Q:IBQ
 .S IBX1="" F  S IBX1=$O(^TMP("IBJDI1",$J,IBDIV,IBX0,IBX1)) Q:IBX1=""  S IBX=^(IBX1) D  Q:IBQ
 ..I $Y>(IOSL-2) D PAUSE Q:IBQ  D HDET Q:IBQ
 ..;
 ..; - Print detailed line with primary elig. or inconsistency.
 ..S IBIN=$P(IBX,U,4),IBFL=0 D DETP(+IBIN)
 ..;
 ..; - Print remaining inconsistencies.
 ..I $P(IBIN,";",2) D
 ...F I=2:1:$L(IBIN,";") S Y=$P(IBIN,";",I) I Y D  Q:IBQ
 ....I $Y>(IOSL-2) D PAUSE Q:IBQ  D HDET,DETP(Y) Q
 ....W !?70,$E($P($G(^DGIN(38.6,+Y,0)),U),1,20)
 ;
DETQ I 'IBQ D PAUSE
 Q
 ;
DETP(X) ; - Print detailed line with a primary elig. or inconsistency.
 W !,$P(IBX1,"@@"),?27,$P(IBX,U),?39,$P(IBX,U,2),?56,$P(IBX,U,3)
 I IBX0,'IBFL W ?70,$E($P($G(^DIC(8,X,0)),U),1,20),"*" S IBFL=1
 E  W ?70,$E($P($G(^DGIN(38.6,X,0)),U),1,20)
 W ?92,$P(IBX,U,5)
 S IBNEXT=$O(^TMP($J,"SDAMA301",$P(IBX1,"@@",2),0)),IBNEXT=$S('IBNEXT:$P(IBX,U,6),'$P(IBX,U,6):IBNEXT,IBNEXT<$P(IBX,U,6):IBNEXT,1:$P(IBX,U,6))
 W ?114,$$DAT1^IBOUTL(IBNEXT),?124,$P(IBX,U,7)
 Q
 ;
HDET ; - Write the detail report header.
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF,*13
 S IBPAG=IBPAG+1
 I '$D(^TMP("IBJDI1",$J,IBDIV)) S (IBNVET,IBX0)=""
 E  S IBNVET=$S(IBX0:"NON-VETERAN",1:"VETERAN")_" "
 W !,"Percentage of Completed Registrations",$S(IBDIV:" for "_$P($G(^DG(40.8,IBDIV,0)),U),1:"")
 W ?85,"Run Date: ",IBRUN,?123,"Page: ",$J(IBPAG,3)
 W !,"Detailed Report of Incomplete ",IBNVET,"Registrations for the Period "_$$DAT1^IBOUTL(IBBDT)_" to "_$$DAT1^IBOUTL(IBEDT)," (*=Had inpat. care, +=Had no treatment)",!!
 W:IBX0 ?70,"Primary Eligibility*" W ?116,"Next    Date of"
 W !,"Patient",?27,"SSN",?39,"Phone Number",?56,"Type of Care"
 W ?70,"Inconsistencies",?92,"Registered By",?114,"Appt/Adm   Death"
 W !,$$DASH(IOM)
 S IBQ=$$STOP^IBOUTL("Completed Registrations Report")
 Q
 ;
SUM ; - Print the summary report.
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF,*13
 W !!?21,"PERCENTAGE OF COMPLETED REGISTRATIONS",!
 I IBDIV D
 .S X=$P($G(^DG(40.8,IBDIV,0)),U) W ?(61-$L(X))\2,"SUMMARY REPORT for ",X
 E  W ?33,"SUMMARY REPORT"
 W !!?23,"For the Period ",$$DAT1^IBOUTL(IBBDT)," - ",$$DAT1^IBOUTL(IBEDT)
 W !!?24,"Run Date: ",IBRUN,!?8,$$DASH(64)
 ;
 S IBPER(1)=$J($S('IB(IBDIV,"TOT"):0,1:IB(IBDIV,"TR")/IB(IBDIV,"TOT")*100),0,2)
 S IBPER(2)=$J($S('IB(IBDIV,"TOT"):0,1:IB(IBDIV,"NOTR")/IB(IBDIV,"TOT")*100),0,2)
 S IBPER(3)=$J($S('IB(IBDIV,"TR"):0,1:IB(IBDIV,"COM")/IB(IBDIV,"TR")*100),0,2)
 S IBPER(4)=$J($S('IB(IBDIV,"COM"):0,1:IB(IBDIV,"VETC")/IB(IBDIV,"COM")*100),0,2)
 S IBPER(5)=$J($S('IB(IBDIV,"COM"):0,1:IB(IBDIV,"NVETC")/IB(IBDIV,"COM")*100),0,2)
 S IBPER(6)=$J($S('IB(IBDIV,"TR"):0,1:IB(IBDIV,"INC")/IB(IBDIV,"TR")*100),0,2)
 S IBPER(7)=$J($S('IB(IBDIV,"INC"):0,1:IB(IBDIV,"VETI")/IB(IBDIV,"INC")*100),0,2)
 S IBPER(8)=$J($S('IB(IBDIV,"INC"):0,1:IB(IBDIV,"NVETI")/IB(IBDIV,"INC")*100),0,2)
 S IBPER(9)=$J($S('IB(IBDIV,"TOT"):0,1:IB(IBDIV,"DEC")/IB(IBDIV,"TOT")*100),0,2)
 W !?29,"Number of Registrations:",?54,$J(IB(IBDIV,"TOT"),6)
 W !?14,"Number of Regs with Treatment Rendered:",?54,$J(IB(IBDIV,"TR"),6),?61,"(",IBPER(1),"%)"
 W !?11,"Number of Regs with No Treatment Rendered:",?54,$J(IB(IBDIV,"NOTR"),6),?61,"(",IBPER(2),"%)",!?8,$$DASH(64)
 W !?20,"Number of Complete Registrations:",?54,$J(IB(IBDIV,"COM"),6),?61,"(",IBPER(3),"%)"
 W !?21,"Number of Complete Veteran Regs:",?54,$J(IB(IBDIV,"VETC"),6),?61,"(",IBPER(4),"%)"
 W !?17,"Number of Complete Non-Veteran Regs:",?54,$J(IB(IBDIV,"NVETC"),6),?61,"(",IBPER(5),"%)",!?8,$$DASH(64)
 W !?18,"Number of Incomplete Registrations:",?54,$J(IB(IBDIV,"INC"),6),?61,"(",IBPER(6),"%)"
 W !?19,"Number of Incomplete Veteran Regs:",?54,$J(IB(IBDIV,"VETI"),6),?61,"(",IBPER(7),"%)"
 W !?15,"Number of Incomplete Non-Veteran Regs:",?54,$J(IB(IBDIV,"NVETI"),6),?61,"(",IBPER(8),"%)",!?8,$$DASH(64)
 W !?25,"Number of Deceased Patients:",?54,$J(IB(IBDIV,"DEC"),6),?61,"(",IBPER(9),"%)"
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
TESTP(DFN) ; - Check if this is a test patient.
 ;  Input: DFN = Pointer to the patient in file #2
 ; Output:   1 = Test patient
 ;           0 = Actual patient
 N X
 S X=$G(^DPT(DFN,0))
 I $P(X,U)="" G TSTPQ
 I $P(X,U,9)["00000"!($P(X,U,9)["123456") G TSTPQ
 ;
 S Y=0 Q Y
TSTPQ S Y=1 Q Y
 ;
SSN(X) ; - Format the SSN.
 Q $S(X]"":$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,10),1:"")
 ;
DHLP ; - 'Sort by division' prompt.
 W !!,"Select: '<CR>' to print the trend report without regard to"
 W !?15,"division"
 W !?11,"'Y' to select those divisions for which a separate"
 W !?15,"trend report should be created",!?11,"'^' to quit"
 Q
