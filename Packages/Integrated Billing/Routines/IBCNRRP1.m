IBCNRRP1 ;BHAM ISC/CMW - Group Plan Worksheet Report ;03-MAR-2004
 ;;2.0;INTEGRATED BILLING;**251,276**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; e-Pharmacy Group Plan Worksheet Report
 ;
 ; Input parameter: N/A
 ; Other relevant variables:
 ;   IBCNRRTN = "IBCNRRP1" (current routine name for queuing the 
 ;                          COMPILE process)
 ;   IBCNRSPC("BEGDT") = start date for date range
 ;   IBCNRSPC("ENDDT") = end date for date range
 ;   IBCNRSPC("SORT") = 1 - By Insurance/Group; 2 - Total Claims; 
 ;                      3 - Total Charges; 4 - BIN/PCN Exceptions
 ;   IBCNRSPC("MATCH")= 1 - Matched only; 0 - All 
 ;
 ; Enter only from EN tag ONLY
 Q
 ;
 ; Entry point
EN ;
 ; Initialize variables
 N STOP,IBCNRRTN,IBCNRSPC,RESORT
 D:'$D(IOF) HOME^%ZIS
 ;
 S STOP=0,IBPXT=$G(IBPXT)
 S IBCNRRTN="IBCNRRP1"
 W @IOF
 W !,"ePHARM GROUP PLAN WORKSHEET REPORT",!
 W !,"NCPDP process requires that the users match Group Plans to Pharmacy Plans."
 W !,"This report will assist users in matching Group Insurance Plans to Pharmacy"
 W !,"  Plans by searching through Billing/Claims file for authorized claims that "
 W !,"    have Group Plans with active Pharmacy Plan coverage."
 ;
 ; Prompts 
 ; lock global
 L +^XTMP(IBCNRRTN):5 I '$T W !!,"Sorry, Worksheet Report in use." H 2 G EXIT
 ;Check for prior compile
P10 D RESORT(.RESORT) I STOP G EXIT
 I $G(RESORT) G P40
 K ^XTMP(IBCNRRTN)
 ; Date Range parameters
P30 D DTRANGE I STOP G:$$STOP EXIT G P10
 ; Sort parameters
P40 D SORT I STOP G:$$STOP EXIT G P30
 ; Select the output device
P100 D DEVICE(IBCNRRTN,.IBCNRSPC) I STOP!IBPXT G:$$STOP EXIT G P40
 ;
EXIT ; Quit this routine
 ; unlock global
 L -^XTMP(IBCNRRTN)
 K IBPXT
 Q
 ;
RESORT(RESORT) ; check for prior compile
 NEW DIR,BDT,EDT,RDT,HDR,IBDT,X,Y,DIRUT
 I '$D(^XTMP(IBCNRRTN)) Q
 S IBDT=$G(^XTMP(IBCNRRTN,0,0))
 S BDT=$P(IBDT,U,1),EDT=$P(IBDT,U,2),RDT=$P(IBDT,U,3),RESORT=0
 S HDR=$$FMTE^XLFDT(BDT,"5Z")_" - "_$$FMTE^XLFDT(EDT,"5Z")
 W !!,"A Report file run on: ",RDT,!,?5," exist for date range: ",HDR,!
 S DIR(0)="Y"
 S DIR("A")="Do you want to use the existing report file"
 S DIR("B")="YES"
 S DIR("?",1)=" Enter YES to use the existing report file."
 S DIR("?")=" Enter NO to DELETE existing file and recompile,"
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G RESRTX
 S RESORT=Y
 S IBCNRSPC("RESORT")=Y
 S IBCNRSPC("BEGDT")=BDT
 S IBCNRSPC("ENDDT")=EDT
 ;
RESRTX ;RESORT EXIT
 Q
 ;
COMPILE(IBCNRRTN,IBCNRSPC) ; 
 ; Entry point called from EN^XUTMDEVQ in either direct or queued mode.
 ; Input params:
 ;  IBCNRRTN = Routine name for ^TMP(...
 ;  IBCNRSPC = Array passed by ref of the report params
 ;
 ; Init scratch globals
 I '$G(IBCNRSPC("RESORT")) D
 . ; Compile
 . I IBCNRRTN="IBCNRRP1" D EN^IBCNRRP2(IBCNRRTN,.IBCNRSPC)
 ; Print
 I '$G(ZTSTOP) D
 . I IBCNRRTN="IBCNRRP1" D EN^IBCNRRP3(IBCNRRTN,.IBCNRSPC)
 ; Close device
 D ^%ZISC
 ;
 ; Purge task record
 I $D(ZTQUEUED) S ZTREQ="@"
 ;
COMPILX ; COMPILE exit pt
 Q
 ;
STOP() ; Determine if user wants to exit out of the whole option
 ; Init vars
 N DIR,X,Y,DIRUT
 ;
 W !
 S DIR(0)="Y"
 S DIR("A")="Do you want to exit out of this option entirely"
 S DIR("B")="YES"
 S DIR("?",1)="  Enter YES to immediately exit out of this option."
 S DIR("?")="  Enter NO to return to the previous question."
 D ^DIR K DIR
 I $D(DIRUT) S (STOP,Y)=1 G STOPX
 I 'Y S STOP=0
 ;
STOPX ; STOP exit pt
 Q Y
 ;
DTRANGE ; Determine start and end dates for date range param
 ; Init vars
 N X,Y,DIRUT
 ;
 W !
 ;
 S DIR(0)="D^::EX"
 S DIR("A")="Start DATE"
 S DIR("?",1)="   Please enter a valid date for which an Bill/Claim"
 S DIR("?")="   would have been authorized."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G DTRANGX
 S IBCNRSPC("BEGDT")=Y
 ; End date
DTRANG1 S DIR(0)="D^::EX"
 S DIR("A")="  End DATE"
 S DIR("?",1)="   Please enter a valid date for which an Bill/Claim"
 S DIR("?",2)="   would have been authorized.  This date must not precede"
 S DIR("?")="   the Start Date."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G DTRANGX
 I Y<IBCNRSPC("BEGDT") D  G DTRANG1
 . W !,"     End Date must not precede the Start Date."
 . W !,"     Please reenter."
 S IBCNRSPC("ENDDT")=Y
 ;
DTRANGX ; DTRANGE exit pt
 Q
 ;
SORT ; Prompt to allow users to sort the report
 ;  by Insurance/Group, Max claims, Max charges
 NEW DIR,X,Y,DIRUT
 ;
 S DIR(0)="S^1:Insurance/Group;2:Total Claims;3:Total Charges;4:Exceptions Only"
 S DIR("A")=" Select the primary sort field"
 S DIR("B")=1
 S DIR("?",1)="  1 - Sort all Claims by Insurance/Group. (Default)"
 S DIR("?",2)="  2 - Sort by Groups with the most Claims"
 S DIR("?",3)="  3 - Sort by Groups with the most Charges"
 S DIR("?",4)="  4 - Show BIN/PCN Exceptions only"
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G SORTX
 S IBCNRSPC("SORT")=Y
 ;
 ;Prompt for All/Matched only
 S DIR(0)="SA^A:All;M:Matched Only"
 S DIR("A")=" List (A)LL Insurance/Groups or (M)atched Only: "
 S DIR("B")="Matched Only"
 W ! D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G SORTX
 S IBCNRSPC("MATCH")=(Y="M")
 ;
SORTX ; SORT exit point
 Q
 ;
 ;
DEVICE(IBCNRRTN,IBCNRSPC) ; Device Handler and possible TaskManager calls
 ;
 ; Input params:
 ;  IBCNRRTN = Routine name for ^TMP($J,...
 ;  IBCNRSPC = Array passed by ref of the report params
 ;
 ; Init vars
 N ZTRTN,ZTDESC,ZTSAVE,POP
 ;
 ;I IBCNRRTN="IBCNRRP1" W !!!,"*** This report is 132 characters wide ***",!
 S ZTRTN="COMPILE^IBCNRRP1("""_IBCNRRTN_""",.IBCNRSPC)"
 S ZTDESC="ePHARM GROUP PLAN WORKSHEET REPORT"
 S ZTSAVE("IBCNRSPC(")=""
 S ZTSAVE("IBCNRRTN")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE)
 I POP S STOP=1
 ;
DEVICEX ; DEVICE exit pt
 Q
 ;
