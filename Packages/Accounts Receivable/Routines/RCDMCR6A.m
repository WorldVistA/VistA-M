RCDMCR6A ;ALB/YG - 50-100 Percent SC Exempt Charge Reconciliation Report - Input/output; Apr 9, 2019@21:06
 ;;4.5;Accounts Receivable;**347,386**;Mar 20, 1995;Build 6
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;This routine is being implemented for the AR Cross-Servicing Project
 ; This report assists users in reviewing all bills containing charges 
 ; with a distinct date of service on or after the co-payment exemption 
 ; effective date for Veterans with Primary or Secondary Eligibility equal 
 ; to 50 to 100% Service Connected
 ; 
 ;  The report captures any charges without an IB status of cancelled, and
 ; with an AR Status of Active, Open, Suspended, Write-Off, or Collected/
 ; Closed or an IB Status of On-Hold, with a date of service on or after
 ; the exemption effective date.
 ;
 ;PRC*4.5*386 Uses admit date in lieu of discharge date for I/P
 ;            Removes cancelled IB charges from report
 ;            Removes Urgent Care copayments as they are not auto exempt
 ;
MAIN ; Initial Interactive Processing
 S:$G(U)="" U="^"
 ;N STOPIT,EXCEL,RCSCR,RDDATE,RCBEGDT,RCENDDT,EOCBEGDT,EOCENDDT,EOCDATE,VLSDATE,VLSBEGDT,VLSENDDT,RPTTYPE
 N STOPIT,EXCEL,RCSCR,ARTYPE
 W !!,"*** Print the 50-100 Percent SC Exempt Charge Reconciliation Report ***",!
 ;
 S STOPIT=0 ; quit flag
 ; Get Status
 S ARTYPE=$$ARSTAT^RCDMCUT2(.STOPIT)
 Q:STOPIT>0!(ARTYPE']"")
 ;
 ; Prompt user if report will be Excel Delimited format:
 S EXCEL=$$EXCEL^RCDMCUT2
 ;Quit is user up arrowed or timed out
 Q:EXCEL="^"
 D:EXCEL>0 EXMSG^RCDMCUT2
 D:EXCEL'>0
 . W !!,"This report may take a while to process. It is recommended that"
 . W !,"you Queue this report to a device that is 132 characters wide."
 ;
 N %ZIS,ZTSK,ZTRTN,ZTIO,ZTDESC,POP,ZTSAVE
 S %ZIS="QM"
 W ! D ^%ZIS
 I POP S STOPIT=1 Q
 S RCSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 ;
 I $D(IO("Q")) D  S STOPIT=1
 . S ZTRTN="RUN^RCDMCR6A"
 . S ZTIO=ION
 . S ZTSAVE("RCSCR")=""
 . S ZTSAVE("ARTYPE")=""
 . S ZTSAVE("EXCEL")=""
 . S ZTDESC="50-100 Percent SC Exempt Charge Reconciliation Report Process"
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Request Queued.  TASK = "_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 ;
 Q:STOPIT>0!($D(ZTQUEUED))
 D RUN^RCDMCR6A
 I STOPIT'=2 D PAUSE2^RCDMCUT2
 Q
QUERPT ; Initial Taskman Scheduled Queued processing
 Q
 ;
RUN ;Get data and Print it out
 ;If queued ensure you delete it from the TASKS file
 I $D(ZTQUEUED) S ZTREQ="@"
 N RCPAGE
 K ^TMP($J,"RCDMCR6")
 S RCPAGE=0,STOPIT=$G(STOPIT)
 ; Collect the data in ^TMP
 D COLLECT^RCDMCR6B(.STOPIT,ARTYPE)
 Q:$G(STOPIT)>0
 U IO
 ; Print Report using data in ^TMP
 D REPORT
 I 'RCSCR W !,@IOF
 D ^%ZISC
 K ^TMP($J,"RCDMCR6")
 K EXCEL,RCSCR,TESTDATE
 Q
 ;
REPORT ;Print report
 N RUNDATE,STATUS,NAME,SSN,BILLNO,IBIEN,SKIP,RCDADMIT,RCDEND,RCDIBRC1   ;PRCA*4.5*386
 ;
 S RUNDATE=$$FMTE^XLFDT($$NOW^XLFDT,"9MP")
 D HDR
 I +$D(^TMP($J,"RCDMCR6"))'>0 W !,"No data meets the criteria." Q
 K SKIP
 S NAME=""
 F  S NAME=$O(^TMP($J,"RCDMCR6","DETAIL",NAME)) Q:NAME']""  D  Q:STOPIT
 . S SSN=""
 . F  S SSN=$O(^TMP($J,"RCDMCR6","DETAIL",NAME,SSN)) Q:SSN']""  D  Q:STOPIT
 . . S BILLNO=""
 . . F  S BILLNO=$O(^TMP($J,"RCDMCR6","DETAIL",NAME,SSN,BILLNO)) Q:BILLNO']""  D  Q:STOPIT
 . . . S IBIEN=""
 . . . F  S IBIEN=$O(^TMP($J,"RCDMCR6","DETAIL",NAME,SSN,BILLNO,IBIEN)),RCDEND=0 Q:IBIEN']""  D  Q:STOPIT
 . . . . N NODE,SERVDT,RXDT,ELIG,EXEMPTDT,RXNUM,RXNAM,STATUS
 . . . . S NODE=$G(^TMP($J,"RCDMCR6","DETAIL",NAME,SSN,BILLNO,IBIEN))
 . . . . S (RCDADMIT,RCDIBRC1)=""   ;PRCA*4.5*386
 . . . . S SERVDT=$P(NODE,U,1),RCSTS=" " D:BILLNO   ;PRCA*4.5*386
 . . . . . S RCDIEN=$O(^IB("ABIL",BILLNO,0)) Q:'RCDIEN
 . . . . . S RCDIBREC=$G(^IB(RCDIEN,0)) Q:'RCDIBREC
 . . . . . I $P(RCDIBREC,U,16) D    ;PRCA*4.5*386
 . . . . . . S RCDIBPNT=$P(RCDIBREC,U,16)
 . . . . . . S RCDIBRC1=$G(^IB(RCDIBPNT,0)),RCDADMIT=""
 . . . . . I ":10:11:"[(":"_$P(RCDIBREC,U,5)_":") S RCDEND=1 Q  ;PRCA*4.5*386
 . . . . . I ":201:202:203:"[(":"_$P(RCDIBREC,U,3)_":") S RCDEND=1 Q  ;PRCA*4.5*386
 . . . . . I +RCDIBRC1,":55:56:"[(":"_+$P(RCDIBRC1,U,3)_":") S RCDADMIT=$P(RCDIBRC1,U,17)   ;PRCA*4.5*386
 . . . . Q:RCDEND   ;PRCA*4.5*386
 . . . . S SERVDT=$P(NODE,U,1)
 . . . . S RXDT=$P(NODE,U,2)
 . . . . S ELIG=$P(NODE,U,3)
 . . . . S EXEMPTDT=$P(NODE,U,4)
 . . . . S RXNUM=$P(NODE,U,5)
 . . . . S RXNAM=$P(NODE,U,6)
 . . . . S STATUS=$P(NODE,U,7)
 . . . . I EXCEL'>0 D WRLINE Q
 . . . . I EXCEL>0 D WRLINE2 Q
 Q
 ;
WRLINE ; Write the data formated report line
 ; Columns are - position, width, spacing (offset header by)
 ;Veteran Name - 0,23,1 
 ;SSN - 24,10,1
 ;Eligibility - 35,11,1 
 ;Bill # - 47,11,1
 ;EXMPTDT - 59,7,1
 ;Med Care Date - 67,13,1
 ;RXFillDT - 81,7,1
 ;RX # - 89,9,1
 ;RX Name - 99,22,1 
 ;AR Status - 122,9
 D CHKP() Q:STOPIT
 W !
 ;If Multiple Bills for Vet only print Name & SSN for 1st record on page
 ; Disable skip for now (as per direction of customer) with :0
 I (NAME_SSN)'=$G(SKIP(1)) D
 . W $E(NAME,1,23) ; Veteran Name
 . W ?24,SSN ; SSN
 . S:0 SKIP(1)=NAME_SSN
 W ?35,ELIG
 W ?47,$P(BILLNO,"/",1) ; Bill Number
 I EXEMPTDT="NODATE" W ?59,EXEMPTDT Q
 W ?59,$$STRIP^XLFSTR($$FMTE^XLFDT(EXEMPTDT,"8D")," ")
 I RCDADMIT S SERVDT=RCDADMIT   ;PRCA*4.5*386
 W:SERVDT>0 ?67,$$STRIP^XLFSTR($$FMTE^XLFDT(SERVDT,"8D")," ")
 W:RXDT>0 ?81,$$STRIP^XLFSTR($$FMTE^XLFDT(RXDT,"8D")," ") ; Med Fill Date
 W ?89,RXNUM ; RX # 
 W ?99,$E(RXNAM,1,22) ; RX Name
 W ?122,$E(STATUS,1,9)   ;PRCA*4.5*386
 Q
 ;
WRLINE2 ; Write the Excel report line
 W !
 W NAME,U
 W SSN,U
 W ELIG,U
 W $P(BILLNO,"/",1),U
 I EXEMPTDT="NODATE" W EXEMPTDT Q
 W:EXEMPTDT $$FMTE^XLFDT(EXEMPTDT,"9D") W U
 I RCDADMIT S SERVDT=RCDADMIT   ;PRCA*4.5*386
 W:SERVDT $$FMTE^XLFDT(SERVDT,"9D") W U
 W:RXDT $$FMTE^XLFDT(RXDT,"9D") W U
 W RXNUM,U
 W RXNAM,U
 W STATUS,U
 Q
 ;
CHKP(FOOTER) ;Check for End of Page
 ;INPUT:
 ;  FOOTER - Footer value. Optional. Default to 4 if nothing passed
 Q  I $G(FOOTER)'>0 S FOOTER=4
 I $Y>(IOSL-FOOTER) D:RCSCR PAUSE^RCDMCUT2 Q:STOPIT  D HDR K SKIP
 Q
 ;
HDR ;Print Report Header
 I EXCEL>0 D  Q
 . W !,"Veteran Name",U,"SSN",U,"Eligibility",U,"Bill #",U,"EXMPTDT",U,"Med Care Date",U,"RXFillDT",U,"RX #",U,"RX Name",U,"Status"
 S RCPAGE=RCPAGE+1
 W @IOF,"50-100 Percent SC Exempt Charge Reconciliation Report  -- Run Date: ",RUNDATE," --"
 W ?122,"Page "_RCPAGE
 W !
 ;Print to screen or printer
 W !,"Veteran Name",?24,"SSN",?35,"Eligibility",?47,"Bill #",?59,"EXMPTDT",?67,"Med Care Date",?81,"RXFillDT",?90,"RX #",?99,"RX Name",?122,"Status"
 D ULINE^RCDMCUT2("=",$G(IOM))
 Q
