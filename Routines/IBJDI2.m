IBJDI2 ;ALB/CPM - VETERANS WITH UNVERIFIED ELIGIBILITY ;16-DEC-96
 ;;2.0;INTEGRATED BILLING;**69,91,98,100,118,249**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; - Option entry point.
 ;
 W !!,"This report measures the number of patients who have been treated at the"
 W !,"facility but whose eligibility has not been verified. This report will"
 W !,"also list patients with verified eligibility for at least 2 years, if any.",!
 ;
DATE D DATE^IBOUTL I IBBDT=""!(IBEDT="") G ENQ
 ;
 ; - Sort by division?
 S DIR(0)="Y",DIR("B")="NO",DIR("?")="^D DHLP^IBJDI2"
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
 ;
 W !!,"Note: This report may take a while to run."
 W !?6,"You should queue this report to run after normal business hours.",!
 ;
 ; - Select a device.
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="DQ^IBJDI2",ZTDESC="IB - UNVERIFIED ELIGIBILITY"
 .F I="IB*","VAUTD","VAUTD(" S ZTSAVE(I)=""
 .D ^%ZTLOAD
 .W !!,$S($D(ZTSK):"This job has been queued. The task number is "_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
DQ ; - Tasked entry point.
 ;
 I $G(IBXTRACT) D E^IBJDE(2,1) ; Change extract status.
 ;
 N IBQUERY,IBQUERY1
 K IB,^TMP("IBJDI21",$J),^TMP("IBJDI22",$J),^TMP("IBJDI23",$J)
 K ^TMP("IBDFN",$J),^TMP($J,"SDAMA301")
 S IBC="DEC^NOT^PEN^TOT^VER^VERO",IBQ=0
 I IBSORT D  G PROC
 .S I=0 F  S I=$S(VAUTD:$O(^DG(40.8,I)),1:$O(VAUTD(I))) Q:'I  D
 ..S J=$P($G(^DG(40.8,I,0)),U) F K=1:1:6 S IB(J,$P(IBC,U,K))=0
 S IBDIV="ALL" F I=1:1:6 S IB("ALL",$P(IBC,U,I))=0
 ;
PROC D ^IBJDI21 ; Process and print reports.
 ;
ENQ K ^TMP("IBJDI21",$J),^TMP("IBJDI22",$J),^TMP("IBJDI23",$J)
 K ^TMP("IBDFN",$J),^TMP($J,"SDAMA301")
 I $D(ZTQUEUED) S ZTREQ="@" G ENQ1
 ;
 D ^%ZISC
ENQ1 K IB,IBQ,IBBDT,IBEDT,IBRPT,IBD,IBDOD,IBDN,IBPAG,IBRUN,IBX,IBXX,IBPERV
 K IBESD,IBPM,IBPMD,IBOE,IBOED,IBES,IBLT,IBNUMO,IBNUMD,IBNEXT,IBDT,IBDTF
 K IBC,IBN,IBDIV,IBSORT,IBPERD,IBPERO,IBPERP,VAUTD,DFN,POP,I,J,K
 K X,X1,X2,Y,%,%ZIS,DIR,DIROUT,DTOUT,DUOUT,DIRUT,ZTDESC,ZTRTN,ZTSAVE
 Q
 ;
DHLP ; - 'Sort by division' prompt.
 W !!,"Select: '<CR>' to print the trend report without regard to"
 W !?15,"division"
 W !?11,"'Y' to select those divisions for which a separate"
 W !?15,"trend report should be created",!?11,"'^' to quit"
 Q
