IBCNERPF ;BP/YMG - IBCNE USER INTERFACE EIV INSURANCE UPDATE REPORT ;16-SEP-2009
 ;;2.0;INTEGRATED BILLING;**416,528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Variables:
 ;   IBCNERTN = "IBCNERPF" (current routine name for queueing the 
 ;                          COMPILE process)
 ;   IBCNESPC("BEGDT") = start date for date range
 ;   IBCNESPC("ENDDT") = end date for date range
 ;   IBCNESPC("PYR",ien) = payer iens for report, if IBCNESPC("PYR")="A", then include all
 ;   IBCNESPC("PAT",ien) = patient iens for report, if IBCNESPC("PAT")="A", then include all
 ;   IBCNESPC("SORT") = sort by: 1 - Payer name, 2 - Patient Name, 3 - Clerk Name
 ;   IBCNESPC("TYPE") = report type: "S" - summary, "D" - detailed
 ;   IBOUT = "R" for Report format or "E" for Excel format
 ;
 Q
EN ; entry point
 N STOP,IBCNERTN,IBCNESPC,IBOUT
 ;
 S STOP=0,IBCNERTN="IBCNERPF"
 W @IOF
 W !,"eIV Insurance Update Report",!
 ; Prompts for Insurance Update Report
 ; Report Type - Summary or Detailed
P10 D TYPE I STOP G EXIT
 ; Payer Selection parameter
P20 D PAYER I STOP G:$$STOP^IBCNERP1 EXIT G P10
 ; Date Range parameters
P30 D DTRANGE I STOP G:$$STOP^IBCNERP1 EXIT G P20
 ; Patient Selection parameter
P40 D PATIENT I STOP G:$$STOP^IBCNERP1 EXIT G P30
 ; Sort by parameter - Payer Name, Patient Name, or Clerk Name
P50 D SORT I STOP G:$$STOP^IBCNERP1 EXIT G P40
 ; Select the output type
P60 S IBOUT=$$OUT^IBCNERP1 I STOP G:$$STOP^IBCNERP1 EXIT G P50
 ; Select the output device
P100 D DEVICE^IBCNERP1(IBCNERTN,.IBCNESPC,IBOUT) I STOP G:$$STOP^IBCNERP1 EXIT G P50
 ;
EXIT ;
 Q
 ;
PAYER ;
 N DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR("A")="Run for (A)ll Payers or (S)elected Payers: "
 S DIR("A",1)="PAYER SELECTION:"
 S DIR(0)="SA^A:All;S:Selected",DIR("B")="A"
 D ^DIR
 I $D(DIRUT) S STOP=1 Q
 I Y="A" S IBCNESPC("PYR")="A" Q  ; "All Payers" selected
 S DIC(0)="ABEQ"
 S DIC("A")="Select Insurance Company: "
 ; Do not allow selection of '~NO PAYER' and non-eIV payers
 S DIC("S")="I ($P(^(0),U,1)'=""~NO PAYER""),$$PYRAPP^IBCNEUT5(""IIV"",$G(Y))'="""""
 S DIC="^IBE(365.12,"
PAYER1 ;
 D ^DIC
 I $D(DUOUT)!$D(DTOUT)!(Y=-1) S STOP=1 K IBCNESPC("PYR") Q
 S IBCNESPC("PYR",$P(Y,U,1))=""
 I $$ANOTHER G PAYER1
 Q
 ;
DTRANGE ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="D^::EX",DIR("B")="Today"
 S DIR("A")="Earliest Date Received"
 S DIR("A",1)="RESPONSE RECEIVED DATE RANGE SELECTION:"
 D ^DIR I $D(DIRUT) S STOP=1 Q
 S IBCNESPC("BEGDT")=Y
 ; End date
DTRANGE1 ;
 K DIR("A") S DIR("A")="  Latest Date Received"
 D ^DIR I $D(DIRUT) S STOP=1 Q
 I Y<IBCNESPC("BEGDT") W !,"     Latest Date must not precede the Earliest Date." G DTRANGE1
 S IBCNESPC("ENDDT")=Y
 Q
 ;
PATIENT ;
 N DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ; summary report is always run for all patients
 I $G(IBCNESPC("TYPE"))="S" S IBCNESPC("PAT")="A" Q
 W !
 S DIR("A")="Run for (A)ll Patients or (S)elected Patients: "
 S DIR("A",1)="PATIENT SELECTION:"
 S DIR(0)="SA^A:All;S:Selected",DIR("B")="A"
 D ^DIR
 I $D(DIRUT) S STOP=1 Q
 I Y="A" S IBCNESPC("PAT")="A" Q  ; "All Patients" selected
 S DIC(0)="ABEQ"
 S DIC("A")="Select Patient: "
 S DIC="^DPT("
PATIENT1 ;
 D ^DIC
 I $D(DUOUT)!$D(DTOUT)!(Y=-1) S STOP=1 K IBCNESPC("PAT") Q
 S IBCNESPC("PAT",$P(Y,U,1))=""
 I $$ANOTHER G PATIENT1
 Q
 ;
ANOTHER() ; "Select Another" prompt
 ; returns 1, if response was "YES", returns 0 otherwise
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR("A")="Select Another?" S DIR(0)="Y",DIR("B")="NO"
 D ^DIR I $D(DIRUT) S STOP=1
 Q Y
 ;
SORT ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ; summary report is sorted by Payer Name, if run for selected payers,
 ; or by Clerk Name, if run for all payers
 I $G(IBCNESPC("TYPE"))="S" S IBCNESPC("SORT")=$S($G(IBCNESPC("PYR"))="A":1,1:3) Q
 W !
 S DIR(0)="SA^1:Payer Name;2:Patient Name;3:Clerk Name"
 S DIR("A")="Sort By: "
 S DIR("A",1)="SORT CRITERIA:"
 S DIR("B")="Payer Name"
 D ^DIR I $D(DIRUT) S STOP=1 Q
 S IBCNESPC("SORT")=Y
 Q
 ;
TYPE ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^S:Summary;D:Detailed"
 S DIR("A")="Run a (S)ummary or (D)etailed Report: "
 S DIR("B")="Summary"
 D ^DIR I $D(DIRUT) S STOP=1 Q
 S IBCNESPC("TYPE")=Y
 Q
