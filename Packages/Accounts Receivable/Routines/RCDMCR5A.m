RCDMCR5A ;ALB/YG - First Party Charge IB Cancellation Reconciliation Report - Input/output; Apr 9, 2019@21:06
 ;;4.5;Accounts Receivable;**347**;Mar 20, 1995;Build 47
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;This routine is being implemented for the AR Cross-Referencing Project
 ;
 ;This report will assist users in reviewing first party charges receiving
 ;Integrated Billing (IB) cancellation for potential refund activities or charge
 ;cancellation accuracy, and to identify and monitor cancellation activity
 ;productivity so veteran customers can receive refunds due to them for
 ;retroactive eligibility exemptions.  The report provides data for first party
 ;charges receiving IB cancellation for a user defined bill cancellation 
 ;date range.
MAIN ; Initial Interactive Processing
 N STOPIT,EXCEL,CANDATE,CANBEGDT,CANENDDT,BILLPAYS,RCSCR
 W !!,"*** Print the First Party Charge IB Cancellation Reconciliation Report ***",!
 S STOPIT=0 ; quit flag
 ;Prompt user for Date Range for Bill Cancellation date range
 S CANDATE=$$DATE2^RCDMCUT2("    Enter the Bill Cancellation Date Range: ")
 ;Quit is user up arrowed or timed out
 Q:CANDATE'>0
 S CANBEGDT=$P(CANDATE,U,2),CANENDDT=$P(CANDATE,U,3)
 ; Prompt user for Bills with Payments
 S BILLPAYS=$$BILLPAYS^RCDMCUT2
 Q:BILLPAYS="^"
 ; Prompt user if report will be Excel Delimited format:
 S EXCEL=$$EXCEL^RCDMCUT2
 ;Quit is user up arrowed or timed out
 Q:EXCEL="^"
 D:EXCEL>0 EXMSG^RCDMCUT2
 D:EXCEL'>0
 . W !!,"This report may take a while to process. It is recommended that"
 . W !,"you Queue this report to a device that is 132 characters wide."
 ; Logic from DEVICE^RCDMCUT2 copied here
 N %ZIS,ZTRTN,ZTIO,ZTSAVE,ZTDESK,ZTSK,POP,ZTDESC
 S %ZIS="QM"
 W ! D ^%ZIS
 I POP Q
 S RCSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 ;
 I $D(IO("Q")) D  S STOPIT=1
 . S ZTRTN="RUN^RCDMCR5A"
 . S ZTIO=ION
 . S ZTSAVE("RCSCR")=""
 . S ZTSAVE("CANBEGDT")=""
 . S ZTSAVE("CANENDDT")=""
 . S ZTSAVE("BILLPAYS")=""
 . S ZTSAVE("EXCEL")=""
 . S ZTDESC="DMC 0-40 Percent SC Change Reconciliation Report Process"
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Request Queued.  TASK = "_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 ;
 Q:STOPIT>0!($D(ZTQUEUED))
 D RUN^RCDMCR5A
 I 'STOPIT D PAUSE2^RCDMCUT2
 Q
 ; Currently, Taskman schedulable option is not being planned for this report
 ; If this is going to change later on, QUERPT^RCDMCR3A would be a good example
 ; of how to do such an option
QUERPT ; Initial Taskman Scheduled Queued processing
 Q
 ;
RUN ;Get data and Print it out
 ;If queued ensure you delete it from the TASKS file
 I $D(ZTQUEUED) S ZTREQ="@"
 N RCPAGE
 S STOPIT=0
 K ^TMP($J,"RCDMCR5")
 S RCPAGE=0
 ; Collect the data in ^TMP
 D COLLECT^RCDMCR5B(.STOPIT,CANBEGDT,CANENDDT,BILLPAYS)
 Q:$G(STOPIT)>0
 U IO
 ; Print Report using data in ^TMP
 D REPORT
 I 'RCSCR W !,@IOF
 D ^%ZISC
 K ^TMP($J,"RCDMCR5")
 K EXCEL,RCSCR
 Q
 ;
REPORT ;Print report
 N RUNDATE,NAME,SSN,BILLNO,IBIEN,SKIP
 ;
 S RUNDATE=$$FMTE^XLFDT($$NOW^XLFDT,"9MP")
 D HDR
 I +$D(^TMP($J,"RCDMCR5"))'>0 W !,"No data meets the criteria." Q
 K SKIP
 S NAME=""
 F  S NAME=$O(^TMP($J,"RCDMCR5","DETAIL",NAME)) Q:NAME']""  D  Q:STOPIT
 . S SSN=""
 . F  S SSN=$O(^TMP($J,"RCDMCR5","DETAIL",NAME,SSN)) Q:SSN']""  D  Q:STOPIT
 . . S BILLNO=""
 . . F  S BILLNO=$O(^TMP($J,"RCDMCR5","DETAIL",NAME,SSN,BILLNO)) Q:BILLNO']""  D  Q:STOPIT
 . . . S IBIEN=""
 . . . F  S IBIEN=$O(^TMP($J,"RCDMCR5","DETAIL",NAME,SSN,BILLNO,IBIEN)) Q:IBIEN']""  D  Q:STOPIT
 . . . . N NODE,CHGAMT,SERVDT,RXDT,RXNUM,RXNAM,CANCDT,CANCREAS,CANCUSER
 . . . . ; S ^TMP($J,"RCDMCR5","DETAIL",NAME,SSN,BILLNO,IBIEN)=SERVDT_U_RXDT_U_CHGAMT_U_RXNUM_U_RXNAM_U_CANCDT_U_CANCREAS_U_CANCUSER
 . . . . S NODE=$G(^TMP($J,"RCDMCR5","DETAIL",NAME,SSN,BILLNO,IBIEN))
 . . . . S SERVDT=$P(NODE,U,1)
 . . . . S RXDT=$P(NODE,U,2)
 . . . . S CHGAMT=$P(NODE,U,3)
 . . . . S RXNUM=$P(NODE,U,4)
 . . . . S RXNAM=$P(NODE,U,5)
 . . . . S CANCDT=$P(NODE,U,6)
 . . . . S CANCREAS=$P(NODE,U,7)
 . . . . S CANCUSER=$P(NODE,U,8)
 . . . . I EXCEL'>0 D WRLINE Q
 . . . . I EXCEL>0 D WRLINE2 Q
 Q
 ;
WRLINE ; Write the data formated report line
 ;If Multiple Bills for Vet only print Name & SSN for 1st record on page
 ;
 ; Columns are - position, width, spacing (offset header by)
 ; Veteran Name - 0, 13, 1 (offset 1)
 ; SSN - 14, 10, 1 (offset 3)
 ; Bill Number - 25, 11, 1 (offset 1)
 ; Charge/Amount - 37, 11, 1 (offset 3,3)
 ; Medical/Care Date - 49, 8, 1 (offset 1, 0)
 ; RXFillDT - 58, 9, 1 (offset 0)
 ; RX # - 68,9,1 (offset 3)
 ; RX Name - 78,14,1 (offset 3)
 ; IBCXLDT - 93,7,1 (offset 0)
 ; IB Cancellation/Reason - 101, 16, 1 (Offset 0, 6)
 ; Cancelled By - 118, 14 (offset 1)
 D CHKP() Q:STOPIT
 ; Disable Skips for now per direction of customer with :0
 W !
 I (NAME_SSN)'=$G(SKIP(1)) D
 . W $E(NAME,1,13) ; Veteran Name
 . W ?14,SSN ; SSN
 . S:0 SKIP(1)=NAME_SSN
 W ?25,BILLNO ; Bill Number
 W ?37,$J("$"_$FN(CHGAMT,",",2),11)
 W:SERVDT>0 ?49,$$STRIP^XLFSTR($$FMTE^XLFDT(SERVDT,"8D")," ")
 W:RXDT>0 ?58,$$STRIP^XLFSTR($$FMTE^XLFDT(RXDT,"8D")," ") ; Med Fill Date
 W ?68,RXNUM ; RX # 
 W ?78,$E(RXNAM,1,14) ; RX Name
 W ?93,$$STRIP^XLFSTR($$FMTE^XLFDT(CANCDT,"8D")," ")
 W ?101,$E(CANCREAS,1,16)
 W ?118,$E(CANCUSER,1,14)
 Q
 ;
WRLINE2 ; Write the Excel report line
 W !
 W $$EXOUT^RCDMCR4A(NAME),U
 W $$EXOUT^RCDMCR4A(SSN),U
 W BILLNO,U
 W "$",$FN(CHGAMT,",",2),U
 W $$FMTE^XLFDT(SERVDT,"9D")
 W U
 I RXDT W $$FMTE^XLFDT(RXDT,"9D")
 W U
 W RXNUM,U
 W RXNAM,U
 W $$FMTE^XLFDT(CANCDT,"9D"),U
 W CANCREAS,U
 W $$EXOUT^RCDMCR4A(CANCUSER)
 Q
 ;
CHKP(FOOTER) ;Check for End of Page
 ;INPUT:
 ;  FOOTER - Footer value. Optional. Default to 4 if nothing passed
 I $G(FOOTER)'>0 S FOOTER=4
 I $Y>(IOSL-FOOTER) D:RCSCR PAUSE^RCDMCUT2 Q:STOPIT  D HDR
 Q
 ;
HDR ;Print Report Header
 ;RUNDATE - Current Date in human readable format
 I EXCEL>0 D  Q
 . W !,"Veteran Name",U,"SSN",U,"Bill Number",U,"Charge Amount",U,"Medical Care Date",U,"RXFillDT",U
 . W "RX #",U,"RX Name",U,"IBCXLDT",U,"IB Cancellation Reason",U,"Cancelled By"
 S RCPAGE=RCPAGE+1 K SKIP
 W @IOF,"First Party Charge IB Cancellation Reconciliation Report  -- Run Date: ",RUNDATE," --"
 W ?122,"Page "_RCPAGE
 W !?6,"Cancellation Dates from ",$$FMTE^XLFDT(CANBEGDT,"9D")," to ",$$FMTE^XLFDT(CANENDDT,"9D")
 W !
 ;Print to screen or printer
 W !,?39,"Charge",?49,"Medical",?101,"IB Cancellation"
 W !," Veteran Name",?17,"SSN",?25,"Bill Number",?40,"Amount",?48,"Care Date",?58,"RXFillDT",?71,"RX #",?81,"RX Name",?93,"IBCXLDT",?107,"Reason",?119,"Cancelled By"
 D ULINE^RCDMCUT2("=",$G(IOM))
 Q
