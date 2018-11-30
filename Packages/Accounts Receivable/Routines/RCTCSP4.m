RCTCSP4 ;ALB/ESG - CS Debt Referral Stop Reactivate Report ;6/1/2017
 ;;4.5;Accounts Receivable;**315,339**;Mar 20, 1995;Build 2
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; main report entry point
 ;
 N RCTCFLG,RCTCDEBT1,RCTCDEBT2,RCTCDATE,RCTCEXCEL
 ;
P1 I '$$FLAGGED(.RCTCFLG) G EX                ; currently flagged/reactivated/both
P2 I '$$DEBTFR(.RCTCDEBT1) G EX:$$STOP,P1     ; start with debtor
P3 I '$$DEBTTO(.RCTCDEBT2) G EX:$$STOP,P2     ; go to debtor
P4 I '$$DATES(.RCTCDATE) G EX:$$STOP,P3       ; all dates or a date range; from and thru dates
P5 I '$$FORMAT(.RCTCEXCEL) G EX:$$STOP,P4     ; output format (standard or Excel)
P6 I '$$DEVICE() G EX:$$STOP,P5               ; output device/queueing
 ;
EX ; main report exit point
 Q
 ;
STOP() ; Determine if user wants to exit out of the option entirely
 ; 1=yes, get out entirely
 ; 0=no, just go back to the previous question
 ;
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;
 S DIR(0)="Y"
 S DIR("A")="Do you want to exit out of this option entirely"
 S DIR("B")="YES"
 S DIR("?",1)="  Enter YES to immediately exit out of this option."
 S DIR("?")="  Enter NO to return to the previous question."
 W ! D ^DIR K DIR
 I $D(DIRUT) S Y=1
 Q Y
 ;
FLAGGED(RCTCFLG) ; capture if the user wants bills with a current flag, reactivated, or both
 ; RCTCFLG=C meaning data is currently present in the STOP TCSP REFERRAL FLAG field (430,157)
 ; RCTCFLG=R meaning data is currently blank in the STOP TCSP REFERRAL FLAG field (430,157)
 ; RCTCFLG=B meaning either is wanted
 ; pass parameter by reference
 ;
 N RET,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S RCTCFLG="",RET=1
 S DIR(0)="S"
 S $P(DIR(0),U,2)="C:Currently Flagged;R:Reactivated;B:Both"
 S DIR("A")="Run the Report for"
 S DIR("B")="B"
 S DIR("?",1)="Select 'Currently Flagged' to see bills which currently have the Cross-"
 S DIR("?",2)="Servicing activity stop flag set."
 S DIR("?",3)="Select 'Reactivated' to see bills in which the stop flag is not currently"
 S DIR("?",4)="set, but was once set in the past."
 S DIR("?")="Select 'Both' to see bills of both types."
 W ! D ^DIR K DIR
 I $D(DIRUT)!(Y="") S RET=0 W $C(7) G FLX
 S RCTCFLG=Y
FLX ;
 Q RET
 ;
DEBTFR(RCTCDEBT1) ; start with debtor
 N RET,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S RCTCDEBT1="",RET=1
 S DIR(0)="F^1:75"
 S DIR("A")="Start with Debtor"
 S DIR("B")="FIRST"
 S DIR("?",1)="If you want to specify a range of AR debtor names, enter the beginning"
 S DIR("?",2)="debtor name here. If you want to include all debtors, accept the default"
 S DIR("?")="value of FIRST here."
 W ! D ^DIR K DIR
 I $D(DIRUT)!(Y="") S RET=0 W $C(7) G DFX
 S RCTCDEBT1=Y
DFX ;
 Q RET
 ;
DEBTTO(RCTCDEBT2) ; go to debtor
 N RET,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
DBT1 S RCTCDEBT2="",RET=1
 S DIR(0)="F^1:75"
 S DIR("A")="     Go to Debtor"
 S DIR("B")="LAST"
 S DIR("?",1)="If you want to specify a range of AR debtor names, enter the ending debtor"
 S DIR("?",2)="name here. If you want to include all debtors, accept the default value of"
 S DIR("?")="LAST here."
 D ^DIR K DIR
 I $D(DIRUT)!(Y="") S RET=0 W $C(7) G DTX
 S RCTCDEBT2=Y
 I RCTCDEBT1'="FIRST",RCTCDEBT2'="LAST",RCTCDEBT1]RCTCDEBT2 W $C(7),!!,"You must enter something after '",RCTCDEBT1,"'!",! G DBT1
DTX ;
 Q RET
 ;
DATES(RCTCDATE) ; all dates or a date range - also capture from and thru dates
 ; RCTCDATE="A" or "R" if user wants All Dates or to select a Date Range
 ; RCTCDATE("BEGIN")=starting FM date
 ; RCTCDATE("END")=ending FM date
 ;
 N RET,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 K RCTCDATE
 S RET=1
 S DIR(0)="S^A:All Dates;R:Date Range"
 S DIR("A")="Include All Dates or Select by Date Range"
 S DIR("B")="Date Range"
 S DIR("?",1)="If you want to include all transaction entered dates, please select 'A' -"
 S DIR("?",2)="All Dates here.  But if you want to specify a date range for the"
 S DIR("?",3)="transaction entered dates, then enter 'R' here and then choose the from and"
 S DIR("?")="through dates."
 W ! D ^DIR K DIR
 I $D(DIRUT)!(Y="") S RET=0 W $C(7) G DATESX
 S RCTCDATE=Y
 I RCTCDATE="A" G DATESX
 ;
 S DIR(0)="DA^:DT:EX"
 S DIR("A")="Date Entered From: "
 S DIR("?",1)="The From and To dates for this report refer to the date that the AR"
 S DIR("?")="transaction was entered."
 W ! D ^DIR K DIR
 I $D(DIRUT)!'Y S RET=0 W $C(7) K RCTCDATE G DATESX
 S RCTCDATE("BEGIN")=Y
 ;
 S DIR(0)="DA^"_RCTCDATE("BEGIN")_":DT:EX"
 S DIR("A")="  Date Entered To: "
 S DIR("B")="T"
 S DIR("?",1)="The From and To dates for this report refer to the date that the AR"
 S DIR("?")="transaction was entered."
 D ^DIR K DIR
 I $D(DIRUT)!'Y S RET=0 W $C(7) K RCTCDATE G DATESX
 S RCTCDATE("END")=Y
DATESX ;
 Q RET
 ;
FORMAT(RCTCEXCEL) ; output format is Excel format or normal report output
 ; RCTCEXCEL=0 for normal report output
 ; RCTCEXCEL=1 for Excel output
 ; pass parameter by reference
 ;
 N RET,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S RCTCEXCEL=0,RET=1
 S DIR(0)="Y"
 S DIR("A")="Do you want to capture the output in Excel format"
 S DIR("B")="NO"
 S DIR("?",1)="If you want to capture the output from this report in a format which can"
 S DIR("?",2)="easily be imported into Excel, then answer YES here."
 S DIR("?",3)=" "
 S DIR("?")="If you just want a normal report output, then answer NO here."
 W ! D ^DIR K DIR
 I $D(DIRUT) S RET=0 W $C(7) G FMX
 S RCTCEXCEL=Y
FMX ;
 Q RET
 ;
DEVICE() ; Device Selection
 N ZTRTN,ZTDESC,ZTSAVE,POP,RET,ZTSK,DIR,X,Y
 S RET=1
 I 'RCTCEXCEL W !!,"This report is 132 characters wide.  Please choose an appropriate device.",!
 I RCTCEXCEL D
 . W !!,"For Excel output, turn logging or capture on now."
 . W !,"To avoid undesired wrapping of the data saved to the file,"
 . W !,"please enter ""0;256;99999"" at the ""DEVICE:"" prompt.",!
 ;
 S ZTRTN="COMPILE^RCTCSP4"
 S ZTDESC="RCTC AR Cross-Servicing Stop Reactivate Report"
 S ZTSAVE("RCTCFLG")=""
 S ZTSAVE("RCTCDEBT1")=""
 S ZTSAVE("RCTCDEBT2")=""
 S ZTSAVE("RCTCDATE")=""
 S ZTSAVE("RCTCDATE(")=""
 S ZTSAVE("RCTCEXCEL")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM",1)
 I POP S RET=0
 I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! S DIR(0)="E" D ^DIR K DIR
 Q RET
 ;
 ;
COMPILE ; entry point for the report compile to build the scratch global
 ; may be a background task if job queued
 ;
 K ^TMP("RCTCSP4",$J)             ; kill scratch at start
 I '$D(ZTQUEUED) W !!,"Compiling Cross-Servicing Stop Reactivate Report.  Please wait ... "
 ;
 D COMP                           ; build scratch global
 D PRINT                          ; print the report
 D ^%ZISC                         ; close the device
 K ^TMP("RCTCSP4",$J)             ; kill scratch global at end
 I $D(ZTQUEUED) S ZTREQ="@"       ; purge the task
COMIPLX ;
 Q
 ;
COMP ; compile data into scratch global
 N ARTTIEN,RCTCTT,RCTCDTENT,RC433,P0,RCIBN,USER,RCTTNAME,RC340,DEBTNAME,FLAG,RCDEBTOR,RCBILLNUM
 ;
 ; first identify the AR Transaction types eligible for this report (CS STOP PLACED or CS STOP DELETED)
 ; load into the RCTCTT local array
 S ARTTIEN=0 F  S ARTTIEN=$O(^PRCA(430.3,ARTTIEN)) Q:'ARTTIEN  I $P($G(^PRCA(430.3,ARTTIEN,0)),U,1)["CS STOP" S RCTCTT(ARTTIEN)=""
 ;
 ; if no end date specified then assume all dates are OK
 I '$G(RCTCDATE("END")) S RCTCDATE("END")=9999999
 ;
 ; start loop
 S ARTTIEN=0 F  S ARTTIEN=$O(RCTCTT(ARTTIEN)) Q:'ARTTIEN  D
 . ;
 . ; determine date to start looping based on if the user specified a start date or not
 . S RCTCDTENT=0
 . I $G(RCTCDATE("BEGIN")) S RCTCDTENT=$O(^PRCA(433,"AT",ARTTIEN,RCTCDATE("BEGIN")),-1)   ; get one day earlier to start
 . ;
 . F  S RCTCDTENT=$O(^PRCA(433,"AT",ARTTIEN,RCTCDTENT)) Q:'RCTCDTENT!(RCTCDTENT>RCTCDATE("END"))  D
 .. S RC433=0 F  S RC433=$O(^PRCA(433,"AT",ARTTIEN,RCTCDTENT,RC433)) Q:'RC433  D
 ... S P0=$G(^PRCA(433,RC433,0))
 ... S RCIBN=+$P(P0,U,2) Q:'RCIBN                 ; bill# ien
 ... S USER=$P($G(^VA(200,+$P(P0,U,9),0)),U,1)    ; processed by user
 ... S RCTTNAME=$$GET1^DIQ(433,RC433,12)          ; trans type name
 ... ;
 ... ; now get some bill data from 430
 ... S RC340=+$P($G(^PRCA(430,RCIBN,0)),U,9)      ; ar debtor ien
 ... Q:'RC340
 ... S DEBTNAME=$$GET1^DIQ(340,RC340,.01)         ; external ar debtor name
 ... Q:DEBTNAME=""
 ... ;
 ... ; check report filter on debtor name
 ... I RCTCDEBT1'="FIRST",RCTCDEBT1'=DEBTNAME,RCTCDEBT1]DEBTNAME Q    ; before name range
 ... I RCTCDEBT2'="LAST",RCTCDEBT2'=DEBTNAME,DEBTNAME]RCTCDEBT2 Q     ; after name range
 ... ;
 ... ; get the current flag value and check report filter
 ... S FLAG=+$P($G(^PRCA(430,RCIBN,15)),U,7)      ; stop tcsp referral flag field (430,157)  1:flag set
 ... I RCTCFLG="R",FLAG Q                         ; user wants only Reactivated bills and this one is still flagged
 ... I RCTCFLG="C",'FLAG Q                        ; user wants only currently flagged bills and this flag is clear
 ... ;
 ... S RCDEBTOR=DEBTNAME_U_RC340                  ; debtor name^debtor ien (used in subscript)
 ... S RCBILLNUM=$$GET1^DIQ(430,RCIBN,.01)        ; bill#
 ... Q:RCBILLNUM=""
 ... ;
 ... ; store data at the debtor level if not already there
 ... I '$D(^TMP("RCTCSP4",$J,RCDEBTOR)) D
 .... N RCDV,SSN,PTID
 .... S (SSN,PTID)=""
 .... S SSN=$$SSN^RCFN01(RC340)
 .... S PTID=$E(DEBTNAME,1)_$S(SSN'="":$E(SSN,6,9),1:"0000")            ; patient id
 .... S ^TMP("RCTCSP4",$J,RCDEBTOR)=PTID_U_DEBTNAME          ; save into scratch
 .... Q
 ... ;
 ... ; store data at the bill# level if not already there
 ... I '$D(^TMP("RCTCSP4",$J,RCDEBTOR,RCBILLNUM)) D
 .... N RCX,CAT
 .... S RCX=RCBILLNUM                                        ; bill#
 .... S $P(RCX,U,2)=$$GET1^DIQ(430,RCIBN,11)                 ; current balance
 .... S $P(RCX,U,3)=$$GET1^DIQ(430,RCIBN,8)                  ; current ar status name
 .... S $P(RCX,U,4)=$$GET1^DIQ(430,RCIBN,2)                  ; ar category name
 .... S $P(RCX,U,5)=$$GET1^DIQ(430,RCIBN,61,"I")             ; letter1 date FM format
 .... S $P(RCX,U,6)=$$GET1^DIQ(430,RCIBN,158,"I")            ; stop tcsp referral eff. date FM format
 .... S $P(RCX,U,7)=$$GET1^DIQ(430,RCIBN,159)                ; stop tcsp referral reason desc
 .... S CAT=+$P($G(^PRCA(430,RCIBN,0)),U,2)                  ; ar category ien
 .... S $P(RCX,U,8)=$$GET1^DIQ(430.2,CAT,1)                  ; ar category abbreviation
 .... S ^TMP("RCTCSP4",$J,RCDEBTOR,RCBILLNUM)=RCX
 ... ;
 ... ; now we can store the AR transaction data
 ... S ^TMP("RCTCSP4",$J,RCDEBTOR,RCBILLNUM,RC433)=RCTTNAME_U_RCTCDTENT_U_USER
 . Q
 ;
 ;
COMPX ;
 Q
 ;
 ;
PRINT ; entry point for printing the report
 N CRT,PAGE,RCTCSTOP,SEPLINE,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,RCD,DEBTDATA,BILL,BILLDATA,RC433,TRANDATA
 S CRT=$S(IOST["C-":1,1:0)
 I RCTCEXCEL S IOSL=999999        ; long screen length for Excel output
 S PAGE=0,RCTCSTOP=0,$P(SEPLINE,"-",133)=""
 ;
 I '$D(^TMP("RCTCSP4",$J)) D HDR W !!?5,"No data found for this report." G PX
 I $G(ZTSTOP) D HDR W !!?5,"This report was halted during compilation by TaskManager Request." G PX
 ;
 D HDR I RCTCSTOP G PX        ; display headers first for both types of output
 ;
 ; loop thru scratch, check for RCTCSTOP as we go
 S RCD="" F  S RCD=$O(^TMP("RCTCSP4",$J,RCD)) Q:RCD=""!RCTCSTOP  D
 . S DEBTDATA=$G(^TMP("RCTCSP4",$J,RCD))
 . S BILL="" F  S BILL=$O(^TMP("RCTCSP4",$J,RCD,BILL)) Q:BILL=""!RCTCSTOP  D
 .. S BILLDATA=$G(^TMP("RCTCSP4",$J,RCD,BILL))
 .. S RC433=0 F  S RC433=$O(^TMP("RCTCSP4",$J,RCD,BILL,RC433)) Q:'RC433!RCTCSTOP  D
 ... S TRANDATA=$G(^TMP("RCTCSP4",$J,RCD,BILL,RC433))
 ... D RPTLN
 ... Q
 .. Q
 . Q
 ;
 I RCTCSTOP G PRINTX       ; get out right away if stop flag is set
 ;
 I $Y+3>IOSL D HDR I RCTCSTOP G PRINTX
 W !!?5,"*** End of Report ***"
 ;
PX ;
 I CRT,'$D(ZTQUEUED) S DIR(0)="E" D ^DIR K DIR
PRINTX ;
 Q
 ;
RPTLN ; display one line on the report - either normal or Excel
 N TT
 ;
 ; for Excel output, print a line and get out
 I RCTCEXCEL D EXCELN G RPTLNX
 ;
 ; page break check
 I $Y+3>IOSL D HDR I RCTCSTOP G RPTLNX
 ;
 ; write a line of report data
 W !,$E($P(DEBTDATA,U,2),1,18)                               ; debtor name
 W ?20,$P(DEBTDATA,U,1)                                      ; Pt ID
 W ?27,$P($P(BILLDATA,U,1),"-",2)                            ; bill#
 W ?34,$$RJ^XLFSTR($FN($P(BILLDATA,U,2),"",2),10)            ; current balance
 W ?46,$E($P(BILLDATA,U,3),1,16)                             ; current status
 W ?64,$P(BILLDATA,U,8)                                      ; category abbr
 W ?68,$$FMTE^XLFDT($P(BILLDATA,U,5),"2Z")                   ; letter 1 date
 W ?78,$$FMTE^XLFDT($P(BILLDATA,U,6),"2Z")                   ; stop date
 W ?88,$E($P(BILLDATA,U,7),1,10)                             ; stop reason
 S TT=$P(TRANDATA,U,1)
 W ?100,$S(TT["DELETED":"DEL",TT["PLACED":"ADD",1:"UNK")     ; transaction type
 W ?105,$$FMTE^XLFDT($P(TRANDATA,U,2),"2Z")                  ; date entered
 W ?115,$E($P(TRANDATA,U,3),1,17)                            ; user
 ;
RPTLNX ;
 Q
 ;
HDR ; report header
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 ; Do an end of page reader call if page# exists and device is the screen
 I PAGE,CRT S DIR(0)="E" D ^DIR K DIR I 'Y S RCTCSTOP=1 G HDRX
 ;
 ; If screen output or page# exists, do a form feed
 I PAGE!CRT W @IOF
 ;
 ; First printer/file page - do a left margin reset
 I 'PAGE,'CRT W $C(13)
 ;
 S PAGE=PAGE+1    ; increment page#
 ;
 ; For Excel format, display the column headers only
 I RCTCEXCEL D EXCELHD G HDRX
 ;
 ; Display the report headers
 W "Debtor Range: "
 I RCTCDEBT1="FIRST",RCTCDEBT2="LAST" W "ALL"
 E  D
 . W $S(RCTCDEBT1="FIRST":"FIRST",1:($C(34)_$E(RCTCDEBT1,1,10)_$C(34)))," - "
 . W $S(RCTCDEBT2="LAST":"LAST",1:($C(34)_$E(RCTCDEBT2,1,10)_$C(34)))
 . Q
 ;
 W ?47,"Cross-Servicing Stop Reactivate Report",?122,"Page: ",PAGE
 ;
 W !?2,"Date Range: "
 I RCTCDATE="A" W "ALL"
 E  D
 . W $$FMTE^XLFDT($G(RCTCDATE("BEGIN")),"2Z")," - "
 . W $$FMTE^XLFDT($G(RCTCDATE("END")),"2Z")
 . Q
 ;
 W ?44,"Currently Flagged, Reactivated, or Both: "
 W $S(RCTCFLG="C":"Currently Flagged",RCTCFLG="R":"Reactivated",1:"Both")
 W ?111,$$FMTE^XLFDT($$NOW^XLFDT)
 ;
 W !,SEPLINE
 W !,"Debtor Name",?20,"Pt ID",?27,"Bill#",?37,"Balance",?46,"Status",?63,"Cat",?68,"Letter1",?78,"StopDate"
 W ?88,"Reason",?97,"CS STOP",?106,"Entered",?115,"User"
 W !,SEPLINE
 ;
 ; check for a TaskManager stop request
 I $D(ZTQUEUED),$$S^%ZTLOAD() D  G HDRX
 . S (ZTSTOP,RCTCSTOP)=1
 . W !!!?5,"*** Report Halted by TaskManager Request ***"
 . Q
 ;
HDRX ;
 Q
 ;
EXCELHD ; print an Excel header record (only 1 Excel header should print for the whole report)
 N RCH
 S RCH=$$CSV("","Debtor Name")
 S RCH=$$CSV(RCH,"Patient ID")
 S RCH=$$CSV(RCH,"Bill Number")
 S RCH=$$CSV(RCH,"Current Balance")
 S RCH=$$CSV(RCH,"Current Status")
 S RCH=$$CSV(RCH,"Category Name")
 S RCH=$$CSV(RCH,"Category Abbr")
 S RCH=$$CSV(RCH,"Letter1 Date")
 S RCH=$$CSV(RCH,"Stop Date")
 S RCH=$$CSV(RCH,"Stop Reason")
 S RCH=$$CSV(RCH,"Transaction Type")
 S RCH=$$CSV(RCH,"Transaction Date Entered")
 S RCH=$$CSV(RCH,"Transaction Processed By")
 W RCH
 Q
 ;
EXCELN ; write a line of Excel data
 N RCZ
 S RCZ=$$CSV("",$P(DEBTDATA,U,2))                         ; AR Debtor Name
 S RCZ=$$CSV(RCZ,$P(DEBTDATA,U,1))                        ; patient ID
 S RCZ=$$CSV(RCZ,$P(BILLDATA,U,1))                        ; bill#
 S RCZ=$$CSV(RCZ,+$P(BILLDATA,U,2))                       ; current balance
 S RCZ=$$CSV(RCZ,$P(BILLDATA,U,3))                        ; AR status name
 S RCZ=$$CSV(RCZ,$P(BILLDATA,U,4))                        ; AR category name
 S RCZ=$$CSV(RCZ,$P(BILLDATA,U,8))                        ; AR category abbr
 S RCZ=$$CSV(RCZ,$$FMTE^XLFDT($P(BILLDATA,U,5),"2Z"))     ; letter1 date
 S RCZ=$$CSV(RCZ,$$FMTE^XLFDT($P(BILLDATA,U,6),"2Z"))     ; stop flag effective date
 S RCZ=$$CSV(RCZ,$P(BILLDATA,U,7))                        ; stop flag reason
 S RCZ=$$CSV(RCZ,$P(TRANDATA,U,1))                        ; ar transaction type desc
 S RCZ=$$CSV(RCZ,$$FMTE^XLFDT($P(TRANDATA,U,2),"2Z"))     ; transaction date entered
 S RCZ=$$CSV(RCZ,$P(TRANDATA,U,3))                        ; trans user
 W !,RCZ
 Q
 ;
CSV(STRING,DATA) ; build the Excel data string format
 S STRING=$S(STRING="":DATA,1:STRING_U_DATA)
 Q STRING
 ;
