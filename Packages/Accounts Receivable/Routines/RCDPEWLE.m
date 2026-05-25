RCDPEWLE ;AITC/CJE - ELECTRONIC EOB WORKLIST ACTIONS ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**439**;Mar 20, 1995;Build 29
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
ERADET() ; Created for PRCA*4.5*439 - EP from ^RCDPEWL0
 N DIR,X,Y
 S DIR("?",1)="Including expanded detail will significantly increase the size of this report"
 S DIR("?",2)="IF YOU CHOOSE TO INCLUDE IT, ALL PAYMENT DETAILS FOR EACH EEOB WILL BE"
 S DIR("?")="listed.  If you want just summary data for each EEOB, do NOT include it."
 S DIR(0)="YA",DIR("A")="Do you want to include expanded EEOB detail?: ",DIR("B")="NO"
 W !
 D ^DIR
 I $D(DUOUT)!$D(DTOUT) Q -1
 Q +Y
 ;
AUDIT() ; Created for PRCA*4.5*439 - EP from ^RCDPEWL0
 N DIR,X,Y
 S DIR("?",1)="Choosing to show audit information will cause auto-post and match status"
 S DIR("?")="audit information to be displayed below the EEOB details."
 S DIR(0)="YA",DIR("A")="Display Auto-Post and Match Status Audit Information?: ",DIR("B")="NO"
 W !
 D ^DIR
 I $D(DUOUT)!$D(DTOUT) Q -1
 Q +Y
 ;
GETAUD(ERAIEN,OUTARR) ; Get auto-post and match audit information for a single ERA (EP)
 ; Input : ERAIEN - Internal entry number for file #344.4
 ; Output: OUTARR - Passed by reference - returns array of text information for a report.
 ;
 N CNT,DATA,EFT,IEN,IEN2,STAMP,OLD,NEW,USER,REASON
 S CNT=1
 S OUTARR(CNT)="  **AUTO POST STATUS**"
 S IEN=0
 I '$O(^RCY(344.72,"E",ERAIEN,IEN)) D  ;
 . S CNT=CNT+1,OUTARR(CNT)="    No audit entries for this ERA"
 . S CNT=CNT+1,OUTARR(CNT)=""
 E  F  S IEN=$O(^RCY(344.72,"E",ERAIEN,IEN)) Q:'IEN  D  ;
 . S DATA=$G(^RCY(344.72,IEN,0))
 . S STAMP=$$FMTSTAMP($P(DATA,"^",1))
 . S OLD=$$GET1^DIQ(344.72,IEN_",",.04,"E")
 . I OLD="" S OLD="NULL"
 . S NEW=$$GET1^DIQ(344.72,IEN_",",.05,"E")
 . I NEW="" S NEW="NULL"
 . S REASON=$P(DATA,"^",6)
 . S USER=$$GET1^DIQ(344.72,IEN_",",.02,"E")
 . S CNT=CNT+1
 . S OUTARR(CNT)="    "_$$PAD(STAMP,17)_"      "_$$PAD(OLD,12)_" "_$$PAD(NEW,18)_" "_$E(USER,1,21)
 . S CNT=CNT+1
 . S OUTARR(CNT)="    "_REASON
 . S CNT=CNT+1
 . S OUTARR(CNT)=""
 ;
 S CNT=CNT+1,OUTARR(CNT)="  **MATCH STATUS**"
 S IEN2=0
 I '$O(^RCY(344.4,ERAIEN,10,IEN2)) D  ;
 . S CNT=CNT+1,OUTARR(CNT)="    No audit entries for this ERA"
 . S CNT=CNT+1,OUTARR(CNT)=""
 E  F  S IEN2=$O(^RCY(344.4,ERAIEN,10,IEN2)) Q:'IEN2  D  ;
 . S DATA=^RCY(344.4,ERAIEN,10,IEN2,0)
 . S STAMP=$$FMTSTAMP($P(DATA,"^",1))
 . S USER=$$GET1^DIQ(344.43,IEN2_","_ERAIEN_",",.02,"E")
 . S OLD=$$GET1^DIQ(344.43,IEN2_","_ERAIEN_",",.03,"E")
 . S OLD=$$ABB(OLD)
 . I OLD="" S OLD="NULL"
 . S NEW=$$GET1^DIQ(344.43,IEN2_","_ERAIEN_",",.04,"E")
 . S NEW=$$ABB(NEW)
 . I NEW="" S NEW="NULL"
 . S EFT=$P(DATA,"^",5)
 . I EFT S EFT=$$GET1^DIQ(344.31,EFT_",",.01,"E")
 . I EFT'="" S EFT=" ("_EFT_")"
 . S CNT=CNT+1
 . S OUTARR(CNT)="       "_$$PAD(STAMP,17)_"   "_$$PAD(OLD,12)_" "_$$PAD(NEW_EFT,18)_" "_$E(USER,1,21)
 Q
FMTSTAMP(X) ; Format date stamp 
 ; Input : X date/time in fileman format
 ; Return : date/time in format MM/DD/YY:HH:MM:SS
 N DATE,STAMP,TIME
 S DATE=$P(X,".",1),TIME=$P(X,".",2)
 S DATE=$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)
 S STAMP=DATE_"@"_$E(TIME,1,2)_":"_$E(TIME,3,4)_":"_$E(TIME,5,6)
 Q STAMP
PAD(X,Y) ; Right pad X to length Y
 ; Input : X - String to PAD
 ;         Y - Length
 ; Return: X padded to length Y.
 Q $E(X_$J("",80),1,Y)
 ;
ABB(X) ; Abbreviate match status to be no more than 10 chars
 N RETURN
 S RETURN=X
 I X="MATCHED TO PAPER CHECK" S RETURN="PAPER CHK"
 I X="MATCHED WITH ERRORS" S RETURN="MATCH ERR"
 I X="MATCH-0 PAYMENT" S RETURN="MATCH-0"
 I X="REMOVED FROM WORKLIST" S RETURN="REMOVED"
 I X="MATCHED TO TDA" S RETURN="MATCH TDA"
 S RETURN=$E(RETURN,1,10)
 Q RETURN
 ;
ERASTR ; Enter here for new style ERA Status Change Report with ERA Detail, Auto-Post and Match Audit - PRCA*4.5*439
 ;
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,QUIT,RCALL,RCTYPE,RCERA,RCRANGE
 S DIR(0)="SA^S:SINGLE ERA;A:ALL"
 S DIR("A")="SELECT (S)ingle ERA or (A)LL: ",DIR("B")="ALL"
 D ^DIR
 I Y'="S",Y'="A" Q
 S RCALL=Y
 ;
 ; If Single ERA, select the ERA
 S RCERA="",RCTYPE="A",RCRANGE="",QUIT=0
 I RCALL="S" D  Q:'RCERA
 . S RCERA=$$SELERA^RCDPEAPS()
 E  D  I QUIT Q
 . S RCRANGE=$$DTRNG^RCDPEAPS()
 . I 'RCRANGE S QUIT=1 Q
 . S RCTYPE=$$RTYPE^RCDPEU1("A")
 . I RCTYPE=-1 S QUIT=1
 ;
 ; Prompt for device
 N %ZIS,ZTSK,ZTRTN,ZTIO,ZTDESC,ZTSAVE,POP
 S %ZIS="QM"
 D ^%ZIS
 I POP G ENQ
 I $D(IO("Q")) D  G ENQ
 . S ZTRTN="RUN^RCDPEWLE(RCERA,RCRANGE,RCTYPE)"
 . S ZTIO=ION
 . S ZTSAVE("*")=""
 . S ZTDESC="ERA STATUS CHANGE AUDIT REPORT"
 . D ^%ZTLOAD
 . W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 U IO
 ;
 D RUN(RCERA,RCRANGE,RCTYPE)
 ;
ENQ ;
 Q
 ;
RUN(RCERA,RCRANGE,RCTYPE) ;
 N DASH,EQL,RCD1,RCD2,RCDATE
 S DASH="",$P(DASH,"-",IOM+1)=""
 S EQL="",$P(EQL,"=",IOM+1)=""
 S RCDATE=$$FMTE^XLFDT($$DT^XLFDT(),"2Z")
 ;
 K ^TMP("RCDPEWLE",$J)
 ;
 S (RCD1,RCD2)=""
 I 'RCERA S RCD1=$$FMTE^XLFDT($P(RCRANGE,U,1),"2Z"),RCD2=$$FMTE^XLFDT($P(RCRANGE,U,2),"2Z")
 ; Compile Data
 D COMPILE
 ;
 ; Generate Report
 D REPORT
 ;
 K ^TMP("RCDPEAPS",$J)
 Q
 ;
COMPILE ; Compile report data
 N CNT,BDATE,EDATE,AUDDATE,IEN,CNT,DATA,RCDATE
 S CNT=0
 ;
 ; If RCERA is non-zero, then we are doing a single ERA
 I RCERA D  Q
 . D ONE(RCERA,.CNT)
 ;
 ; If RCERA is zero, then we are gathering data by date filed
 I 'RCERA D  Q
 . S BDATE=$P(RCRANGE,U,1)-.000001,EDATE=$P(RCRANGE,U,2)+.999999
 . S AUDDATE=BDATE F  S AUDDATE=$O(^RCY(344.4,"AFD",AUDDATE)) Q:'AUDDATE!(AUDDATE>EDATE)  D
 .. S IEN="" F  S IEN=$O(^RCY(344.4,"AFD",AUDDATE,IEN)) Q:'IEN  D
 ... I $$ISTYPE^RCDPEU1(344.4,IEN,RCTYPE) D ONE(IEN,.CNT)
 ;
 Q
REPORT ; Print Report
 N CNT,LINE,PAGE,RCSCR
 S (CNT,LINE,PAGE)=0
 S RCSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 D HDR1
 F  S CNT=$O(^TMP("RCDPEWLE",$J,CNT)) Q:'CNT  D  I PAGE=0 Q
 . I LINE=(IOSL-2) D  I PAGE=0 Q
 .. I RCSCR,'$$PAUSE^RCDPEAPS() S PAGE=0 Q
 .. D HDR1
 . W !,^TMP("RCDPEWLE",$J,CNT)
 . S LINE=LINE+1
 ;
 I PAGE>0,$$PAUSE^RCDPEAPS()
 Q
ONE(RCERA,CNT) ; Extract data for one ERA
 ; Input : RCERA - Internal entry number from file 344.4
 ; Output : Lines of Text in ^TMP("RCDPEWLE",$J,CNT)
 ;
 N J,RC,RCAUDIT,RCDIQ,RCSCR1,RCXM1
 S RC=0
 D GETS^DIQ(344.4,RCERA_",","*","IEN","RCDIQ")
 D TXT0^RCDPEX31(RCERA,.RCDIQ,.RCXM1,.RC) ; Get top level 0-node captioned flds
 ;
 I $O(^RCY(344.4,RCERA,2,0)) S RC=RC+1,RCXM1(RC)="  **ERA LEVEL ADJUSTMENTS**"
 S RCSCR1=0 F  S RCSCR1=$O(^RCY(344.4,RCERA,2,RCSCR1)) Q:'RCSCR1  D
 . K RCDIQ2
 . D GETS^DIQ(344.42,RCSCR1_","_RCERA_",","*","IEN","RCDIQ2")
 . D TXT2^RCDPEX31(RCERA,RCSCR1,.RCDIQ2,.RCXM1,.RC) ; Get top level ERA adjs
 ;
 F J=1:1:RC S CNT=CNT+1,^TMP("RCDPEWLE",$J,CNT)=RCXM1(J)
 ;
 D HDR2
 D GETAUD(RCERA,.RCAUDIT)
 S RC=0 F  S RC=$O(RCAUDIT(RC)) Q:'RC  D  ;
 . S CNT=CNT+1,^TMP("RCDPEWLE",$J,CNT)=RCAUDIT(RC)
 S CNT=CNT+2,^TMP("RCDPEWLE",$J,CNT-1)=EQL,^TMP("RCDPEWLE",$J,CNT)=""
 Q
HDR1 ; Print main header for report
 N HDR
 W @IOF
 S PAGE=PAGE+1
 S HDR="     ERA STATUS AND AUDIT INFORMATION"
 I RCD1="" D  ;
 . S HDR=HDR_$J("",17)_$J(RCDATE,8)
 E  D  ;
 . S HDR=HDR_$J("",8)_$$PAD(RCD1,8)_"-"_$$PAD(RCD2,8)
 S HDR=HDR_$J("",8)_"Page: "_PAGE
 W HDR
 W !,EQL
 S LINE=2
 Q
HDR2 ; Print header for audit trail
 N HDR
 S HDR="      Date/Time Edited       Status (Old/New)"_$J("",41)_"User"
 S CNT=CNT+1 S ^TMP("RCDPEWLE",$J,CNT)=HDR
 S HDR="      Reason Text"
 S CNT=CNT+1 S ^TMP("RCDPEWLE",$J,CNT)=HDR
 S CNT=CNT+1 S ^TMP("RCDPEWLE",$J,CNT)=DASH
 Q
