IBAMTI2 ;ALB/CPM - LIST SPECIAL INPATIENT BILLING CASES ; 11-AUG-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
LIST ; List all inpatient billing cases.
 ;
 I '$O(^IBE(351.2,0)) W !!,"There are no special inpatient billing cases on file!" G LISTQ
 ;
 W !!,"This report will print out all special inpatient billing cases.",!
 ;
 S %ZIS="QM" D ^%ZIS G:POP LISTQ
 I $D(IO("Q")) D  G LISTQ
 .S ZTRTN="DQ^IBAMTI2",ZTDESC="LIST ALL SPECIAL INPATIENT BILLING CASES"
 .D ^%ZTLOAD W !!,$S($D(ZTSK):"This job has been queued.  The task number is "_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
DQ ; Tasked entry point.
 ;
 S (IBPAG,IBQ)=0 D HDR
 S IBC=0 F  S IBC=$O(^IBE(351.2,IBC)) Q:'IBC  D  Q:IBQ
 .I $Y>(IOSL-12) D PAUSE^IBEMTF2 Q:IBQ  D HDR
 .D DSPL^IBAMTI1(IBC) W !
 ;
 ; - end-of-report pause
 D:'IBQ PAUSE^IBEMTF2
 ;
LISTQ I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K IBC,IBQ,IBPAG
 Q
 ;
HDR ; Generate a report header.
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !?20,"LIST ALL SPECIAL INPATIENT BILLING CASES"
 W !?64,"Page: ",IBPAG,!?60,"Run Date: ",$$DAT1^IBOUTL(DT)
 Q
