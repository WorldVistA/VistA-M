IBJDI4 ;ALB/CPM - PATIENTS WITH UNIDENTIFIED INSURANCE ; 17-DEC-96
 ;;2.0;INTEGRATED BILLING;**69,98,100,118**;21-MAR-94
 ;
EN ; - Option entry point.
 ;
 W !!,"This report provides the number of patients who have been treated,"
 W !,"but not identified as having or not having insurance.",!
 ;
DATE D DATE^IBOUTL I IBBDT=""!(IBEDT="") G ENQ
 ;
 ; - Sort by division?
 S DIR(0)="Y",DIR("B")="NO",DIR("?")="^D HLP1^IBJDI4"
 S DIR("A")="Do you wish to sort this report by division" W !
 D ^DIR S IBSORT=+Y I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G ENQ
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 ;
 I IBSORT D PSDR^IBODIV G:Y<0 ENQ ; Select division(s).
 ;
 ; - Select a detailed or summary report.
 D DS^IBJD G:IBRPT["^" ENQ S IBSEL=0
 I IBRPT="S" W !!,"This report only requires an 80 column printer." G DEV
 ;
SEL W !!,"Print 1-MAIN REPORT or 2-LINE ITEM REPORTS: 1// "
 R X:DTIME G:'$T!(X["^") ENQ S:X="" X=1 I "1^2"'[X D HLP2 G SEL
 W "  ",$S(X=2:"LINE ITEM REPORTS",1:"MAIN REPORT") I X=1 G RMK
 ;
RPTS ; - Select line item report(s).
 W ! S DIR(0)="LO^1:9^K:+$P(X,""-"",2)>9 X"
 F X=1:1:9 S DIR("A",X)=X_" - Print "_$$TITLE(X)
 S DIR("A",10)="",DIR("A")="Select",DIR("B")=1 D ^DIR K DIR I Y["^" G ENQ
 W ! S IBSEL=Y,DIR(0)="YO",DIR("A",1)="You have selected"
 I X="1-9" S DIR("A",1)=DIR("A",1)_" ALL the above reports."
 E  F X=1:1 S X1=$P(IBSEL,",",X) Q:'X1  S DIR("A",X+1)=" "_$$TITLE(X1)
 S DIR("A")="Are you sure",DIR("B")="NO" D ^DIR K DIR I Y["^" G ENQ
 I 'Y G RPTS
 ;
RMK ; - Select print/not print remarks.
 W ! S DIR(0)="YO"
 S DIR("A")="Do you want the patient's remarks to print on the report"
 S DIR("B")="NO" D ^DIR K DIR S IBRMK=Y I IBRMK["^" G ENQ
 ;
 W !!,"You will need a 132 column printer for this report."
 ;
DEV ; - Select a device.
 W !!,"Note: This report may take a while to run."
 W !?6,"You should queue this report to run after normal business hours.",!
 ;
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="DQ^IBJDI4",ZTDESC="IB - PATIENTS WITH UNIDENTIFIED INSURANCE"
 .F I="IB*","VAUTD","VAUTD(" S ZTSAVE(I)=""
 .D ^%ZTLOAD
 .W !!,$S($D(ZTSK):"This job has been queued. The task number is "_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
DQ ; - Tasked entry point.
 ;
 I $G(IBXTRACT) D E^IBJDE(4,1) ; Change extract status.
 ;
 N IBQUERY K IB,^TMP("IBJDI41",$J),^TMP("IBJDI42",$J)
 S IBC="BILL^DEC^HMO^IND^MEDC^MEDG^NO^NULL^TOT^UNK^YES",IBQ=0
 I IBSORT D  G PROC
 .S I=0 F  S I=$S(VAUTD:$O(^DG(40.8,I)),1:$O(VAUTD(I))) Q:'I  D
 ..S J=$P($G(^DG(40.8,I,0)),U) F K=1:1:11 S IB(J,$P(IBC,U,K))=0
 S IBDIV="ALL" F I=1:1:11 S IB("ALL",$P(IBC,U,I))=0
 ;
PROC D EN^IBJDI41 ; Process and print report(s).
 ;
ENQ K ^TMP("IBJDI41",$J),^TMP("IBJDI42",$J)
 I $D(ZTQUEUED) S ZTREQ="@" G ENQ1
 ;
 D ^%ZISC
ENQ1 K IB,IBQ,IBBDT,IBEDT,IBRMK,IBRPT,IBD,IBDN,IBPH,IBPAG,IBRUN,IBX,IBX1,IBX2
 K IBC,IBELIG,IBPER,IBPM,IBPMD,IBDOD,IBFL,IBFL1,IBIPC,IBINSC,IBPAT,IBSEL
 K IBDIV,IBSEL1,IBSORT,VAUTD,DFN,POP,I,J,K,X,X1,X2,Y,ZTDESC,ZTRTN,ZTSAVE
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT,%,%ZIS
 Q
 ;
HLP1 ; - 'Sort by division' prompt.
 W !!,"Select: '<CR>' to print the trend report without regard to"
 W !?15,"division"
 W !?11,"'Y' to select those divisions for which a separate"
 W !?15,"trend report should be created",!?11,"'^' to quit"
 Q
 ;
HLP2 ; - 'Print 1-MAIN REPORT'... prompt.
 W !!,"Select: '1' to print the Patients w/Unidentified Insurance Report"
 W !?8,"'2' to print up to nine specific reports based on the line items"
 W !?12,"of the summary report",!?8,"'^' to quit"
 Q
 ;
TITLE(X) ; - Print report title.
 Q $P($T(TITLE1+X),";;",2)
 ;
TITLE1 ;;Patients with Unidentified Insurance
 ;;Patients Covered by Insurance
 ;;Patients Covered by Billable Insurance
 ;;Patients Covered by an HMO
 ;;Patients Covered by Medicare
 ;;Patients Covered by Medigap
 ;;Patients Covered by an Indemnity Policy
 ;;Patients Not Covered by Insurance
 ;;Patients with Unknown Insurance
 ;;Patients with Insurance Question Unanswered
 ;
TYPE(INS) ; - Find type of insurance.
 ;  Input: INS=Patient's insurance info in file #2 (.3121)
 ; Output:   Y=1-HMO, 2-Medicare, 3-Medigap, 4-Indemnity, or
 ;             0-None of the above
 ;
 N TYP
 S Y=0,TYP=+$P($G(^IBA(355.3,+$P(INS,U,18),0)),U,9) I 'TYP G TYP1
 I $D(^IBE(355.1,"B","HEALTH MAINTENANCE ORGANIZ",TYP)) S Y=1
 I $D(^IBE(355.1,"B","POINT OF SERVICE",TYP)) S Y=1
 I $D(^IBE(355.1,"B","PREPAID GROUP PRACTICE PLAN",TYP)) S Y=1
 I $D(^IBE(355.1,"B","MEDICARE (M)",TYP)) S Y=2
 I $D(^IBE(355.1,"B","MEDICARE/MEDICAID (MEDI-CAL)",TYP)) S Y=2
 I $D(^IBE(355.1,"B","MEDIGAP (SUPPLEMENTAL)",TYP)) S Y=3
 I $D(^IBE(355.1,"B","INCOME PROTECTION (INDEMNITY)",TYP)) S Y=4
 ;
TYP1 G:Y TYPQ S TYP=+$P($G(^DIC(36,+INS,0)),U,13) I 'TYP G TYPQ
 I $D(^IBE(355.2,"B","HEALTH MAINTENANCE ORG.",TYP)) S Y=1
 I $D(^IBE(355.2,"B","MEDICARE",TYP)) S Y=2
 I $D(^IBE(355.2,"B","MEDIGAP",TYP)) S Y=3
 I $D(^IBE(355.2,"B","INDEMNITY",TYP)) S Y=4
 ;
TYPQ Q Y
