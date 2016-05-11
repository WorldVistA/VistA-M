IBCNVRP0 ;ALB/BAA - Interfacility Ins Update Activity Report;25-FEB-15
 ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Variables:
 ;   IBCNERTN = "IBCNERPF" (current routine name for queueing the 
 ;                          COMPILE process)
 ;   INCNESPJ("BEGDT") = start date for date range
 ;   INCNESPJ("ENDDT") = end date for date range
 ;   INCNESPJ("SORT") = "D" - Date or "F" Facility
 ;   INCNESPJ("SR") = "S" - Sending or "R" - Receiving OR "B" - Both
 ;   INCNESPJ("SD") = "S" - Summary or "D" - Detail
 ;   INCNESPJ("FAC",ien) = Facilities for report, if INCNESPJ("FAC")="A", then include all
 ;   INCNESPJ("TYPE") = report type: "R" - Report, "E" - Excel
 ;
 Q
 ;
EN ; entry point
 N STOP,IBCNERTN,INCNESPJ,I,IBRPT,IBRPT1,ZTDESC,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,POP,%ZIS
 ;
 S STOP=0,IBCNERTN="IBCNVRP0"
 K ^TMP($J,IBCNERTN)
 W @IOF
 W !,"Interfacility Ins Update Activity Report",!
 ; Prompts for Interfacility Ins Update Activity Report
 ; Summary or Detailed
P20 D DS1 I STOP G EXIT
 ; Sending or Receiving
P30 D DS2  I STOP G:$$STOP^IBCNERP1 EXIT G P20
 ; Date Range parameters
P40 D DTRANGE I STOP G:$$STOP^IBCNERP1 EXIT G P30
 ; Facility Selection parameter
P50 I INCNESPJ("SR")="R" D FACILITY I STOP G:$$STOP^IBCNERP1 EXIT G P40
 I INCNESPJ("SR")="S" S INCNESPJ("FAC")="A"
 I INCNESPJ("SR")="B" S INCNESPJ("FAC")="A"
 ; Select sort by date or treating facility
P60 D SORT I STOP G:$$STOP^IBCNERP1 EXIT G P50
 ; Report Type - Report or Excel
P10 D TYPE I STOP G:$$STOP^IBCNERP1 EXIT G P60
 ; Select the output device
P100 D DEVICE
 ;
EXIT ; exit routine
 Q
 ;
DS1 ; Run a (S)ummary or (D)etail Report?
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 N DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^S:SUMMARY;D:DETAILED;"
 S DIR("B")="S"
 S DIR("A")="Run a (S)ummary or (D)etailed Report: Summary// "
 S DIR("?")="Please enter 'S' for 'Summary' or 'D' for a Detailed Report."
 D ^DIR
 I $D(DUOUT)!$D(DTOUT)!(Y=-1) S STOP=1 Q
 S INCNESPJ("SD")=Y,IBRPT=Y
 Q
HDS ; Help for Summary/Detail prompt.
 W !,"Please enter 'S' for 'Summary' or 'D' for a Detailed Report."
 Q
 ;
DS2 ; Run a Report by (R)eceiving View or (S)ending View?
 N DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^R:RECEIVING VIEW;S:SENDING VIEW"
 S DIR("B")="R"
 S DIR("A")="Report by (R)eceiving View or (S)ending View// "
 S DIR("?")="^D HDS2^IBCNVRP0"
 D ^DIR
 I $D(DUOUT)!$D(DTOUT)!(Y=-1) S STOP=1 Q
 S INCNESPJ("SR")=Y,IBRPT1=Y
 Q
HDS2 ; Help for Report by (R)eceiving View or (S)ending View prompt.
 W !,"Please enter 'R' for 'Receiving View' or 'S' for 'Sending View'."
 Q
 ;
FACILITY ;
 N DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ; summary report is always run for all patients
 W !
 S DIR("A")="Run for (A)ll Treating Facilities or (S)elected Facilities: "
 S DIR("A",1)="FACILITY SELECTION:"
 S DIR(0)="SA^A:All;S:Selected",DIR("B")="A"
 D ^DIR
 I $D(DIRUT) S STOP=1 Q
 I Y="A" S INCNESPJ("FAC")="A" Q  ; "All Patients" selected
 S DIC(0)="ABEQ"
 S DIC("A")="Select Treating Facility: "
 S DIC="^DIC(4,"
FAC1 ;
 D ^DIC
 I $D(DUOUT)!$D(DTOUT)!(Y=-1) S STOP=1 Q
 S INCNESPJ("FAC",$P(Y,U,1))=""
 I $$ANOTHER G FAC1
 Q
 ;
DTRANGE ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="D^::EX",DIR("B")="Today"
 S DIR("A",1)="Earliest Date "_$S(IBRPT1="S":"Sent",1:"Received")
 S DIR("A")=$S(IBRPT1="R":"RECEIVING ",1:"SENDING ")_"DATE RANGE SELECTION:"
 D ^DIR I $D(DIRUT) S STOP=1 Q
 S INCNESPJ("BEGDT")=Y
 ; End date
DTRANGE1 ;
 K DIR("A") S DIR("A")="  Latest Date "_$S(IBRPT1="S":"Sent",1:"Received")
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
SORT ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^D:Date;F:Facility"
 S DIR("A")="Sort by (D)ate or (F)acility: "
 S DIR("B")="Date"
 D ^DIR I $D(DIRUT) S STOP=1 Q
 S INCNESPJ("SORT")=Y
 Q
 ;
DEVICE ; Ask user to select device
 ;
 I INCNESPJ("SD")="D" W !!,"*** You will need a 132 column printer for this report. ***",!
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
 U IO D EN^IBCNVRP1(IBCNERTN,.INCNESPJ)
 ;
 D ^%ZISC
 ; 
 I $D(ZTQUEUED) S ZTREQ="@"
 ;
ENQ K STOP,INCNESPJ,^TMP($J,IBCNERTN),IBCNERTN
 Q
