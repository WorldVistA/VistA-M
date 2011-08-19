SCMCHLR8 ;ALB/KCL - PCMM HL7 Reject Transmission Report; 22-FEB-2000
 ;;5.3;Scheduling;**210**;AUG 13, 1993
 ;
TERPRT ; Description: Main entry point for the PCMM HL7 Reject Transmission Report.
 ;
 ;Control variables used in generating report:
 ; SCRP("BEGIN")=<begining of the date range for error list>
 ; SCRP("END")=<ending date of range>
 ; SCRP("SELCT")=<select 'A'->all errors or 'D'->Date Range>
 ; SCRP("SORT")=<used to determine sort criteria> 
 ; SCRP("EPS")=<used to determine the error processing status> 
 ;
 N SCRP
 ;
 ;Get report parameters
 Q:'$$SELECT(.SCRP)
 Q:'$$ASKRANGE(.SCRP)
 Q:'$$SORTBY(.SCRP)
 Q:'$$EPS(.SCRP)
 ;
 ;Print report
 I $$DEVICE() D PRINT^SCMCHLR9
 ;
 Q
 ;
 ;
DEVICE() ; Description: Allows the user to select a device.
 ;
 ;  Input: None
 ;
 ; Output:
 ;  Function Value - Returns 0 if the user decides not to print or
 ;                   to queue the report, 1 otherwise.
 ;
 N OK
 S OK=1
 S %ZIS="MQ"
 D ^%ZIS
 S:POP OK=0
 D:OK&$D(IO("Q"))
 .S ZTRTN="PRINT^SCMCHLR9",ZTDESC="PCMM Transmission Error REPORT",ZTSAVE("SCRP(")=""
 .D ^%ZTLOAD
 .W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 .D HOME^%ZIS
 .S OK=0
 ;
 Q OK
 ;
 ;
SELECT(SCRP) ; Description: Ask the user to select 'all errors' or errors for a 'date range'.
 ;
 ;  Input: None
 ;
 ; Output:
 ;  Function value - 1 if user selected all errors, 0 otherwise
 ;  SCRP("SELCT") - (pass by reference) used to return list filter
 ;
 N DIR,DTOUT,DUOUT,X,Y
 ;
 ;Ask user to select all errors or date range
 S DIR(0)="SMO^A:All Errors;D:Date Range"
 S DIR("A")="Select all errors or a date range"
 S DIR("?",1)="You have a choice of selecting all errors to be printed,"
 S DIR("?")="or errors may be printed for a specified date range."
 D ^DIR
 ;Process user response
 Q:$D(DIRUT) 0
 S SCRP("SELCT")=Y
 Q 1
 ;
 ;
ASKRANGE(SCRP) ;
 ; Description: Asks the user to enter a date range for report.
 ;
 ;If user selected ALL errors, init begin and end dates and quit
 I $G(SCRP("SELCT"))="A" D  Q 1
 .S SCRP("BEGIN")=0
 .S SCRP("END")=DT
 ;Otherwise, ask user for date range
 Q:'$$ASKBEGIN(.SCRP) 0
 Q:'$$ASKEND(.SCRP) 0
 Q 1
 ;
 ;
ASKBEGIN(SCRP) ;
 ;Description: Asks the user to enter a begin date.
 ;
 ;  Input: None
 ;
 ; Output:
 ;   Function value - 1 if user selected a date, 0 otherwise
 ;   SCRP("BEGIN")=(pass by reference) used to return date selected
 ;
 N DIR,DTOUT,DUOUT,X,Y
 S DIR(0)="D^::EX"
 S DIR("A")="Enter Beginning Date"
 S DIR("B")=$$FMTE^XLFDT($$FMADD^XLFDT(DT,-14),"D")
 S DIR("?")="Enter the first day to begin searching for PCMM Transmission Errors."
REPEAT D ^DIR
 Q:$D(DIRUT) 0
 I Y>DT W !,"Date can not be latter than today!" G REPEAT
 S SCRP("BEGIN")=Y
 Q 1
 ;
 ;
ASKEND(SCRP) ;
 ; Description: Asks the user to enter an end date.
 ;
 ;  Input:
 ;   SCRP("BEGIN") - the earliest possible date
 ;
 ; Output:
 ;  Function value - 1 if user selected a date, 0 otherwise
 ;  SCRP("END")=(pass by reference) used to return date selected
 ;
 N DIR,DTOUT,DUOUT,X,Y
 S DIR(0)="D^::EX"
 S DIR("A")="Enter Ending Date"
 ;S DIR("B")=$$FMTE^XLFDT(SCRP("BEGIN"),"D")
 S DIR("B")=$$FMTE^XLFDT(DT,"D")
 S DIR("?")="Enter the last day to list transmission errors for."
AGAIN D ^DIR
 Q:$D(DIRUT) 0
 I (Y<$G(SCRP("BEGIN"))) W !,"Date must not be earlier than "_DIR("B") G AGAIN
 S SCRP("END")=Y
 Q 1
 ;
 ;
SORTBY(SCRP) ; Description: Ask the user to enter a sort criteria for printing errors.
 ;
 ;  Input: None
 ;
 ; Output:
 ;  Function value - 1 if user selected a sort, 0 otherwise
 ;  SCRP("SORT") - (pass by reference) used to return sort by criteria
 ;
 N DIR,DTOUT,DUOUT,X,Y
 ;Ask user to select sort by criteria
 S DIR(0)="SMO^N:Patient Name;D:Date Error Received;P:Provider"
 S DIR("A")="Select sort criteria for listing PCMM Transmission Errors"
 S DIR("?")="Enter how the error list should be sorted by."
 D ^DIR
 ;Process user response
 Q:$D(DIRUT) 0
 S SCRP("SORT")=Y
 Q 1
 ;
 ;
EPS(SCRP) ; Description: Ask user to enter a error processing status.
 ;
 ;  Input: None
 ;
 ; Output:
 ;  Function value - 1 if user selected an error processin status, 0 otherwise
 ;    SCRP("EPS") - (pass by reference) used to return Error Processing
 ;                  Status: 1->New, 2->Checked, 3->Both
 ;
 N DIR,DTOUT,DUOUT,X,Y
 ;Ask user to select error processing status
 S DIR(0)="SMO^1:New;2:Checked;3:Both"
 S DIR("A")="Select Error Processing Status"
 S DIR("?",1)="Enter an error processing status.  Only those errors matching"
 S DIR("?")="the error processing status selected will be listed."
 D ^DIR
 ;Process user response
 Q:$D(DIRUT) 0
 S SCRP("EPS")=+Y
 Q 1
