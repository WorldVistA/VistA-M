IBCNERPJ ;IB/BAA/AWC - IBCNE EIV HL7 RESPONSE REPORT;25 Feb 2015
 ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Variables:
 ;   IBCNERTN = "IBCNERPF" (current routine name for queueing the 
 ;                          COMPILE process)
 ;   INCNESPJ("BEGDT") = start date for date range
 ;   INCNESPJ("ENDDT") = end date for date range
 ;   INCNESPJ("PYR",ien) = payer iens for report, if INCNESPJ("PYR")="A", then include all
 ;   IBCNESPJ("PAT",ien) = patient iens for report, if IBCNESPJ("PAT")="A", then include all
 ;   INCNESPJ("TYPE") = report type: "R" - Report, "E" - Excel
 ;
 Q
EN ; entry point
 N STOP,IBCNERTN,INCNESPJ,I,IBCNESPJ
 ;
 S STOP=0,IBCNERTN="IBCNERPJ"
 K ^TMP($J,IBCNERTN)
 W @IOF
 W !,"eIV HL7 Response Report",!
 ; Prompts for HL7 Response Report
 ; Report Type - Report or Excel
P10 D TYPE I STOP G EXIT
 ; Payer Selection parameter
P20 D PAYER I STOP G:$$STOP^IBCNERP1 EXIT G P10
 ; Date Range parameters
P30 D DTRANGE I STOP G:$$STOP^IBCNERP1 EXIT G P20
 ; Patient Selection parameter
P40 D PATIENT I STOP G:$$STOP^IBCNERP1 EXIT G P30
 ; Select the output device
P100 D DEVICE
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
 I Y="A" S INCNESPJ("PYR")="A" Q  ; "All Payers" selected
 S DIC(0)="ABEQ"
 S DIC("A")="Select Payer(s): "
 ; Do not allow selection of '~NO PAYER' and non-eIV payers
 S DIC("S")="I ($P(^(0),U,1)'=""~NO PAYER""),$$PYRAPP^IBCNEUT5(""IIV"",$G(Y))'="""""
 S DIC="^IBE(365.12,"
PAYER1 ;
 D ^DIC
 I $D(DUOUT)!$D(DTOUT)!(Y=-1) S STOP=1 K INCNESPJ("PYR") Q
 S INCNESPJ("PYR",$P(Y,U,1))=""
 I $$ANOTHER G PAYER1
 Q
 ;
PATIENT ;
 N DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ; summary report is always run for all patients
 W !
 S DIR("A")="Run for (A)ll Patients or (S)elected Patients: "
 S DIR("A",1)="PATIENT SELECTION:"
 S DIR(0)="SA^A:All;S:Selected",DIR("B")="A"
 D ^DIR
 I $D(DIRUT) S STOP=1 Q
 I Y="A" S INCNESPJ("PAT")="A" Q  ; "All Patients" selected
 S DIC(0)="ABEQ"
 S DIC("A")="Select Patient: "
 S DIC="^DPT("
PATIENT1 ;
 D ^DIC
 I $D(DUOUT)!$D(DTOUT)!(Y=-1) S STOP=1 K IBCNESPC("PAT") Q
 S INCNESPJ("PAT",$P(Y,U,1))=""
 I $$ANOTHER G PATIENT1
 Q
 ;
DTRANGE ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="D^::EX",DIR("B")="Today"
 S DIR("A")="Earliest Date Received"
 S DIR("A",1)="RESPONSE RECEIVED DATE RANGE SELECTION:"
 D ^DIR I $D(DIRUT) S STOP=1 Q
 S INCNESPJ("BEGDT")=Y
 ; End date
DTRANGE1 ;
 K DIR("A") S DIR("A")="  Latest Date Received"
 D ^DIR I $D(DIRUT) S STOP=1 Q
 I Y<INCNESPJ("BEGDT") W !,"     Latest Date must not precede the Earliest Date." G DTRANGE1
 S INCNESPJ("ENDDT")=Y
 Q
 ;
ANOTHER() ; "Select Another" prompt
 ; returns 1, if response was "YES", returns 0 otherwise
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR("A")="Select Another?" S DIR(0)="Y",DIR("B")="NO"
 D ^DIR I $D(DIRUT) S STOP=1
 Q Y
 ;
TYPE ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Excel"
 D ^DIR I $D(DIRUT) S STOP=1 Q
 S INCNESPJ("TYPE")=Y
 Q
 ;
DEVICE ; Ask user to select device
 N %ZIS,ZTRTN,ZTDESC,ZTSAVE,ZTSK,ZTQUEUED,ZTREQ,POP
 ;
 W !!,"*** You will need a 132 column printer for this report. ***",!
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="EN^IBCNGPF3",ZTDESC="IB - Interfacility Ins Update Activity Report"
 .F I="^TMP($J,""PR"",","IBABY","IBOUT" S ZTSAVE(I)=""
 .D ^%ZTLOAD K IO("Q") D HOME^%ZIS
 .W !!,$S($D(ZTSK):"This job has been queued as task #"_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q")
 ;
 ; Compile and print report
 ;
 U IO D EN^IBCNERPK(IBCNERTN,.INCNESPJ)
 ;
 D ^%ZISC
 ; 
 I $D(ZTQUEUED) S ZTREQ="@"
 ;
ENQ K STOP,INCNESPJ,^TMP($J,IBCNERTN),IBCNERTN
 Q
