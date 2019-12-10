RCTCSP4 ;HAF/ASF - CS Debt Referral Stop Reactivate Report ;6/1/2017
 ;;4.5;Accounts Receivable;**315,339,350**;Mar 25, 2019;Build 66
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; main report entry point
 ;
 N BILLDATA,CRT,DEBRANGE,DEBTDATA,DEBTOR,DIC,DIV1,DLEVEL,DV,G,IENS,N1,NN,PTID,RCDT,RCTC,RCTCDATE
 N RCTCDB,RCTCDEBT1,RCTCDEBT2,RCTCDIV,RCTCDIVN,RCTCEXCEL,RCTCFLG,RCTCSP4,RCTCSTOP,RTCN,REASON,RCTN,SEPLINE,SR,SRDT,SSN,TRANDATA,USER,XDATE
 ;
 D FLAGGED(.RCTCFLG) Q:RCTCFLG=""
 D DEBBILL Q:RCTCDB=""
 I RCTCDB="D" D DLEVEL^RCTCSP4E Q
 D DEBTORS Q:$D(DIRUT)
 D DATES Q:'$D(RCTCDATE)!$D(DIRUT)
 S RCTCDIV="" I RCTCDB="B" D DIVSEL Q:RCTCDIV=""
 D FORMAT Q:RCTCEXCEL=""
 D DEVICE
 D COMP
 K ^TMP("RCTCSP4",$J)             ; kill scratch global at end
 D ^%ZISC                         ; close the device
 Q
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
 N RET,DIR,X,Y
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
DEBBILL ;
 ; RCTCDB=C meaning data is currently present in the STOP TCSP REFERRAL FLAG field (430,157)
 ; RCTCDB=R meaning data is currently blank in the STOP TCSP REFERRAL FLAG field (430,157)
 ;
 N RET,DIR,X,Y
 S RCTCDB="",RET=1
 S DIR(0)="S"
 S $P(DIR(0),U,2)="B:Bill Level;D:Debtor Level;"
 S DIR("A")="Run the Report for"
 S DIR("B")="Debtor"
 S DIR("?")="Select 'Bills' to see selected bills"
 S DIR("?",1)="Select 'Debtors' to see selected debtors"
 W ! D ^DIR K DIR
 I $D(DIRUT)!(Y="") S RET=0 W $C(7) Q
 S RCTCDB=Y
 Q
DIVSEL ;
 N RET,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,DIC
 S RCTCDIV="",RET=1
 K RCTC("DIVS")
 S DIR(0)="S"
 S $P(DIR(0),U,2)="A:All;D:Division"
 S DIR("A")="Run the Report for"
 S DIR("B")="All"
 S DIR("?")="Select 'All' to see all bills, Select Division to see only bills from a single division."
 W ! D ^DIR K DIR
 I $D(DIRUT)!(Y="") S RET=0 W $C(7) G FLX
 S RCTCDIV=Y
 Q:RCTCDIV="A"
 S DIC=40.8,DIC(0)="AEQZ" F  D ^DIC Q:Y'>0  S RCTC("DIVS",$P(Y(0),U,7))="",RCTC("DIVN",$P(Y(0),U))=$P(Y(0),U,2) ;ASF 5/6/19
 Q
 ;
DEBTORS ; select debtor range
DEBTFR ; start with debtor
 N RET,DIR,X,Y
 S RCTCDEBT1="",RET=1
 S DIR(0)="F^1:50"
 S DIR("A")="Start with Debtor"
 S DIR("B")="FIRST"
 S DIR("?",1)="If you want to specify a range of AR debtor names, enter the beginning"
 S DIR("?",2)="debtor name here. If you want to include all debtors, accept the default"
 S DIR("?")="value of FIRST here."
 W ! D ^DIR K DIR
 I $D(DIRUT)!(Y="") S RET=0 W $C(7) Q
 S RCTCDEBT1=Y
 ;
DEBTTO ; go to debtor
 N RET,DIR,X,Y
DBT1 S RCTCDEBT2="",RET=1
 S DIR(0)="F^1:50"
 S DIR("A")="     Go to Debtor"
 S DIR("B")="LAST"
 S DIR("?",1)="If you want to specify a range of AR debtor names, enter the ending debtor"
 S DIR("?",2)="name here. If you want to include all debtors, accept the default value of"
 S DIR("?")="LAST here."
 D ^DIR K DIR
 I $D(DIRUT)!(Y="") S RET=0 W $C(7) Q
 S RCTCDEBT2=Y
 I RCTCDEBT1'="FIRST",RCTCDEBT2'="LAST",RCTCDEBT1]RCTCDEBT2 W $C(7),!!,"You must enter something after '",RCTCDEBT1,"'!",! G DBT1
 Q
 ;
DATES ; all dates or a date range - also capture from and thru dates
 ; RCTCDATE="A" or "R" if user wants All Dates or to select a Date Range
 ; RCTCDATE("BEGIN")=starting FM date
 ; RCTCDATE("END")=ending FM date
 ;
 N RET,DIR,X,Y
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
 I $D(DIRUT)!(Y="") S ZZRET=0 W $C(7) Q
 S RCTCDATE=Y
 I RCTCDATE="A" S RCTCDATE("END")=DT_.9,RCTCDATE("BEGIN")=2840101 Q
 ;
 S DIR(0)="DA^:DT:EX"
 S DIR("A")="Date Entered From: "
 S DIR("?",1)="The From and To dates for this report refer to the date that the AR"
 S DIR("?")="transaction was entered."
 W ! D ^DIR K DIR
 I $D(DIRUT)!'Y S RET=0 W $C(7) K RCTCDATE Q
 S RCTCDATE("BEGIN")=Y
 ;
 S DIR(0)="DA^"_RCTCDATE("BEGIN")_":DT:EX"
 S DIR("A")="  Date Entered To: "
 S DIR("B")="T"
 S DIR("?",1)="The From and To dates for this report refer to the date that the AR"
 S DIR("?")="transaction was entered."
 D ^DIR K DIR
 I $D(DIRUT)!'Y S RET=0 W $C(7) K RCTCDATE Q
 S RCTCDATE("END")=Y
 Q
 ;
FORMAT ; output format is Excel format or normal report output
 ; RCTCEXCEL=0 for normal report output
 ; RCTCEXCEL=1 for Excel output
 ; pass parameter by reference
 ;
 N RET,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S RCTCEXCEL="",RET=1
 S DIR(0)="Y"
 S DIR("A")="Do you want to capture the output in Excel format"
 S DIR("B")="NO"
 S DIR("?",1)="If you want to capture the output from this report in a format which can"
 S DIR("?",2)="easily be imported into Excel, then answer YES here."
 S DIR("?",3)=" "
 S DIR("?")="If you just want a normal report output, then answer NO here."
 W ! D ^DIR K DIR
 I $D(DIRUT) S RET=0 W $C(7) Q
 S RCTCEXCEL=Y
 Q
 ;
DEVICE() ; Device Selection
 N ZTRTN,ZTDESC,ZTSAVE,POP,RET,ZTSK,DIR,X,Y
 S RET=1
 I 'RCTCEXCEL W !!,"It is recommended that you Queue this report to a device ",!,"that is 132 characters wide",!
 I RCTCEXCEL D
 . W !!,"To capture as an Excel format, it is recommended that you queue this report to"
 . W !,"a spool device with margins of 256 and page length of 99999,"
 . W !,"(e.g. spoolname;256;99999).This should help avoid wrapping problems.",!
 . W !,"Another method would be to set up your terminal to capture the detail report"
 . W !,"data. On some terminals, this can be done by clicking on the 'Tools' menu above,"
 . W !,"then click on 'Capture Incoming Data' to save to Desktop."
 . W !,"To avoid undesired wrapping of the data saved to the file,"
 . W !,"please enter '0;256;99999' at the 'DEVICE:' prompt."
 ;
 S ZTRTN="COMPILE^RCTCSP4"
 S ZTDESC="RCTC AR Cross-Servicing Stop Reactivate Report"
 S ZTSAVE("RCTC(")=""
 S ZTSAVE("RCTCDB")=""
 S ZTSAVE("RCTCDIV")=""
 S ZTSAVE("RCTCFLG")=""
 S ZTSAVE("RCTCDEBT1")=""
 S ZTSAVE("RCTCDEBT2")=""
 S ZTSAVE("RCTCDATE")=""
 S ZTSAVE("RCTCDATE(")=""
 S ZTSAVE("RCTCEXCEL")=""
 S ZTSAVE("DEBRANGE")=""
 S ZTSAVE("DLEVEL")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM",1)
 I POP S RET=0
 I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! S DIR(0)="E" D ^DIR K DIR
 Q RET
 ;
 ;
COMPILE ; entry point for the report compile to build the scratch global
 ; may be a background task if job queued
 ;
 I '$D(ZTQUEUED) W !!,"Compiling Cross-Servicing Stop Reactivate Report.  Please wait ... "
 ;
 D COMP                           ; build scratch global
 D PRINT                          ; print the report
 D ^%ZISC                         ; close the device
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
 ... ; now get some bill data from 430
 ... S RC340=+$P($G(^PRCA(430,RCIBN,0)),U,9)      ; ar debtor ien
 ... Q:'RC340
 ... Q:^RCD(340,RC340,0)'?.N1";DPT".E             ; only patients
 ... S DEBTNAME=$$GET1^DIQ(340,RC340,.01)         ; external ar debtor name
 ... Q:DEBTNAME=""
 ... ;
 ... ; check report filter on debtor name  ASF
 ... ;I RCTCDB'="B",'$D(RCTCSP4("DEBTOR",DEBTNAME)) Q
 ... I RCTCDEBT1'="FIRST",RCTCDEBT1'=DEBTNAME,RCTCDEBT1]DEBTNAME Q    ; before name range
 ... I RCTCDEBT2'="LAST",RCTCDEBT2'=DEBTNAME,DEBTNAME]RCTCDEBT2 Q     ; after name range
 ... ;
 ... ; Division filter
 ... S RCTCDIVN=$$GET1^DIQ(430,RCIBN_",",12,"I")
 ... I RCTCDIV="D",RCTCDIVN="" Q
 ... I RCTCDIV="D",'$D(RCTC("DIVS",RCTCDIVN)) Q
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
 .... S ^TMP("RCTCSP4",$J,RCDEBTOR)=PTID_U_DEBTNAME_U_$S(SSN?.E9N.E:SSN,1:"")          ; save into scratch
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
 .... S $P(RCX,U,9)=$$GET1^DIQ(430,RCIBN,12,"I")             ;site
 .... S ^TMP("RCTCSP4",$J,RCDEBTOR,RCBILLNUM)=RCX
 ... ;
 ... ; now we can store the AR transaction data
 ... S ^TMP("RCTCSP4",$J,RCDEBTOR,RCBILLNUM,RC433)=RCTTNAME_U_RCTCDTENT_U_USER
 . Q
 Q
 ;
 ;
PRINT ; entry point for printing the report
 N CRT,PAGE,RCTCSTOP,SEPLINE,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,RCD,DEBTDATA,BILL,BILLDATA,RC433,TRANDATA
 S CRT=$S(IOST["C-":1,1:0)
 I RCTCEXCEL S IOSL=999999        ; long screen length for Excel output
 S PAGE=0,RCTCSTOP=0,$P(SEPLINE,"-",133)=""
 ;
 I '$D(^TMP("RCTCSP4",$J)) D HDR^RCTCSP4E W !!?5,"No data found for this report." Q
 I $G(ZTSTOP) D HDR^RCTCSP4E W !!?5,"This report was halted during compilation by TaskManager Request." D PX
 D HDR^RCTCSP4E I RCTCSTOP D PX ; display headers first for both types of output
 ;
 ; loop thru scratch, check for RCTCSTOP as we go
 ;
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
 I RCTCSTOP Q  ; get out right away if stop flag is set
 ;
 I $Y+3>IOSL D HDR^RCTCSP4E I RCTCSTOP Q
 W !!?5,"*** End of Report ***"
 ;
PX ;
 I CRT,'$D(ZTQUEUED) S DIR(0)="E" D ^DIR
PRINTX ;
 Q
 ;
 I $Y+3>IOSL D HDR^RCTCSP4E I RCTCSTOP D PRINTX
 W !!?5,"*** End of Report ***"
 Q
 ;
RPTLN ; display one line on the report - either normal or Excel
 N TT
 ;
 ; for Excel output, print a line and get out
 I RCTCEXCEL D EXCELN^RCTCSP4E Q
 ;
 ; page break check
 I $Y+3>IOSL D HDR^RCTCSP4E I RCTCSTOP G RPTLNX
 ;
 ; write a line of report data
 W !,$E($P(DEBTDATA,U,2),1,27)                               ; debtor name
 W ?28,$P(BILLDATA,U,9),"  "                                 ;division
 W ?34,$P(DEBTDATA,U,1)                                      ; Pt ID
 ;W ?38,$P(DEBTDATA,U,3)                                     ;SSN 
 W ?41,$P(BILLDATA,U,1)                                      ; bill#
 ;W ?34,$$RJ^XLFSTR($FN($P(BILLDATA,U,2),"",2),10)           ; current balance
 W ?54,$E($P(BILLDATA,U,3),1,12)                             ; current status
 ;W ?64,$P(BILLDATA,U,8)                                     ; category abbr
 W ?67,$$FMTE^XLFDT($P(BILLDATA,U,5),"2Z")                   ; letter 1 date
 W ?77,$$FMTE^XLFDT($P(BILLDATA,U,6),"2Z")                   ; stop date
 W ?86,$E($P(BILLDATA,U,7),1,10)                             ; stop reason
 S TT=$P(TRANDATA,U,1)
 W ?100,$S(TT["DELETED":"DEL",TT["PLACED":"ADD",1:"UNK")     ; transaction type
 ;W ?105,$$FMTE^XLFDT($P(TRANDATA,U,2),"2Z")                 ; date entered
 W ?105,$E($P(TRANDATA,U,3),1,17)                            ; user
 Q
RPTLNDIV ;Lines for division
 N TT
 ;
 ; for Excel output, print a line and get out
 I RCTCEXCEL D EXCELN^RCTCSP4E Q
 ;
 ; page break check
 I $Y+3>IOSL D HDR^RCTCSP4E I RCTCSTOP G RPTLNX
 ;
 ; write a line of report data
 W !,$P(DEBTDATA,U,2)                                        ; debtor name
 W ?32,$P(BILLDATA,U,9),"  "                                  ;division
 W ?37,$P(DEBTDATA,U,1)                                      ; Pt ID
 W ?46,$P($P(BILLDATA,U,1),"-",2)                           ; bill#
 W ?55,$P(BILLDATA,U,8)                                      ; category abbr
 W ?59,$$FMTE^XLFDT($P(BILLDATA,U,5),"2Z")                   ; letter 1 date
 W ?69,$$FMTE^XLFDT($P(BILLDATA,U,6),"2Z")                   ; stop date
 W ?79,$E($P(BILLDATA,U,7),1,10)                             ; stop reason
 S TT=$P(TRANDATA,U,1)
 W ?91,$S(TT["DELETED":"DEL",TT["PLACED":"ADD",1:"UNK")     ; transaction type
 W ?99,$$FMTE^XLFDT($P(TRANDATA,U,2),"2Z")                  ; date entered
 W ?109,$E($P(TRANDATA,U,3),1,17)                            ; user
 ;
RPTLNX ;X
 Q
