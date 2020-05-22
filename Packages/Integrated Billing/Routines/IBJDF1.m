IBJDF1 ;ALB/CPM - THIRD PARTY FOLLOW-UP REPORT ;09-JAN-97
 ;;2.0;INTEGRATED BILLING;**69,118,128,205,554,618,663**;21-MAR-94;Build 27
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; - Option entry point.
 ;
 W !!,"This report provides a tool for sites to use to perform follow-up"
 W !,"activities for Third Party receivables.",!
 ;
DATE ; - Choose date to use for calculation
 W !!,"Calculate report using (D)ATE OF CARE or (A)CTIVE IN AR (days): (A)CTIVE IN AR// " R X:DTIME
 G:'$T!(X["^") ENQ S:X="" X="A" S X=$E(X)
 I "ADad"'[X S IBOFF=99 D HELP^IBJDF1H G DATE
 W "  ",$S("Dd"[X:"DATE OF CARE",1:"(DAYS) ACTIVE IN AR")
 S IBSDATE=$S("Dd"[X:"D",1:"A")
 ;
 ; - Sort by division.
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Do you wish to sort this report by division"
 S DIR("?")="^S IBOFF=1 D HELP^IBJDF1H"
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G ENQ
 S IBSD=+Y K DIROUT,DTOUT,DUOUT,DIRUT
 ;
 ; - Issue prompt for division.
 I IBSD D PSDR^IBODIV G:Y<0 ENQ
 ;
INS ; - Determine range of carriers.
 W !!,"Run report for (S)PECIFIC insurance companies or a (R)ANGE: RANGE// "
 R X:DTIME G:'$T!(X["^") ENQ S:X="" X="R" S X=$E(X)
 I "RSrs"'[X S IBOFF=8 D HELP^IBJDF1H G INS
 W "  ",$S("Ss"[X:"SPECIFIC",1:"RANGE") G:"Rr"[X INS1 K IBSI
INS0 S DIC="^DIC(36,",DIC(0)="AEQMZ",DIC("S")="I '$G(^(5))"
 S DIC("A")="   Select "_$S($G(IBSI):"another ",1:"")_"INSURANCE CO.: "
 D ^DIC K DIC I Y'>0 G ENQ:'$G(IBSI),NAM
 I $D(IBSI(+Y)) D  G INS0
 .W !!?3,"Already selected. Choose another insurance company.",!,*7
 S IBSI(+Y)="" S:'$G(IBSI) IBSI=1 G INS0
INS1 R !?3,"START WITH INSURANCE COMPANY: FIRST// ",X:DTIME G:'$T!(X["^") ENQ
 I $E(X)="?" S IBOFF=14 D HELP^IBJDF1H G INS1
 S IBSIF=X
INS2 R !?8,"GO TO INSURANCE COMPANY: LAST// ",X:DTIME G:'$T!(X["^") ENQ
 I $E(X)="?" S IBOFF=21 D HELP^IBJDF1H G INS2
 I X="" S IBSIL="zzzzz" S:IBSIF="" IBSIA="ALL" G NAM
 I X="@",IBSIF="@" S IBSIL="@",IBSIA="NULL" G NAM
 I IBSIF'="@",IBSIF]X D  G INS2
 .W *7,!!?4,"The LAST value must follow the FIRST.",!
 S IBSIL=X
 ;
NAM ; - Determine range of patients.
 S DIR(0)="SA^N:NAME;L:LAST 4"
 S DIR("A")="Sort Patients by (N)AME or (L)AST of the SSN: "
 S DIR("B")="NAME",DIR("T")=20,DIR("?")="^S IBOFF=29 D HELP^IBJDF1H"
 W ! D ^DIR K DIR G:Y=""!(X="^") ENQ S IBSN=Y,IBI=Y(0)
NAM1 W !?3,"START WITH PATIENT ",IBI,": FIRST// " R X:DTIME G:'$T!(X["^") ENQ
 I $E(X)="?" S IBOFF=36 D HELP^IBJDF1H G NAM1
 S IBSNF=X
NAM2 W !?8,"GO TO PATIENT ",IBI,": LAST// " R X:DTIME G:'$T!(X["^") ENQ
 I $E(X)="?" S IBOFF=43 D HELP^IBJDF1H G NAM2
 I X="" S IBSNL="zzzzz" S:IBSNF="" IBSNA="ALL" G TYP
 I X="@",IBSNF="@" S IBSNL="@",IBSNA="NULL" G TYP
 I IBSNF'="@",IBSNF]X D  G NAM2
 .W *7,!!?7,"The LAST value must follow the FIRST.",!
 S IBSNL=X
 ;
TYP ; - Select type of receivables to print.
 ; IB*2.0*554/DRF 10/20/2015 Add Non-VA care
 ; IB*2.0*? Changed Non-VA care to Community Care
 W !!,"Choose which type of receivables to print:",!
 S DIR(0)="LO^1:5^K:+$P(X,""-"",2)>5 X"
 S DIR("A",1)="       1 - INPATIENT"
 S DIR("A",2)="       2 - OUTPATIENT"
 S DIR("A",3)="       3 - PHARMACY REFILL"
 S DIR("A",4)="       4 - COMMUNITY CARE RECEIVABLES"
 S DIR("A",5)="       5 - ALL RECEIVABLES"
 S DIR("A",6)="",DIR("A")="Select",DIR("B")=5
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G ENQ
 S IBSEL=Y K DIROUT,DTOUT,DUOUT,DIRUT
 ;
AR ; - Determine if the active receivable must be within an age range.
 W !!,"Include (A)LL active AR's or those within an AGE (R)ANGE: ALL// " R X:DTIME
 G:'$T!(X["^") ENQ S:X="" X="A" S X=$E(X)
 I "ARar"'[X S IBOFF=51 D HELP^IBJDF1H G AR
 W "  ",$S("Rr"[X:"RANGE",1:"ALL")
 S IBSMN=$S("Rr"[X:"R",1:"A") I IBSMN="A" G AMT
 ;
AGE ;-Determine the active receivable age range.
 S DIR(0)="NA^1:99999",DIR("?")="^S IBOFF=59 D HELP^IBJDF1H"
 S DIR("A")="  Enter the minimum age of the active receivable: "
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G ENQ
 S IBSMN=+Y W "   ",IBSMN," DAYS" K DIROUT,DTOUT,DUOUT,DIRUT
 ;
 S DIR(0)="NA^"_IBSMN_":99999",DIR("?")="^S IBOFF=64 D HELP^IBJDF1H"
 S DIR("A")="  Enter the maximum age of the active receivable: "
 S DIR("B")=IBSMN D ^DIR K DIR
 I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G ENQ
 S IBSMX=+Y W "   ",IBSMX," DAYS" K DIROUT,DTOUT,DUOUT,DIRUT
 ;
AMT ; - Print receivables with a minimum balance.
 S DIR(0)="Y",DIR("B")="NO" W !
 S DIR("A")="Print receivables with a minimum balance"
 S DIR("?")="^S IBOFF=69 D HELP^IBJDF1H"
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G ENQ
 S IBSAM=+Y K DIROUT,DTOUT,DUOUT,DIRUT I 'IBSAM G BCH
 ;
AMT1 ; - Determine the minimum balance amount.
 S DIR(0)="NA^1:9999999",DIR("?")="^S IBOFF=76 D HELP^IBJDF1H"
 S DIR("A")="  Enter the minimum balance amount of the receivable: "
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G ENQ
 S IBSAM=+Y K DIROUT,DTOUT,DUOUT,DIRUT
 ;
BCH ; - Determine whether to include the bill comment history.
 S DIR(0)="Y",DIR("B")="NO" W !
 S DIR("A")="Include the Bill Comment history with each receivable"
 S DIR("?")="^S IBOFF=81 D HELP^IBJDF1H"
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G ENQ
 S IBSH=+Y K DIROUT,DTOUT,DUOUT,DIRUT
 ;
RC ; - Include receivables referred to Regional Counsel?
 S DIR(0)="Y",DIR("B")="NO" W !
 S DIR("A")="Include receivables referred to Regional Counsel"
 S DIR("?")="^S IBOFF=90 D HELP^IBJDF1H"
 D ^DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G ENQ
 S IBSRC=+Y K DIROUT,DTOUT,DUOUT,DIRUT
 ;
 W !!,"This report requires a 132 column printer."
 W !!,"Note: This report will search through all active receivables."
 W !?6,"You should queue this report to run after normal business hours."
 ;
 ; - Select a device.
 W ! S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="DQ^IBJDF11",ZTDESC="IB - THIRD PARTY FOLLOW-UP REPORT"
 .F I="IBS*","VAUTD","VAUTD(" S ZTSAVE(I)=""
 .D ^%ZTLOAD
 .W !!,$S($D(ZTSK):"This job has been queued. The task number is "_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
 D DQ^IBJDF11 ; Compile and print the report.
 ;
ENQ K IBSD,IBSEL,IBSI,IBSIF,IBSIL,IBSIA,IBSN,IBSNF,IBSNL,IBOFF,IBSNA,IBSH
 K IBSAM,IBSDATE,IBSMN,IBSMX,IBSRC,IBTEXT,IBI,POP,VAUTD,%ZIS,ZTDESC,ZTRTN,ZTSAVE,DIR
 K DIROUT,DTOUT,DUOUT,DIRUT
 Q
