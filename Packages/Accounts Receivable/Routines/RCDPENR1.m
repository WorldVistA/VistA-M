RCDPENR1 ;ALB/SAB - EPay National Reports ;12/10/14
 ;;4.5;Accounts Receivable;**304,359**;Mar 20, 1995;Build 13
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRCA*4.5*359 Do not process Bill/Claim that is Cancelled
 ;             or does not have Provider pointer.
 ; 
 ;Read ^DGCR(399) via Private IA 3820
 ;Read ^IBA(364) via Private IA 6209
 ;Read ^IBA(364.1) via Private IA 6210
 ;Use DIV^IBJDF2 via Private IA 3130
 Q
 ;
 ; Entry point for manual run report (from VS option)
835837()  ;  835-837 summary report
 ;
 N RCBGDT,RCDISP,RCENDDT,RCPYRLST,RCDIV,RCRPT,RCRQDIV,RCSUMFLG,RCEX,RCPAYR
 ;
 ; Alert software to display to screen or not if Manually re-running the report.
 S RCDISP=1
 ;
 ; Ask for Division
 S RCRQDIV=$$GETDIV^RCDPENR2(.RCDIV)
 Q:RCRQDIV=-1
 ;
 S RCEX=$$GETPAY^RCDPENRU(.RCPAYR) Q:'RCEX
 S RCPYRLST("START")=$P($G(RCPAYR("START")),U,4),RCPYRLST("END")=$P($G(RCPAYR("END")),U,4)
 ;
 ; Ask the user for report type, with no Main Prompt
 S RCRPT=$$GETRPT^RCDPENR2(0)
 Q:RCRPT=-1
 ;
 S RCSUMFLG=$S(RCRPT="S":1,1:0)
 ;
 ; Retrieve start date
 S RCBGDT=$$GETSDATE^RCDPENR2()
 Q:RCBGDT=-1
 ;
 ; Retrieve end date.  Send user start date as the lower bound.
 S RCENDDT=$$GETEDATE^RCDPENR2(RCBGDT)
 Q:RCENDDT=-1
 D AUTO(RCDISP,RCBGDT,RCENDDT,.RCPYRLST,RCRQDIV,RCSUMFLG)
 Q
 ;
 ;Entry Point for automated calls
AUTO(RCDISP,RCBGDT,RCENDDT,RCPYRLST,RCRQDIV,RCSUMFLG) ;
 ; RCDISP - Display results to screen or archive file flag
 ; RCBGDT - begin date of the report
 ; RCENDDT - End date of the report
 ; RCPYRLST - Payers to report on (All, range, or single payer)
 ; RCRQDIV - Division to report on - (A)ll or a single division
 ; RCSUMFLG - (S)ummary or (G)rand Total Report
 ;
 ;Select output device
 I RCDISP S %ZIS="QM" D ^%ZIS Q:POP
 ;Option to queue
 I 'RCDISP,$D(IO("Q")) D  Q
 .N ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK
 .S ZTRTN="REPORT^RCDPENR1"
 .S ZTDESC="EDI Volume Statistics Report"
 .S ZTSAVE("RC*")=""
 .D ^%ZTLOAD
 .I $D(ZTSK) W !!,"Task number "_ZTSK_" has been queued."
 .E  W !!,"Unable to queue this job."
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 ;Compile and Print Report
 D REPORT
 Q
 ;
REPORT   ; Trace the ERA file for the given date range
 ;
 N RCPYRS,RCINS,RCDATA,RCDTLDT,RCDTLIEN,RCIEN,RCEOB,RCBILLNO,RCBATCH,RCTYPE,RCPHARM
 ;
 ; Clear temp arrays
 K ^TMP("RCDPEADP",$J),^TMP("RCDPENR1",$J),^TMP("RCDPENR2",$J)
 ;
 ; Compile list of divisions
 D DIV^RCDPENR2(.RCDIV)
 ;
 ; Compile the list of payers
 D PYRARY^RCDPENRU(RCPYRLST("START"),RCPYRLST("END"),2)  ; use 835 insurance file payer list
 ;
 ; Compile report
 ; Gather raw data
 D GET837(RCBGDT,RCENDDT,RCSUMFLG)
 D GETNCPDP(RCBGDT,RCENDDT,RCSUMFLG)
 D GET835(RCBGDT,RCENDDT,RCSUMFLG)
 ;
 ;Check for data captures
 I '$D(^TMP("RCDPENR1",$J)) D  Q
 .  W !!,"There was no data available for the requested report.  Please try again."
 ;
 ;Generate the statistics if any data captured
 D COMPILE(RCSUMFLG)
 ;
 ; Print out the results
 D PRINT(RCSUMFLG)
 ;
 Q 
 ;
 ;Generate the needed statistics for the report
COMPILE(RCSUMFLG) ;
 ;
 ; Temp Array Structure - ^TMP("RCDPENR1",$J,"CLAIM",RCMP,RCPAYER,RCCLAIM)=Send Date^Receive Date
 N RCMP,RCTOT,RCTDAYS,RCDATA,RCSDATE,RCEDATE,RCCLAIM,RCPAYER,RCDAYS,RCMCT,RCPCT,RCIDX,RCTYPE
 ;
 ; Generate Grand Totals
 S RCMP=""
 F  S RCMP=$O(^TMP("RCDPENR1",$J,"CLAIM",RCMP)) Q:RCMP=""  D
 . S RCPAYER=""
 . F  S RCPAYER=$O(^TMP("RCDPENR1",$J,"CLAIM",RCMP,RCPAYER)) Q:RCPAYER=""  D
 . . S RCCLAIM=""
 . . F  S RCCLAIM=$O(^TMP("RCDPENR1",$J,"CLAIM",RCMP,RCPAYER,RCCLAIM)) Q:RCCLAIM=""  D
 . . . S RCDATA=$G(^TMP("RCDPENR1",$J,"CLAIM",RCMP,RCPAYER,RCCLAIM))
 . . . Q:RCDATA=""
 . . . S RCSDATE=$P(RCDATA,U),RCEDATE=$P(RCDATA,U,2)
 . . . Q:(RCSDATE="")&(RCEDATE="")
 . . . I RCSDATE'="" D
 . . . . S ^TMP("RCDPENR1",$J,"RCTOT","837",RCMP,"G")=+$G(^TMP("RCDPENR1",$J,"RCTOT","837",RCMP,"G"))+1
 . . . . S:RCSUMFLG ^TMP("RCDPENR1",$J,"RCTOT","SUMMARY","837",RCMP,RCPAYER)=+$G(^TMP("RCDPENR1",$J,"RCTOT","SUMMARY","837",RCMP,RCPAYER))+1
 . . . ;
 . . . I RCEDATE'="" D
 . . . . S ^TMP("RCDPENR1",$J,"RCTOT","835",RCMP,"G")=+$G(^TMP("RCDPENR1",$J,"RCTOT","835",RCMP,"G"))+1
 . . . . S:RCSUMFLG ^TMP("RCDPENR1",$J,"RCTOT","SUMMARY","835",RCMP,RCPAYER)=+$G(^TMP("RCDPENR1",$J,"RCTOT","SUMMARY","835",RCMP,RCPAYER))+1
 . . . ;
 . . . I (RCSDATE'="")&(RCEDATE'="") D
 . . . . S RCDAYS=$$FMTH^XLFDT(RCEDATE,1)-$$FMTH^XLFDT(RCSDATE,1)
 . . . . ;
 . . . . ; update counters for grand total report
 . . . . S ^TMP("RCDPENR1",$J,"RCTDAYS","BOTH",RCMP,"G")=+$G(^TMP("RCDPENR1",$J,"RCTDAYS","BOTH",RCMP,"G"))+RCDAYS
 . . . . S ^TMP("RCDPENR1",$J,"RCTOT","BOTH",RCMP,"G")=+$G(^TMP("RCDPENR1",$J,"RCTOT","BOTH",RCMP,"G"))+1
 . . . . ;
 . . . . ; update counters for the payer summary totals, if requested
 . . . . I RCSUMFLG D
 . . . . . S ^TMP("RCDPENR1",$J,"RCTOT","SUMMARY","BOTH",RCMP,RCPAYER)=+$G(^TMP("RCDPENR1",$J,"RCTOT","SUMMARY","BOTH",RCMP,RCPAYER))+1
 . . . . . S ^TMP("RCDPENR1",$J,"RCTDAYS","SUMMARY","BOTH",RCMP,RCPAYER)=+$G(^TMP("RCDPENR1",$J,"RCTDAYS","SUMMARY","BOTH",RCMP,RCPAYER))+RCDAYS
 ;
 ;Calculate data for the report
 ;
 ;Get the grand total counts for the claims with both 837s and 835s
 S RCMCT=+$G(^TMP("RCDPENR1",$J,"RCTOT","BOTH","M","G"))
 S RCPCT=+$G(^TMP("RCDPENR1",$J,"RCTOT","BOTH","P","G"))
 ;
 ;Grand Totals
 S RCDATA=""
 S $P(RCDATA,U)=+$G(^TMP("RCDPENR1",$J,"RCTOT","837","M","G"))
 S $P(RCDATA,U,2)=+$G(^TMP("RCDPENR1",$J,"RCTOT","837","P","G"))
 S $P(RCDATA,U,3)=+$G(^TMP("RCDPENR1",$J,"RCTOT","835","M","G"))
 S $P(RCDATA,U,4)=+$G(^TMP("RCDPENR1",$J,"RCTOT","835","P","G"))
 S $P(RCDATA,U,5)=+$G(^TMP("RCDPENR1",$J,"RCTOT","BOTH","M","G"))
 S $P(RCDATA,U,6)=+$G(^TMP("RCDPENR1",$J,"RCTOT","BOTH","P","G"))
 S $P(RCDATA,U,7)=+$S(+RCMCT:+$G(^TMP("RCDPENR1",$J,"RCTDAYS","BOTH","M","G"))/+RCMCT,1:0)
 S $P(RCDATA,U,8)=+$S(+RCPCT:+$G(^TMP("RCDPENR1",$J,"RCTDAYS","BOTH","P","G"))/+RCPCT,1:0)
 S ^TMP("RCDPENR1",$J,"GTOT")=RCDATA
 ;
 ;quit if no Payer Summary
 Q:'RCSUMFLG
 ;
 ;Generate Payer level information.
 ;first the Totals
 S RCTYPE=""
 F  S RCTYPE=$O(^TMP("RCDPENR1",$J,"RCTOT","SUMMARY",RCTYPE)) Q:RCTYPE=""  D
 . S RCMP=""
 . F  S RCMP=$O(^TMP("RCDPENR1",$J,"RCTOT","SUMMARY",RCTYPE,RCMP))  Q:RCMP=""  D
 . . S RCPAYER=""
 . . F  S RCPAYER=$O(^TMP("RCDPENR1",$J,"RCTOT","SUMMARY",RCTYPE,RCMP,RCPAYER)) Q:RCPAYER=""  D
 . . . S RCIDX=$S(RCTYPE="837":1,RCTYPE="835":3,1:5)
 . . . S:RCMP="P" RCIDX=RCIDX+1
 . . . S $P(^TMP("RCDPENR1",$J,"SUMMARY",RCPAYER),U,RCIDX)=+$G(^TMP("RCDPENR1",$J,"RCTOT","SUMMARY",RCTYPE,RCMP,RCPAYER))
 ;
 ; Next, the total days count
 S RCMP=""
 F  S RCMP=$O(^TMP("RCDPENR1",$J,"RCTDAYS","SUMMARY","BOTH",RCMP))  Q:RCMP=""  D
 . S RCPAYER=""
 . F  S RCPAYER=$O(^TMP("RCDPENR1",$J,"RCTDAYS","SUMMARY","BOTH",RCMP,RCPAYER)) Q:RCPAYER=""  D
 . . S RCIDX=$S(RCMP="M":7,1:8)
 . . S $P(^TMP("RCDPENR1",$J,"SUMMARY",RCPAYER),U,RCIDX)=+$G(^TMP("RCDPENR1",$J,"RCTDAYS","SUMMARY","BOTH",RCMP,RCPAYER))
 ;
 Q
 ;
 ;Print the results.  Send via e-mail if not displaying to screen
PRINT(RCSUMFLG) ;Print the results
 ;
 N RCSTOP,RCPAGE,RCLINE,RCRUNDT,RCRPIEN,RCXMZ,RCTFLG,RCFLG
 ;
 S RCLINE="",$P(RCLINE,"-",IOM)="",RCTFLG=0,RCRPIEN="",RCFLG=0
 ;
 ; Init the stop flag, page count
 S RCSTOP=0,RCPAGE=0
 ;
 ; Set the Run date for the report
 S RCRUNDT=$$FMTE^XLFDT($$NOW^XLFDT,2)
 ;
 ; Open the device
 I RCDISP U IO
 ;
 I 'RCDISP D  Q:'RCRPIEN
 . S RCRPIEN=$$INITARCH("VOLUME STATISTICS")
 ;
 ; Display Header
 D HEADER
 ;
 ; Display the detail
 I RCSUMFLG S RCTFLG=1 S RCFLG=$$SUMMARY(RCTFLG)
 Q:RCFLG=-1
 ;
 ; Display the grand total at the end
 D GRAND(RCTFLG)
 ;
 ; If not displaying to screen and not redoing, send
 I 'RCDISP D
 . S RCXMZ=$$XM^RCDPENRU(RCRPIEN,RCBGDT,RCENDDT,"AR VOLUME STATISTICS REPORT")
 ;
 ;Report finished
 I 'RCSTOP D
 . I RCDISP,$Y>(IOSL-6) D ASK^RCDPEADP(.RCSTOP,0) Q:RCSTOP  D HEADER
 . I 'RCSTOP,RCDISP W !,$$ENDORPRT^RCDPEARL
 W !
 ;
 ;Close device
 I '$D(ZTQUEUED) D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
 Q
HEADER ;Print the results
 ;
 N RCDIVTXT,RCPYRTXT,RCSPACE,RCDATE,RCSTR
 ;
 S RCSPACE=""
 S $P(RCSPACE," ",80)=""
 S RCDIVTXT=$$DIVTXT()
 S RCPYRTXT=$$PAYERTXT(36)
 S RCDATE="DATE RANGE: "_$$FMTE^XLFDT(RCBGDT,2)_" - "_$$FMTE^XLFDT(RCENDDT,2)
 ;
RPTHDR ;
 S RCPAGE=RCPAGE+1
 I RCDISP D  Q
 . W @IOF,?15,"EDI VOLUME STATISTICS REPORT"
 . W ?70,"PAGE ",$J(RCPAGE,3),!
 . W ?5,RCDIVTXT,?41,RCPYRTXT,!
 . W ?5,RCDATE,?52,"RUN DATE: ",RCRUNDT,!
 . W RCLINE,!
 I 'RCDISP D
 . S RCSTR=RCDIVTXT_U_RCPYRTXT_U_RCDATE
 . D SAVEDATA(RCSTR,RCRPIEN)
 ;
 Q
 ;
 ;Determine the text to display for the division prompt
DIVTXT() ;
 ;
 N RCDIV,RCTXT
 ; 
 Q:$D(^TMP("RCDPENR2",$J,"DIVALL")) "ALL DIVISIONS"
 ;
 ;Build list of divisions
 ;
 S RCDIV="",RCTXT=""
 F  S RCDIV=$O(^TMP("RCDPENR2",$J,"DIV",RCDIV)) Q:RCDIV=""  D
 . S RCTXT=RCTXT_RCDIV_","
 ;
 ; Remove comma at the end. 
 S RCTXT=$E(RCTXT,1,$L(RCTXT)-1)
 ;
 ; Display the first 35 characters of the division text list,
 Q $E(RCTXT,1,35)
 ;
 ;Determine the text to display for the division prompt
PAYERTXT(RCFILE) ;
 ;
 N RCINS,RCTXT
 ;
 ;If all payers selected, return that message
 Q:$D(^TMP("RCDPEADP",$J,"INS","A")) "ALL PAYERS"
 ;
 ; Build the list of payers
 S RCINS="",RCTXT=""
 F  S RCINS=$O(^TMP("RCDPEADP",$J,"INS",RCINS)) Q:RCINS=""  D
 . S RCTXT=RCTXT_$$GET1^DIQ(RCFILE,RCINS_",",".01","E")_","
 ;
 ; Remove comma at the end. 
 S RCTXT=$E(RCTXT,1,$L(RCTXT)-1)
 ;
 ; Display the first 35 characters of the division text list,
 Q $E(RCTXT,1,35)
 ;
SUMMARY(RCTFLG) ;Print the Payer Summary portion of the report
 ;
 N RCINS,RCLPDATA,RC835,RC837,RCDTPCT,RCFLG
 ;
 S RCINS=0,RCFLG=1
 F  S RCINS=$O(^TMP("RCDPENR1",$J,"SUMMARY",RCINS)) Q:RCINS=""  D  Q:RCFLG=-1
 . S RCLPDATA=$G(^TMP("RCDPENR1",$J,"SUMMARY",RCINS))
 . S RCFLG=$$PRINTRP^RCDPENR4("PAYER NAME: "_RCINS,RCLPDATA,RCRPIEN,RCDISP,RCTFLG)
 Q RCFLG
 ;
 ;Total for all payers in report
GRAND(RCTFLG) ;
 ;
 N RCDATA,RCFLG
 ;
 S RCDATA=$G(^TMP("RCDPENR1",$J,"GTOT"))
 S RCFLG=$$PRINTRP^RCDPENR4("GRAND TOTAL ALL PAYERS",RCDATA,RCRPIEN,RCDISP,RCTFLG)
 Q
 ; 
 ; Retrieve the needed 835 information.
GET835(RCSDATE,RCEDATE,RCSUMFLG) ;
 ;
 N RCLDATE,RCBDIV,RCIEN,RCDATA,RCLIEN,RCDTLDT,RCEOB,RCBILL,RCMP
 ;
 S RCLDATE=RCSDATE-.001
 ;
 F  S RCLDATE=$O(^RCY(344.4,"AFD",RCLDATE)) Q:RCLDATE>RCEDATE  Q:RCLDATE=""  D
 . S RCIEN=""
 . F  S RCIEN=$O(^RCY(344.4,"AFD",RCLDATE,RCIEN)) Q:'RCIEN  D  Q
 .. S RCDATA=$G(^RCY(344.4,RCIEN,0))
 .. Q:RCDATA=""         ;No data defined in the transaction
 .. Q:'$P(RCDATA,U,10)  ;Transaction is an MRA
 .. S RCLIEN=0
 .. F  S RCLIEN=$O(^RCY(344.4,RCIEN,1,RCLIEN)) Q:RCLIEN=""  D  Q
 ... S RCDTLDT=$G(^RCY(344.4,RCIEN,1,RCLIEN,0))   ;Get the ERA Detail
 ... Q:RCDTLDT=""             ;Quit if no ERA Detail
 ... S RCEOB=$P(RCDTLDT,U,2)  ;Get the EOB info
 ... Q:'RCEOB                 ;quit if no info
 ... ;
 ... ; Get the BILL/CLAIM IEN from the #399 file
 ... S RCBILL=$$BILLIEN(RCEOB)
 ... Q:RCBILL=""    ;EEOB corrupted, quit
 ... ;
 ... ;Get the insurance companY
 ... S RCINS=$$GET1^DIQ(361.1,RCEOB_",",.02,"I")  ;Get the insurance company ID.
 ... S RCPAYER=$$GET1^DIQ(361.1,RCEOB_",",.02,"E")  ;Get the insurance company ID.
 ... Q:RCPAYER=""
 ... ;
 ... ; If payer not in list, then exit.
 ... Q:'$$INSCHK^RCDPENRU(RCINS)
 ... ;
 ... ; Get the division
 ... S RCBDIV=$$DIV^IBJDF2(RCBILL)
 ... ;
 ... ; Quit if user specified a specific division and bill is not in that Division
 ... I '$D(^TMP("RCDPENR2",$J,"DIVALL"))&'$D(^TMP("RCDPENR2",$J,"DIV",RCBDIV)) Q 
 ... ;
 ... ; Check to see if it is an ERA for a pharmacy claim or a medical claim
 ... S RCMP=$S($$PHARM^RCDPEWLP(RCIEN):"P",1:"M")
 ... ;
 ... D UPDTMP8(RCLDATE,RCMP,RCBILL,RCSUMFLG,RCPAYER,RCEOB)
 Q
 ;
BILLIEN(RCEOB)  ; Retrieve the IEN for the Bill attached to the EOB
 ; To find the external Bill number, please use GETBILL^RCDPESR0
 ;
 Q $$GET1^DIQ(361.1,RCEOB_",",.01,"I")
 ;
 ;Retrieve all necessary information for the 837s sent during the requested period by
 ;using the 837 Transmission batches.
GET837(RCSDATE,RCEDATE,RCSUMFLG) ;
 ;RCSDATE - Start date of extraction
 ;RCEDATE - End date of extraction
 ;RCSUMFLG - Type of report (Payer Summary or Grand Total)
 ;
 N RCBATCH,RCLDATE,RCPAYER,RCIEN,RCDATA,RCBILL,RCBDIV,RCINS
 ;
 ;Get the 837 batches sent within the given date range.
 S RCLDATE=RCSDATE-.001
 ;
 F  S RCLDATE=$O(^IBA(364.1,"FDATE",RCLDATE)) Q:RCLDATE=""  Q:RCLDATE>RCEDATE  D
 . S RCBATCH=0
 . F  S RCBATCH=$O(^IBA(364.1,"FDATE",RCLDATE,RCBATCH)) Q:RCBATCH=""  D
 .. S RCINS=$$GET1^DIQ(364.1,RCBATCH_",",.12,"I")
 .. S RCPAYER=$$GET1^DIQ(364.1,RCBATCH_",",.12,"E")
 .. Q:RCPAYER=""
 .. ;
 .. ;If payer not in list, then exit.
 .. Q:'$$INSCHK^RCDPENRU(RCINS)
 .. ;
 .. S RCIEN=0
 .. F  S RCIEN=$O(^IBA(364,"C",RCBATCH,RCIEN)) Q:RCIEN=""  D
 ... S RCDATA=$G(^IBA(364,RCIEN,0))
 ... S RCBILL=$P(RCDATA,U)    ; Get the Bill #
 ... Q:RCBILL=""  ; Corrupted batch information, don't count toward totals.
 ... S RCBDIV=$$DIV^IBJDF2(RCBILL)
 ... ;
 ... ; Quit if user specified a specific division and bill is not in that Division
 ... I '$D(^TMP("RCDPENR2",$J,"DIVALL"))&'$D(^TMP("RCDPENR2",$J,"DIV",RCBDIV)) Q 
 ... D UPDTMPB(RCLDATE,1,"M",RCBILL,RCSUMFLG,RCPAYER)
 ;
 ;Exit
 Q
 ;
 ;Update the Temporary array with the Billing information.
UPDTMPB(RCSEND,RCTOTFLG,RCMP,RCCLAIM,RCSUMFLG,RCPAYER) ;
 ; RCSEND   - Date 837 or NCPDP sent from site.
 ; RCTOTFLG - Add to the total count or not (1 yes, 837 sent this period, 0 if 837 sent in prior period
 ; RCMP     - Is this a (P)harmacy or (M)edical
 ; RCCLAIM  - The IEN for the Bill/Claim
 ; RCSUMFLG - If this flag is 1, add payer level entry for the Payer Summary report, otherwise send 0 for Grand Total only
 ; RCPAYER  - Payer for the claim (if generating a Payer Summary Report
 ;
 ;If the flag is 1, update the totals counter
 S:RCTOTFLG ^TMP("RCDPENR1",$J,"TOTAL",RCMP)=$P($G(^TMP("RCDPENR1",$J,"TOTAL",RCMP)),U)+1
 ;
 ;Add the claim to the list with its send date.
 S ^TMP("RCDPENR1",$J,"CLAIM",RCMP,RCPAYER,RCCLAIM)=RCSEND
 ;
 ;Add a payer level summation if producing a Payer Summary version of the report
 S:(RCTOTFLG)&(RCSUMFLG) $P(^TMP("RCDPENR1",$J,"TOTAL",RCMP,RCPAYER),U)=$P($G(^TMP("RCDPENR1",$J,"TOTAL",RCMP,RCPAYER)),U)+1
 ;
 Q
 ;
 ;Update the Temporary array with the 835 information.
UPDTMP8(RCRCVD,RCMP,RCCLAIM,RCSUMFLG,RCPAYER,RCEOB) ;
 ; RCRCVD   - Date 835 is received.
 ; RCMP     - Is this a (P)harmacy or (M)edical
 ; RCCLAIM  - The IEN for the Bill/Claim
 ; RCSUMFLG - If this flag is 1, add payer level entry for the Payer Summary report, otherwise send 0 for Grand Total only
 ; RCPAYER  - Payer for the claim (if generating a Payer Summary Report
 ; RCEOB    - EOB IEN for the 361.1 file.
 ;
 N RCSEND,RCBATCH
 ;
 ;If the flag is 1, update the totals counter
 S ^TMP("RCDPENR1",$J,"TOTAL","835")=$G(^TMP("RCDPENR1",$J,"TOTAL","835"))+1
 ;
 ;If the claim/bill associated with the 835 isn't currently in temp array
 ; add it but don't update the count.
 I '$D(^TMP("RCDPENR1",$J,"CLAIM",RCMP,RCPAYER,RCCLAIM)) D
 . S RCBATCH=$$GET1^DIQ(361.1,RCEOB_",",100.02,"I")
 . Q:RCBATCH=""
 . S RCSEND=$$GET1^DIQ(364.1,RCBATCH_",",1.01,"I")
 . D:RCSEND'="" UPDTMPB(RCSEND,0,RCMP,RCCLAIM,RCSUMFLG,RCPAYER)
 ;
 ;Add the claim to the list with its send date.
 S $P(^TMP("RCDPENR1",$J,"CLAIM",RCMP,RCPAYER,RCCLAIM),U,2)=RCRCVD
 ;
 ;Add a payer level summation if producing a Payer Summary version of the report
 S:RCSUMFLG $P(^TMP("RCDPENR1",$J,"TOTAL",RCMP,RCPAYER),U)=$P($G(^TMP("RCDPENR1",$J,"TOTAL",RCMP,RCPAYER)),U)+1
 ;
 Q
 ;
 ; Retrieve the Pharmacy (NCPDP data) needed for the report
GETNCPDP(RCSDATE,RCEDATE,RCSUMFLG) ;
 ;
 N RCLDATE,RCIEN,RCBILL,RCPAYER,RCFLAG,RCINS
 ;
 ; Loop through all of the bills received during the requested period.
 S RCLDATE=RCSDATE-.001
 ;
 F  S RCLDATE=$O(^DGCR(399,"APD",RCLDATE)) Q:'RCLDATE  Q:RCLDATE>RCEDATE  D
 . S RCIEN=0
 . F  S RCIEN=$O(^DGCR(399,"APD",RCLDATE,RCIEN)) Q:'RCIEN  D
 . . S RCFLAG=$$GETECME(RCIEN)
 . . Q:RCFLAG=""    ; No ECME number so not a Pharmacy bill
 . . S RCPAYER=$$GET1^DIQ(399,RCIEN_",",101,"E") I $P(^DGCR(399,RCIEN,0),U,13)=7!'RCPAYER Q   ;PRCA*4.5*359
 . . S RCINS=$$GET1^DIQ(399,RCIEN_",",101,"I")
 . . Q:'$$INSCHK^RCDPENRU(RCINS)       ;Dont add if not on approved insurance list
 . . D UPDTMPB(RCLDATE,1,"P",RCIEN,RCSUMFLG,RCPAYER)
 ;
 ;Exit
 Q
 ;
 ; Get the ECME# from the bill
GETECME(RCIEN) ;
 ; Used by:
 ;     Routine RCDPENR1
 ;     Routine PRCABJ1
 Q $$GET1^DIQ(399,RCIEN_",",460,"E")
 ;
 ;Save a line of data to the Archive file
SAVEDATA(RCDATA,IEN) ;
 ;
 N RCARY,IENS
 ;
 S IENS="+1,"_IEN_","
 S RCARY(344.911,IENS,.01)=RCDATA
 D UPDATE^DIE(,"RCARY")
 ;
 Q
 ;
 ;Initialize the Archive file entry
INITARCH(RPT) ;
 ;
 N FDA,FDAIEN,DT,DT1
 ;
 S DT=$$NOW^XLFDT
 S DT1=$E(DT,1,5)_"00"
 ;
 ; set up array
 S FDA(344.91,"+1,",.01)=RPT           ;Name of report
 S FDA(344.91,"+1,",.02)=DT1    ;Month/year report run
 S FDA(344.91,"+1,",.03)=1             ;Status
 S FDA(344.91,"+1,",.04)=DT            ;Start date of report
 ;
 ;file entry
 D UPDATE^DIE(,"FDA","FDAIEN")
 ;
 Q +$G(FDAIEN(1))
 ;
 ;Entry point for reprinting the header.
REPRINT(RCHDR,RCDATA) ;
 ;
 N RCDIVTXT,RCPYRTXT,RCSPACE,RCDATE,RCSTR,RCRUNDT,RCLINE,RCFLG
 S RCLINE="",$P(RCLINE,"-",IOM)=""
 ;
 ; Store the header into the correct variables
 S RCSPACE=""
 S $P(RCSPACE," ",80)=""
 S RCDIVTXT=$P(RCHDR,U)
 S RCPYRTXT=$P(RCHDR,U,2)
 S RCDATE=$P(RCHDR,U,3)
 S RCRUNDT=$$FMTE^XLFDT($$NOW^XLFDT,2)
 ;
 ; Call the Header Print routine
 D RPTHDR
 ;
 ; Reprint the body
 S RCFLG=$$PRINTRP^RCDPENR4("GRAND TOTAL ALL PAYERS",RCDATA,RCDISP)
 ;
 Q
