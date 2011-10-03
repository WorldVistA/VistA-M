IBOMTC ;ALB/CPM-BILLING ACTIVITY LIST ; 09-JAN-92
 ;;2.0;INTEGRATED BILLING;**145,176**;21-MAR-94
 ;; Per VHA Directive 10-93-142, this routine should not be modified
 ;
 ;***
 ;S XRTL=$ZU(0),XRTN="IBOMTC-1" D T0^%ZOSV ;start rt clock
 ;
 S:'$D(DTIME) DTIME=300 D HOME^%ZIS
 ; Select Start and End dates.
 S DIR(0)="SM^0:NO;1:YES",DIR("A")="Run this report for Purple Heart Vets only?",DIR("B")="NO" D ^DIR K DIR G:$D(DIRUT) END I Y S IBPURPHT=1,IBBDT=2991130,%DT("B")="November 30 1999"
BDT S %DT="AEPX",%DT("A")="Start with DATE: " D ^%DT K %DT G END:Y<0 S IBBDT=Y
 I '$G(IBPURPHT) I IBBDT<2901001 W !,"The Start Date cannot be earlier than 10/1/90.",! G BDT
EDT S %DT="EX" R !,"Go to DATE: ",X:DTIME S:X=" " X=IBBDT
 G END:(X="")!(X["^") D ^%DT G EDT:Y<0 S IBEDT=Y
 I Y<IBBDT W *7," ??",!,"ENDING DATE must follow BEGINNING DATE." G BDT
 ;
 S IBDESC="Billing Activity List"
 ; Select output device.
 S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) D  G END
 .S ZTRTN="^IBOMTC1",ZTDESC=IBDESC
 .S (ZTSAVE("IBBDT"),ZTSAVE("IBEDT"),ZTSAVE("IBDESC"))=""
 .I $G(IBPURPHT) S ZTSAVE("IBPURPHT")=""
 .D ^%ZTLOAD W !!,$S($D(ZTSK):"This job has been queued.  The task number is "_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,ZTDESC,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOMTC" D T1^%ZOSV ;stop rt clock
 ;
 D ^IBOMTC1 ; generate report
 ;
END K %DT,IBBDT,IBDESC,IBEDT,IBPURPHT,IBX,POP,X,Y
 D KVAR^VADPT
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOMTC" D T1^%ZOSV ;stop rt clock
 Q
