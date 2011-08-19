IBJDB1 ;ALB/CPM - BILLING LAG TIME REPORT ; 27-DEC-96
 ;;2.0;INTEGRATED BILLING;**69,80,100,118,165**;21-MAR-94
 ;
EN ; - Option entry point.
 ;
 W !!,"This report measures the amount of time between significant"
 W !,"milestones which occur from the time treatment has been provided"
 W !,"to the time that the claim to the insurer for that treatment has"
 W !,"been closed out.",!
 ;
DATE D DATE^IBOUTL I IBBDT=""!(IBEDT="") G ENQ
 ;
 ; - Sort by division.
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Do you wish to sort this report by division"
 S DIR("?")="^D HLP1^IBJDB1" W !
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G ENQ
 S IBSORT=+Y K DIROUT,DTOUT,DUOUT,DIRUT
 ;
 ; - Issue prompt for division.
 I IBSORT D PSDR^IBODIV G:Y<0 ENQ
 ;
 ; - Select a Detailed or Summary report.
DS D DS^IBJD I "^"[IBRPT G ENQ
 I IBRPT="S" S IBSEL=",1,2,3,4,5,6,7,8,9,10,11," G DEV
 ;
SEL ; - Select main report or line item reports.
 W ! S DIR(0)="LO^1:11^K:+$P(X,""-"",2)>11 X"
 F X=1:1:11 S DIR("A",X)=$S(X<10:" ",1:"")_X_" - Print "_$$TITLE(X,1)
 S DIR("A",12)="",DIR("A")="Select",DIR("B")=1
 S DIR("?")="^D HLP2^IBJDB1" D ^DIR K DIR G:Y["^" ENQ S IBSEL=Y
 S DIR(0)="Y",DIR("A",1)="You have selected"
 I IBSEL="1,2,3,4,5,6,7,8,9,10,11," D
 .S DIR("A",1)=DIR("A",1)_" ALL the above reports."
 E  F X=1:1 S X1=$P(IBSEL,",",X) Q:'X1  S DIR("A",X+1)=" "_$$TITLE(X1,1)
 S DIR("A")="Are you sure",DIR("B")="NO"
 W ! D ^DIR K DIR G ENQ:Y["^",SEL:'Y S IBSEL=","_IBSEL
 ;
DEV W !!,"This report only requires an 80 column printer."
 ;
 W !!,"Note: This report searches through all Reimb. Insurance claims."
 W !?6,"You should queue this report to run after normal business hours."
 ;
 ; - Select a device.
 W ! S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="DQ^IBJDB1",ZTDESC="IB - BILLING LAG TIME REPORT"
 .F X="IB*","VAUTD","VAUTD(" S ZTSAVE(X)=""
 .D ^%ZTLOAD W !!,$S($D(ZTSK):"This job has been queued. The task number is "_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
DQ ; - Tasked entry point.
 ;
 I $G(IBXTRACT) D E^IBJDE(10,1) ; Change extract status.
 ;
 K IBCT,IBTL,^TMP("IBJDB1",$J)
 S IBQ=0 D ^IBJDB11 I IBQ G ENQ ; Compile data for reports.
 ;
 ; - Extract summary data.
 I $G(IBXTRACT) D  G ENQ
 .S X=0 F Y=1:1:4,9,10,11,"2I","3I","4I" D
 ..S X=X+1,IB(X)=$J($S('IBCT(0,"OP",Y):0,1:IBTL(0,"OP",Y)/IBCT(0,"OP",Y)),0,2)
 .F Y=5:1:11,"6I","7I","8I" D
 ..S X=X+1,IB(X)=$J($S('IBCT(0,"IN",Y):0,1:IBTL(0,"IN",Y)/IBCT(0,"IN",Y)),0,2)
 .D E^IBJDE(10,0)
 ;
 ; - Print the reports.
 S IBQ=0
 S IBDIV="" F  S IBDIV=$S(IBRPT="D":$O(^TMP("IBJDB1",$J,IBDIV)),1:$O(IBCT(IBDIV))) Q:IBDIV=""  D  Q:IBQ
 .S IBPAG=0 D NOW^%DTC S IBRUN=$$DAT2^IBOUTL(%)
 .I IBRPT="D" D OPT^IBJDB12 I 'IBQ D INP^IBJDB13
 .I IBRPT="S" D SUM^IBJDB12
 ;
ENQ K ^TMP("IBJDB1",$J)
 I $D(ZTQUEUED) S ZTREQ="@" G ENQ1
 ;
 D ^%ZISC
ENQ1 K IB,IBBDT,IBBN,IBEDT,IBCK,IBN,IBN0,IBRPT,IBPAG,IBQ,IBRUN,IBX,IBX1,IBX2
 K IBX3,IBAUTH,IBDAT,IBDFN,IBNU,IBPTF,IBPOL,IBPOL1,IBTY,IBS,IBSEL,IBSEL1
 K IBCT,IBDIV,IBSORT,IBTL,IBCHK,IBDCHK,DFN,POP,VAUTD,ZTDESC,ZTRTN,ZTSAVE
 K IBDR,IBH,DIROUT,DTOUT,DUOUT,DIRUT,%,%ZIS,D,X,X1,X2,Y,Y1,Z,Z1,Z2,Z3
 Q
 ;
HLP1 ; - 'Sort by Division?' prompt.
 W !?1,"Enter a <CR> to print the report without regard to division,"
 W !?1,"or 'Y' to select those divisions for which a separate report"
 W !?1,"should be created. To quit this option, enter '^'."
 Q
 ;
HLP2 ; - Line item report prompt.
 W !?1,"Select '1-11' (Response can be a single number, list or range,"
 W !?1,"e.g.: 1,3,5 or 2-6,10) to print up to 11 lag time reports based"
 W !?1,"on the line items of the lag time summary reports. To quit this"
 W !?1,"option, enter '^'."
 Q
 ;
TITLE(X,Y) ; - Display/print report titles.
 Q $P($T(TITLE1+X),";;",2)_$S(Y:$P($T(TITLE1+X),";;",3),1:"")
 ;
TITLE1 ; - Line item titles.
 ;;Date of Care to Date of Check Out;; (Outpatient claims)
 ;;Date of Check Out to Date Claim Authorized;; (Outpatient claims)
 ;;Date of Care to Date of First Payment;; (Outpatient claims)
 ;;Date of Care to Date Receivable Closed;; (Outpatient claims)
 ;;Date of Discharge to Date PTF Transmitted;; (Inpatient claims)
 ;;Date PTF Transmitted to Date Claim Authorized;; (Inpatient claims)
 ;;Date of Discharge to Date of First Payment;; (Inpatient claims)
 ;;Date of Discharge to Date Receivable Closed;; (Inpatient claims)
 ;;Date Claim Authorized to Date Claim Activated
 ;;Date Claim Activated to Date of First Payment
 ;;Date of First Payment to Date Receivable Closed
