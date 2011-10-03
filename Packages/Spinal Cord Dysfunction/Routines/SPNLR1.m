SPNLR1 ;ISC-SF/GB-SCD SETUP FOR REPORTS ;6/23/95  11:52
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ; This subroutine asks the user questions concerning the report.
 ; It should be called using the ENTRY entry point.  RPTID and ABORT
 ; must be supplied by the calling program.  All parms except RPTID
 ; should be "call by reference".
 ; ABORT must be tested by calling program upon return.
ASK(RPTID,FDATE,TDATE,QLIST,HIUSERS,ABORT) ;
 I "ABCDEF"[RPTID D
 . D ASK1
 E  D ASK2
 K SPNLTRAM,SPNLTRM1,SPNTD,SPNCAUSE,SPND1,SPNETIOL
 Q
ASK1 ;
 D @("ASK^SPNLR"_RPTID_"(.QLIST,.ABORT)") Q:ABORT
 I RPTID'="F" D EN^SPNLRU1 Q:ABORT
 I $G(QLIST("WINDOW"))=1 D  Q:ABORT
 . D GETWIN
 E  S (FDATE,TDATE)=""
 S HIUSERS=0
 Q
ASK2 ;
 ;           FDATE,TDATE:  Get report period (window)
 D GETWIN Q:ABORT
 ;
 ; Call the report routine to let it ask its specific questions
 D @("ASK^SPNLR"_RPTID_"(.QLIST,.ABORT)") Q:ABORT
 ;
 D EN^SPNLRU1 Q:ABORT
 I "QRS"[RPTID D
 . D SEEUSE ; HIUSERS:  Do you want to see the users?
 E  D HIUSE Q:ABORT  ; HIUSERS:  How many highest users do you want identified?
 Q
GETWIN ; Ask the user for the period (window)
 N DIR,DIRUT,Y
 ;      Enter a Date; Optional; no minimum; today is maximum; Exact date
 S DIR(0)="DO^:DT:EX"
 S DIR("A")="Start date for period"
 S DIR("?")="^D HELP^%DTC"
 D ^DIR I $D(DIRUT) S ABORT=1 Q
 S FDATE=Y
 S DIR(0)="DO^"_FDATE_":DT:EX"
 S DIR("B")="TODAY"
 S DIR("A")="  End date for period"
 S DIR("?")="^D HELP^%DTC"
 D ^DIR I $D(DIRUT) S ABORT=1 Q
 S TDATE=Y
 Q
HIUSE ;
 N DIR,DIRUT,Y
 S DIR(0)="NO^0:100" ; Optional number from 0 to 100
 S DIR("B")=0 ; Default answer
 I $D(^XUSEC("SPNL SCD PTS",DUZ)) D
 . S DIR("A")="Number of highest users to identify"
 . S DIR("?")="Enter the number of patients you want identified who have used the most resources"
 E  D
 . S DIR("A")="Number of highest users (data only) to identify"
 . S DIR("?")="Only patient resource utilization data is displayed, as you are not authorized to see patient names and SSNs"
 D ^DIR I $D(DIRUT) S ABORT=1 Q
 S HIUSERS=Y
 Q
SEEUSE ; For the "specific" reports, should we show the patients or not?
 N DIR,DIRUT,Y
 I $D(^XUSEC("SPNL SCD PTS",DUZ)) D
 . S DIR(0)="YAO" ; Answer yes or no
 . S DIR("B")="YES" ; Default answer
 . S DIR("A")="Do you want to see patient usage data?  "
 . S DIR("?")="Answer YES to list resource utilization data broken out by patient.  Answer NO to list only the totals for each selection."
 . D ^DIR I $D(DIRUT) S ABORT=1 Q
 . S HIUSERS=Y
 E  S HIUSERS=0 ; don't show patients
 Q
