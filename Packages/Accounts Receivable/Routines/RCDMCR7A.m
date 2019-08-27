RCDMCR7A ;ALB/YG - 10-40% SC Medical Care Copayment Exempt Charge Reconciliation Report - Input/output; Apr 9, 2019@21:06
 ;;4.5;Accounts Receivable;**347**;Jan 29, 2019;Build 47
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;This routine is being implemented for the AR Cross-Servicing Project
 ;It assists users in reviewing all medical care copayment bills 
 ; containing charges with a distinct date of service on or after the 
 ; copayment exemption effective date for Veterans with SC Percent equal 
 ; to 10 to 40% and does not show prescription copayment bills.
 ;
 ; The report captures any medical care copayment charge without an IB 
 ; status of cancelled, and with an AR Status of Active, Open, Suspended,
 ; Write-Off, or Collected/Closed OR an IB Status of On-Hold, with a date 
 ; of service on or after the exemption effective date.
 ;
MAIN ; Initial Interactive Processing
 S:$G(U)="" U="^"
 ;N STOPIT,EXCEL,RCSCR,RDDATE,RCBEGDT,RCENDDT,EOCBEGDT,EOCENDDT,EOCDATE,VLSDATE,VLSBEGDT,VLSENDDT,RPTTYPE
 N STOPIT,EXCEL,RCSCR,ARTYPE
 W !!,"*** Print the 10-40% SC Medical Care Copayment Exempt Charge Recon Report ***",!
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
 D:EXCEL EXMSG^RCDMCUT2
 D:'EXCEL
 . W !!,"This report may take a while to process. It is recommended that"
 . W !,"you Queue this report to a device that is 132 characters wide."
 N %ZIS,ZTSK,ZTRTN,ZTIO,ZTDESC,POP,ZTSAVE
 S %ZIS="QM"
 W ! D ^%ZIS
 I POP S STOPIT=1 Q
 S RCSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 ;
 I $D(IO("Q")) D  S STOPIT=1
 . S ZTRTN="RUN^RCDMCR7A"
 . S ZTIO=ION
 . S ZTSAVE("RCSCR")=""
 . S ZTSAVE("ARTYPE")=""
 . S ZTSAVE("EXCEL")=""
 . S ZTSAVE("STOPIT")=""
 . S ZTDESC="50-100 Percent SC, A&A, Pension Exempt Charge Reconciliation Report Process"
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Request Queued.  TASK = "_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 ;
 Q:STOPIT>0!($D(ZTQUEUED))
 D RUN^RCDMCR7A
 I STOPIT'=2 D PAUSE2^RCDMCUT2
 Q
 ;  
QUERPT ; Initial Taskman Scheduled Queued processing
 Q
 ;
RUN ;Get data and Print it out
 ;If queued ensure you delete it from the TASKS file
 I $D(ZTQUEUED) S ZTREQ="@"
 N RCPAGE
 K ^TMP($J,"RCDMCR7")
 S RCPAGE=0,STOPIT=$G(STOPIT)
 ; Collect the data in ^TMP
 D COLLECT^RCDMCR7B(.STOPIT,ARTYPE)
 Q:$G(STOPIT)>0
 U IO
 ; Print Report using data in ^TMP
 D REPORT
 I 'RCSCR W !,@IOF
 D ^%ZISC
 K ^TMP($J,"RCDMCR7")
 K EXCEL,RCSCR,TESTDATE
 Q
 ;
REPORT ;Print report
 N RUNDATE,STATUS,NAME,SSN,BILLNO,IBIEN,SKIP,SCPER
 ;
 S RUNDATE=$$FMTE^XLFDT($$NOW^XLFDT,"9MP")
 D HDR
 I +$D(^TMP($J,"RCDMCR7"))'>0 W !,"No data meets the criteria." Q
 K SKIP
 S NAME=""
 F  S NAME=$O(^TMP($J,"RCDMCR7","DETAIL",NAME)) Q:NAME']""  D  Q:STOPIT
 . S SSN=""
 . F  S SSN=$O(^TMP($J,"RCDMCR7","DETAIL",NAME,SSN)) Q:SSN']""  D  Q:STOPIT
 . . S BILLNO=""
 . . F  S BILLNO=$O(^TMP($J,"RCDMCR7","DETAIL",NAME,SSN,BILLNO)) Q:BILLNO']""  D  Q:STOPIT
 . . . S IBIEN=""
 . . . F  S IBIEN=$O(^TMP($J,"RCDMCR7","DETAIL",NAME,SSN,BILLNO,IBIEN)) Q:IBIEN']""  D  Q:STOPIT
 . . . . N NODE,SERVDT,ELIG,EXEMPTDT,RXNUM,RXNAM,STATUS
 . . . . ; S ^TMP($J,"RCDMCR7","DETAIL",NAME,SSN,BILLNO,IBIEN)=SERVDT_U_SCPER_U_EXEMPTDT_U_STATUS
 . . . . S NODE=$G(^TMP($J,"RCDMCR7","DETAIL",NAME,SSN,BILLNO,IBIEN))
 . . . . S SERVDT=$P(NODE,U,1)
 . . . . S SCPER=$P(NODE,U,2)
 . . . . S EXEMPTDT=$P(NODE,U,3)
 . . . . S STATUS=$P(NODE,U,4)
 . . . . I EXCEL'>0 D WRLINE Q
 . . . . I EXCEL>0 D WRLINE2 Q
 Q
 ;
WRLINE ; Write the data formated report line
 ; Columns are - position, width, spacing (offset header by)
 ;Veteran Name - 0,23,1 
 ;SSN - 24,10,1
 ;SC Percent - 35,11,1 
 ;Bill # - 47,11,1
 ;EXMPTDT - 59,7,1
 ;Med Care Date - 67,13,1
 ;Status - 81,9
 D CHKP() Q:STOPIT
 W !
 ;If Multiple Bills for Vet only print Name & SSN for 1st record on page
 ; Disable skip for now (as per direction of customer) with :0
 I (NAME_SSN)'=$G(SKIP(1)) D
 . W $E(NAME,1,23) ; Veteran Name
 . W ?24,SSN ; SSN
 . S:0 SKIP(1)=NAME_SSN
 W ?38,SCPER,"%"
 W ?47,$P(BILLNO,"/",1) ; Bill Number
 W ?59,$$STRIP^XLFSTR($$FMTE^XLFDT(EXEMPTDT,"8D")," ")
 W:SERVDT>0 ?67,$$STRIP^XLFSTR($$FMTE^XLFDT(SERVDT,"8D")," ")
 W ?81,$E(STATUS,1,9)
 Q
 ;
WRLINE2 ; Write the Excel report line
 W !
 W NAME,U
 W SSN,U
 W SCPER,"%",U
 W $P(BILLNO,"/",1),U
 W $$FMTE^XLFDT(EXEMPTDT,"9D"),U
 W $$FMTE^XLFDT(SERVDT,"9D"),U
 W STATUS,U
 Q
 ;
CHKP(FOOTER) ;Check for End of Page
 ;INPUT:
 ;  FOOTER - Footer value. Optional. Default to 4 if nothing passed
 I $G(FOOTER)'>0 S FOOTER=4
 I $Y>(IOSL-FOOTER) D:RCSCR PAUSE^RCDMCUT2 Q:STOPIT  D HDR K SKIP
 Q
 ;
HDR ;Print Report Header
 I EXCEL>0 D  Q
 . W !,"Veteran Name",U,"SSN",U,"SC Percent",U,"Bill #",U,"EXMPTDT",U,"Med Care Date",U,"Status"
 S RCPAGE=RCPAGE+1
 W @IOF,"10-40% SC Medical Care Copayment Exempt Charge Reconciliation Report  -- Run Date: ",RUNDATE," --"
 W ?122,"Page "_RCPAGE
 W !
 ;Print to screen or printer
 W !,"Veteran Name",?24,"SSN",?35,"SC Percent",?47,"Bill #",?59,"EXMPTDT",?67,"Med Care Date",?81,"Status"
 D ULINE^RCDMCUT2("=",$G(IOM))
 Q
