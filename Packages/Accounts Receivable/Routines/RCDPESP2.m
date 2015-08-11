RCDPESP2 ;BIRM/EWL - ePayment Lockbox Parameter Audit and Exclusion Reports ;Jul 28, 2014@18:14:57
 ;;4.5;Accounts Receivable;**298**;Nov 11, 2013;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
RPT1 ; EDI Lockbox Parameters Report [RCDPE SITE PARAMETER REPORT]
 ;
 ; DESCRIPTION: This report is a simple listing of the RCDPE PARAMETER AUDIT file
 ;              including data concerning changes to the RCDPE PPARAMETER file.
 ;
 ; Input:       None
 ;
 ; GLOBALS:     ^RCY(344.7,              RCDPE PARAMETER AUDIT
 ;              ^TMP("RCDPESP2",$J,      TMP FILE FOR LIST^DIC OUTPUT
 ;
 ; GLOBALS:     ^RCY(344.7, - RCDPE PARAMETER AUDIT
 ;
 ; INPUT PARAMETERS: NONE
 ;
 ; LOCAL VARIABLES:
 ;    RCRANGE - RETURN VALUE FOR DATE RANGE FOR THE REPORT
 ;    RCSTDT  - STARTING DATE FOR THE REPORT
 ;    RCENDT  - END DATE FOR THE REPORT
 ;    RCEXCEL - INDIATES IF OUTPUT IS GOING TO EXCEL
 ;    RCSCR   - SCREEN FOR LIST^DIC CALL
 ;    RCFLDS  - FIELDS TO BE CAPTURED IN LIST^DIC CALL
 ;    RCDIGET   - ^TMP GLOBAL RESULTS FROM LIST^DIC CALL
 ;    RCDIERR   - HOLDS ERRORS FROM LIST^DIC
 ;    RCHDR("RUNDATE")   - DATE THE REPORT RAN
 ;    RCHDR("PAGE")  - PAGE COUNTER
 ;    RCSTOP  - STOP DISPLAYING THE REPORT
 ;    RCPARAM - PARAMETER THAT WAS CHANGED
 ;    RCPARAM("OLDVAL")   - OLD PARAMETER VALUE
 ;    RCPARAM("TIME")  - TIME PARAMETER WAS CHANGED
 ;    RCPARAM("NEWVAL")   - NEW PARAMETER VALUE
 ;    RCPARAM("USER")  - USER WHO CHANGED A PARAMETER
 ;    RCTMP   - HOLDS ONE LINE OF DATA FROM LIST^DIC OUTPUT
 ;
 N RCDIERR,RCDIGET,RCENDT,RCEXCEL,RCFLDS,RCHDR,RCIEN,RCPARAM,RCRANGE,RCSCR,RCSTDT,RCSTOP,RCTMP
 ; Kernel variables
 N X1,X2,X,Y,%ZIS,POP
 W !!,"EDI Lockbox Parameters Report",!
 ;
 S (RCHDR("PAGE"),RCSTOP,RCHDR,RCEXCEL)=0
 S RCRANGE=$$DTRNG()
 Q:RCRANGE=0
 S RCSTDT=$P(RCRANGE,U,2),RCENDT=$P(RCRANGE,U,3)
 S RCEXCEL=$$DISPTY^RCDPEM3() Q:+RCEXCEL=-1
 ; Display capture information for Excel
 I RCEXCEL D INFO^RCDPEM6
 ;Select output device
 S %ZIS="M" D ^%ZIS Q:POP  U IO
 ; INPUT PARAMETER:
 ;   RCEXCEL - IF 1 THEN OUTPUT FOR EXCEL
 ;
 S RCHDR("RUNDATE")=$$FMTE^XLFDT($$NOW^XLFDT,"5S")
 S RCHDR("DATERANGE")=$$FMTE^XLFDT(RCSTDT,"5D")_" - "_$$FMTE^XLFDT(RCENDT,"5D")
 ;
 S RCENDT=RCENDT+.999999
 S RCSCR="I ($P(^(0),U,5)=344.61)&($P(^(0),U,1)>"_RCSTDT_")&($P(^(0),U,1)<"_RCENDT_")"
 S RCFLDS="@;.04;.01I;.07;.06;.03"
 S RCDIGET=$NA(^TMP("RCDPESP2",$J)) K @RCDIGET
 D LIST^DIC(344.7,,RCFLDS,"P",,,,,RCSCR,,RCDIGET,"RCDIERR")
 I $D(RCDIERR) W !!,"ERROR COLLECTING THE REPORT DATA" D ASK^RCDPEARL() Q
 I '$D(@RCDIGET@("DILIST",1)) D  Q
 . D HDRLPR(RCEXCEL,.RCHDR,.RCSTOP)
 . W !,"NO PARAMETER AUDIT ENTRIES TO REPORT",!
 S RCIEN=0 F  S RCIEN=$O(@RCDIGET@("DILIST",RCIEN)) Q:RCSTOP!('RCIEN)  D
 . I 'RCHDR("PAGE") D
 . . D HDRLPR(RCEXCEL,.RCHDR,.RCSTOP)
 . Q:RCSTOP
 . K RCPARAM
 . S RCTMP=$P(@RCDIGET@("DILIST",RCIEN,0),U,2,6)
 . S RCPARAM=$$GET1^DID(344.61,$P(RCTMP,U,1),,"LABEL")
 . S RCPARAM("TIME")=$$FMTE^XLFDT($P(RCTMP,U,2),"2")
 . S RCPARAM("USER")=$P(RCTMP,U,5)
 . I ($P(RCTMP,U,1)=.02)!($P(RCTMP,U,1)=.03) D
 . . S RCPARAM("OLDVAL")=$S($P(RCTMP,U,3):"Yes",1:"No")
 . . S RCPARAM("NEWVAL")=$S($P(RCTMP,U,4):"Yes",1:"No")
 . E  D
 . . S RCPARAM("OLDVAL")=$P(RCTMP,U,3)
 . . S RCPARAM("NEWVAL")=$P(RCTMP,U,4)
 . I 'RCEXCEL D
 . . W !,RCPARAM,?32,RCPARAM("TIME"),?51,RCPARAM("OLDVAL"),?56,RCPARAM("NEWVAL"),?61,$E(RCPARAM("USER"),1,IOM-61)
 . I RCEXCEL W !,RCPARAM_U_RCPARAM("TIME")_U_RCPARAM("OLDVAL")_U_RCPARAM("NEWVAL")_U_RCPARAM("USER")
 ;
 ; end of report
 W !!,$$ENDORPRT^RCDPEARL
 K @RCDIGET
 Q
 ;
HDRLPR(RCEXCEL,RCHDR,RCSTOP) ; Report header Lockbox Parameter Report
 ;   RCEXCEL - if true output for Excel
 ;   RCHDR("PAGE") - page count, passed by ref.
 ;   RCSTOP  - report exit flag
 ;
 I RCEXCEL D  Q  ; Excel header for PARAMETER AUDITS
 .Q:RCHDR("PAGE")
 .W !,"PARAMETER^DATE/TIME EDITED^OLD VALUE^NEW VALUE^USER"
 .S RCHDR("PAGE")=1  ; only print once
 ;
 I 'RCEXCEL D
 .I RCHDR("PAGE") D ASK^RCDPEARL(.RCSTOP) Q:RCSTOP
 .W @IOF
 .S RCHDR("PAGE")=RCHDR("PAGE")+1
 . W $$CNTR("EDI Lockbox Parameter Audit Report"),?IOM-8,"Page: "_RCHDR("PAGE")
 . W !,$$CNTR("RUN DATE: "_RCHDR("RUNDATE"))
 . W !,$$CNTR("DATE RANGE: "_RCHDR("DATERANGE"))
 . W !!,"LOCKBOX PARAMETER UPDATES"
 . W !,"-------------------------                           Values"
 . W !,"Parameter                       Date/Time Edited   Old  New  User"
 . N I S $P(I,"=",IOM+1)="" W !,I
 Q
 ;
RPT2 ; EDI Lockbox Exclusion Audit Report [RCDPE EXCLUSION AUDIT REPORT]
 ;
 ; DESCRIPTION: This report is a simple listing of the RCDPE PARAMETER AUDIT file
 ;              including data concerning changes to the RCDPE AUTO-PAY EXCLUSION file.
 ;
 ; GLOBALS:     ^RCY(344.7,              RCDPE PARAMETER AUDIT
 ;              ^RCY(344.6,              RCDPE AUTO-PAY EXCLUSION
 ;              ^TMP("RCDPESP2",$J,      TMP FILE FOR LIST DIC OUTPUT
 ;
 ; INPUT PARAMETERS: NONE
 ;
 ; LOCAL VARIABLES:
 ;    RCRANGE - date range for report
 ;    RCSTDT  - report start date
 ;    RCENDT  - report end date
 ;    RCEXCEL - true if report in Excel format
 ;    RCSCR - screening logic for LIST^DIC
 ;    RCFLDS  - fields for LIST^DIC
 ;    RCDIGET - storage for results from LIST^DIC
 ;    RCDIERR - errors from LIST^DIC
 ;    RCHDR("PAGE")  - page counter
 ;    RCHDR("RUNDATE") - date/time report was run 
 ;    RCSTOP  - report exit flag
 ;    RCPARAM - parameter that was changed
 ;    RCPARAM("TIME")   - time parameter changed
 ;    RCPARAM("OLDVAL") - old parameter value
 ;    RCPARAM("NEWVAL") - new parameter value
 ;    RCPARAM("USER")  - USER WHO CHANGED A PARAMETER
 ;    RCTMP - one record from LIST^DIC
 ;    RCFND - flag indicating records returned
 ;
 W !!,"   EDI Lockbox Exclusion Audit Report",!
 ;
 N RCENDT,RCEXCEL,RCFLDS,RCFND,RCDIGET,RCHDR,RCIEN,RCDIERR,RCPARAM,RCRANGE,RCSCR,RCSTDT,RCSTOP,RCTMP
 ; Kernel variables
 N X1,X2,X,Y,%ZIS,POP
 ; initialize values
 S (RCHDR("PAGE"),RCSTOP,RCIEN,RCEXCEL,RCFND)=0
 S RCDIGET=$NA(^TMP("RCDPESP2",$J)) K @RCDIGET
 ;
 ; GET DATE RANGES
 S RCRANGE=$$DTRNG()
 Q:RCRANGE=0
 S RCSTDT=$P(RCRANGE,U,2)-.0000001,RCENDT=$P(RCRANGE,U,3)+.9999999
 ;
 ; output fields for LIST^DIC
 S RCFLDS="@;.04;.01I;.06;.03;.08;.02"
 ; .04 - CHANGED FIELD  .01 - TIMESTAMP      .06 - NEW VALUE
 ; .03 - CHANGED BY     .08 - COMMENT        .02 - MODIFIED IEN
 ;
 ; first part of LIST^DIC screening logic
 S RCSCR="I ($P(^(0),U,5)=344.6)&($P(^(0),U,1)>"_RCSTDT_")&($P(^(0),U,1)<"_RCENDT_")"
 ;
 ; OUTPUT TO EXCEL?
 S RCEXCEL=$$DISPTY^RCDPEM3() Q:+RCEXCEL=-1
 I RCEXCEL D INFO^RCDPEM6
 ;
 ;Select output device
 S %ZIS="M" D ^%ZIS Q:POP  U IO
 ;
 S RCHDR("RUNDATE")=$$FMTE^XLFDT($$NOW^XLFDT,"5S")
 ;
 ; PROCESS AUTO-POST EXCLUSIONS
 S RCSCR(.06)=RCSCR_"&($P(^(0),U,4)=.06)"  ; screening logic for auto-post changes
 D LIST^DIC(344.7,,RCFLDS,"P",,,,,RCSCR(.06),,RCDIGET,"RCDIERR")
 ; CHECK FOR AN ERROR
 I $D(RCDIERR) W !!,"Error collecting auto-post report data." D ASK^RCDPEARL(.RCSTOP) Q
 D HDRXAR(.06)  ; complete header
 ;
 S RCFND=$D(@RCDIGET@("DILIST",1))  ; CHECK FOR RECORDS RETURNED
 I 'RCFND W !,"No Auto-post Exclusions to Display",!
 ;
 I RCFND S RCIEN=0 D
 .F  S RCIEN=$O(@RCDIGET@("DILIST",RCIEN)) Q:RCSTOP!('RCIEN)  D
 ..S RCTMP=$P(@RCDIGET@("DILIST",RCIEN,0),U,2,7)
 ..I 'RCEXCEL,$Y+4>IOSL D HDRXAR(.06) Q:RCSTOP
 ..D DSPXCLSN(RCTMP)
 ;
 K @RCDIGET,RCDIERR  ; delete old list and any errors
 Q:RCSTOP
 ;
 ; PROCESS AUTO-DECREASE EXCLUSIONS
 S RCSCR(.07)=RCSCR_"&($P(^(0),U,4)=.07)"  ; screening logic for auto-decrease
 D LIST^DIC(344.7,,RCFLDS,"P",,,,,RCSCR(.07),,RCDIGET,"RCDIERR")
 ;
 ; CHECK FOR AN ERROR
 I $D(RCDIERR) W !!,"Error collecting auto-decrease report data." D ASK^RCDPEARL(.RCSTOP) Q
 ;
 D  ; complete header or just the section
 .I $Y+11<IOSL D SECTHDR(.07)  Q  ; just section header
 .D HDRXAR(.07)  ; complete header
 ;
 S RCFND=$D(@RCDIGET@("DILIST",1))  ; CHECK FOR RECORDS RETURNED
 I 'RCFND W !,"No Auto-decrease Exclusions to Display",!
 ; RECORDS RETURNED
 I RCFND S RCIEN=0 F  S RCIEN=$O(@RCDIGET@("DILIST",RCIEN)) Q:RCSTOP!('RCIEN)  D
 .S RCTMP=$P(@RCDIGET@("DILIST",RCIEN,0),U,2,7)
 .I $Y+4>IOSL D HDRXAR(.07) Q:RCSTOP
 .D DSPXCLSN(RCTMP)
 ;
 ; end of report
 W !!,$$ENDORPRT^RCDPEARL
 ;
 K @RCDIGET  ; clean up
 Q
 ;
GETPAYER() ; GET THE PAYER NAME + PAYER ID
 N RCIEN,RCPAYR
 S RCIEN=$P(RCTMP,U,6)
 I '$D(^RCY(344.6,RCIEN)) Q ""
 S RCPAYR=$$GET1^DIQ(344.6,RCIEN_",",.01)_" "_$$GET1^DIQ(344.6,RCIEN_",",.02)
 Q RCPAYR
 ;
HDRXAR(RCTYP) ; Report header for exclusin auto report
 ;   RCTYP -   .06 = AUTO-POSTING EXCLUSION
 ;             .07 = AUTO-DECREASE EXCLUSION
 ;
 I RCEXCEL D  Q
 .Q:RCHDR("PAGE")
 .; Excel header for parameter audits
 .W !!,"TYPE^CHANGE^PAYER^TIMESTAMP^USER^COMMENT"
 .S RCHDR("PAGE")=1  ; only print it once
 ;
 I RCHDR("PAGE") D ASK^RCDPEARL(.RCSTOP) Q:RCSTOP
 W @IOF
 S RCHDR("PAGE")=RCHDR("PAGE")+1
 ; report header for parameter audits
 W $$CNTR("EDI Lockbox Exclusion Audit Report"),?IOM-8,"Page: "_RCHDR("PAGE")
 W !,$$CNTR("DIVISIONS: ALL")
 W !,$$CNTR("RUN DATE: "_$G(RCHDR("RUNDATE")))
 W !,$$CNTR("DATE RANGE: "_$$FMTE^XLFDT(RCSTDT,"5D")_" - "_$$FMTE^XLFDT(RCENDT,"5D"))
 D SECTHDR(RCTYP)
 Q
 ;
SECTHDR(RCTYPE) ; SECTION HEADER
 ;   RCTYP - .06 = AUTO-POSTING EXCLUSION
 ;           .07 = AUTO-DECREASE EXCLUSION
 Q:$G(RCEXCEL)
 ;
 I RCTYPE=.06 D
 .W !!,"AUTO-POSTING PAYER EXCLUSION LIST"
 .W !,"---------------------------------"
 ;
 I RCTYPE=.07 D
 .W !!,"AUTO-DECREASE PAYER EXCLUSION LIST"
 .W !,"----------------------------------"
 ;
 W !,"Change Payer                            Date/Time Edited   User"
 W !,$TR($J("",IOM-1)," ","=")  ; row of equal signs
 Q
 ;
CNTR(TXT) ; center TXT
 Q $J("",IOM-$L(TXT)\2)_TXT
 ;
DTRNG() ; function, returns date range for the report
 N DIR,DUOUT,RNGFLG,X,Y,RCSTART,RCEND
 S (RCSTART,RCEND)=0 D DATES(.RCSTART,.RCEND)
 Q:RCSTART=-1 0
 Q:RCSTART "1^"_RCSTART_"^"_RCEND
 Q:'RCSTART "0^^"
 Q 0
 ;
DATES(BDATE,EDATE) ; Get a date range, both values passed by ref.
 N DIR,DTOUT,DUOUT,X,Y
 S (BDATE,EDATE)=0
 S DIR("?")="Enter the earliest AUDIT DATE to include on the report"
 S DIR(0)="DAO^:"_DT_":APE",DIR("A")="Report start date: " D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S BDATE=-1 Q
 S BDATE=Y K DIR,X,Y
 S DIR("?")="Enter the latest AUDIT DATE to include on the report"
 S DIR(0)="DAO^"_BDATE_":"_DT_":APE",DIR("A")="Report end date: ",DIR("B")=$$FMTE^XLFDT(DT)
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S BDATE=-1 Q
 S EDATE=Y
 Q
 ;
DSPXCLSN(RCX) ; display exclusion
 ; RCX - exclusion value from ^DIC call
 N RCXCLSN
 S RCXCLSN("CHANGE")=$S($P(RCX,U,3):"Added",1:"Removed")
 S RCXCLSN("TIME")=$$FMTE^XLFDT($P(RCX,U,2),"2")
 S RCXCLSN("USER")=$P(RCX,U,4)
 S RCXCLSN("PAYER")=$$GETPAYER
 S RCXCLSN("COMMENT")=$P(RCX,U,5)
 ;
 I 'RCEXCEL D  Q
 .N Y S Y=RCXCLSN("CHANGE"),$E(Y,9)=$E(RCXCLSN("PAYER"),1,30),$E(Y,41)=" "_RCXCLSN("TIME"),Y=Y_" "_RCXCLSN("USER")
 .W !,Y,!,"  Comment: "_RCXCLSN("COMMENT")
 ; Excel format
 S RCXCLSN("LABEL")=$$GET1^DID(344.6,$P(RCX,U,1),,"LABEL")
 W !,RCXCLSN("LABEL")_U_RCXCLSN("CHANGE")_U_RCXCLSN("PAYER")_U_RCXCLSN("TIME")_U_RCXCLSN("USER")_U_RCXCLSN("COMMENT")
 ;
 Q
 ;
