IBCNERP7 ;DAOU/BHS - eIV STATISTICAL REPORT ;10-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,416,528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; eIV - Insurance Verification Interface
 ;
 ; Input parameter: N/A
 ; Other relevant variables:
 ;   IBCNERTN = "IBCNERP7" (current routine name for queueing the 
 ;                          COMPILE process)
 ;   IBCNESPC("BEGDTM") = start date/time for date/time range
 ;   IBCNESPC("ENDDTM") = end date/time for date/time range
 ;   IBCNESPC("SECTS") = list of sections to display on the report
 ;                       1 = All (Outgoing, Incoming and General),
 ;                       2 = Outgoing - Inquiry Response data,
 ;                       3 = Incoming - Inquiry Transmission data,
 ;                       4 = General - Ins Buffer data, Outstanding 
 ;                           Inquiries, Communication Failures, Retries
 ;                       may equal a list of values if '1' is not the
 ;                       the only value
 ;   IBCNESPC("MM") = "", not for MailMan message OR
 ;                    MAILGROUP, generate as MailMan message for this
 ;                               MAILGROUP as defined in IB site 
 ;                               parameters
 ;   IBOUT = "E" for Excel or "R" for report format
 ;
 ; Only enter routine from EN or MAILMSG tags
 Q
 ;
 ; Entry pt
EN ;
 ; Init vars 
 N STOP,IBCNERTN,POP,IBCNESPC,IBOUT
 ;
 S STOP=0
 S IBCNERTN="IBCNERP7"
 W @IOF
 W !,"eIV Statistical Report",!
 W !,"Please select the timeframe for which to view the Insurance"
 W !,"Verification statistics and current status."
 ;
 ; Default to MailMan flag to No from the EN tag
 S IBCNESPC("MM")=""
 ;
 ; Prompts for Payer Report
 ; Date Range parameters
S10 D DTMRNG I STOP G EXIT
 ; Sort by parameter - Payer or Total Inquiries (Payer Report)
S20 D SECTS I STOP G:$$STOP^IBCNERP1 EXIT G S10
 ; Select report type  528 - baa
S30 S IBOUT=$$OUT I STOP G:$$STOP^IBCNERP1 EXIT G S20
 ; Select the output device
S50 D DEVICE^IBCNERP1(IBCNERTN,.IBCNESPC,IBOUT) I STOP G:$$STOP^IBCNERP1 EXIT G S20
 ;
EXIT ; Quit this routine
 Q
 ;
 ;
DTMRNG ; Determine the start and end date/times for the report
 ; Init vars
 N DIR,X,Y,DIRUT
 ;
 W !
 ;
 S DIR(0)="DO^::ERX"
 S DIR("A")="Start DATE/TIME"
 S DIR("?",1)="    Enter Start DATE/TIME for report range."
 S DIR("?")="    The time element is required."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G DTMRNGX
 S IBCNESPC("BEGDTM")=Y
 ;
DTMRNG1 S DIR(0)="D^::ERX"
 S DIR("A")="  End DATE/TIME"
 S DIR("?",1)="    Enter End DATE/TIME for report range."
 S DIR("?")="    The time element is required."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G DTMRNGX
 I Y<IBCNESPC("BEGDTM") D  G DTMRNG1
 . W !,"    The End Date/Time must not precede the Start Date/Time."
 . W !,"    Please reenter."
 S IBCNESPC("ENDDTM")=Y
 ;
DTMRNGX ; DTMRNG exit pt
 Q
 ;
 ;
SECTS ; Prompt to allow users to include the available sections in the report
 ; Init vars
 N DIR,X,Y,DIRUT
 ;
 W !
 S DIR(0)="L^1:4"
 S DIR("A",1)="Choose all sections to be reviewed"
 S DIR("A",2)="1  -  All            = All three report sections (Default)"
 S DIR("A",3)="2  -  Outgoing Data  = Inquiry Transmission statistics"
 S DIR("A",4)="3  -  Incoming Data  = Inquiry Response statistics"
 S DIR("A",5)="4  -  Current Status = Pending Responses, Queued Inquiries, etc."
 S DIR("A")="Select one or more sections: "
 S DIR("B")=1
 S DIR("?",1)="  Please select one or more sections of the report to view."
 S DIR("?",2)="  To select multiple sections enter a comma separated list"
 S DIR("?",3)="  (ex. 2,4)."
 S DIR("?",4)="  1  -  Include all three sections in the report.  (Default)"
 S DIR("?",5)="  2  -  Include statistics on inquiries transmitted during the"
 S DIR("?",6)="        timeframe by extract type."
 S DIR("?",7)="  3  -  Include statistics on responses received during the"
 S DIR("?",8)="        timeframe by extract type."
 S DIR("?",9)="  4  -  Include statistics on the current state of the system."
 S DIR("?",10)="        This section is independent of the timeframe for the"
 S DIR("?",11)="        report and includes responses pending, queued inquiries,"
 S DIR("?",12)="        deferred inquiries, payer statistics and insurance"
 S DIR("?")="        buffer statistics."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G SECTSX
 ; Default to all if 1 is included OR if 2,3 and 4 are included in any
 ; order
 S Y=","_Y
 I Y[(",1,") S IBCNESPC("SECTS")=1 G SECTSX
 I Y[(",2,"),Y[(",3,"),Y[(",4,") S IBCNESPC("SECTS")=1 G SECTSX
 S IBCNESPC("SECTS")=Y
 ;
SECTSX ; SECTS exit pt
 Q
 ;
 ;
MAILMSG ; Tag to be called by TaskMan to generate report with default values
 ; and send as MailMan message
 ; Init vars
 N IBCNERTN,IBCNESPC,EDT,BDT,TM,IBOUT
 ;
 ; -- set the mail message to display in a report format
 S IBOUT="R"
 ;
 ; Default report parameters
 ; Start Date/Time - End Date/Time range
 ;  Determine start time based on IB site parameter
 S TM=$$GET1^DIQ(350.9,"1,",51.03,"E")
 I TM=""!(+TM=0) S TM="2400"
 S EDT=$$DT^XLFDT
 S BDT=$$FMADD^XLFDT(EDT,-1)
 S IBCNESPC("BEGDTM")=+(BDT_"."_TM)
 S IBCNESPC("ENDDTM")=+(EDT_"."_TM)
 ; Display all sections
 S IBCNESPC("SECTS")=1
 ; Set MailMan flag to IB site parameter MAILGROUP
 S IBCNESPC("MM")=$$MGRP^IBCNEUT5
 ; If there is no MailGroup to send message - do not continue
 I IBCNESPC("MM")="" QUIT
 ; If the send MailMan message parameter is turned off, stop the process
 I '$P($G(^IBE(350.9,1,51)),U,2) QUIT
 ;
 ; Set routine parameter
 S IBCNERTN="IBCNERP7"
 ;
 ; Initialize scratch global
 KILL ^TMP($J,IBCNERTN)
 ; Compile the report data
 D EN^IBCNERP8(IBCNERTN,.IBCNESPC)
 ; Print the report - to MailMan
 I '$G(ZTSTOP) D EN^IBCNERP9(IBCNERTN,.IBCNESPC,IBOUT)
 ;
 ; Kill scratch global
 KILL ^TMP($J,IBCNERTN)
 ;
 ; Purge the task record
 I $D(ZTQUEUED) S ZTREQ="@"
 ;
 ; MAILMSG exit pt
 Q
 ;  528 - baa : Add option to ouput data in excel format
OUT() ; Prompt to allow users to select output format
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 D ^DIR I $D(DIRUT) S STOP=1 Q ""
 Q Y
 ;
