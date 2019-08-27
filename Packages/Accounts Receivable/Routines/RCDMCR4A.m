RCDMCR4A ;ALB/YG - 0 - 40 Percent SC Change Reconciliation Report - Input/output; Apr 9, 2019@21:06
 ;;4.5;Accounts Receivable;**347**;Mar 20, 1995;Build 47
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;This routine is being implemented for the AR Cross-Referencing Project
 ;It will do the following:
 ;   Report option in AR to assist users in focusing on reviewing the 
 ;   legitimacy of bills for veterans who are neither SC 50% to 100% 
 ;   nor in receipt of a VA Pension benefits (Veterans not included on
 ;   the "DMC Debt Validity Report"). The report will contain 
 ;   information on veterans who have bills for episodes of care 
 ;   within the specified date range, who have a new Rated Disability
 ;   during a user selected time period, and whose service update date is 
 ;   within user specified date range 
 ;
MAIN ; Initial Interactive Processing
 S:$G(U)="" U="^"
 N STOPIT,EXCEL,RCSCR,RDDATE,RCBEGDT,RCENDDT,EOCBEGDT,EOCENDDT,EOCDATE,VLSDATE,VLSBEGDT,VLSENDDT,RPTTYPE
 W !!,"*** Print the 0-40 Percent SC Change Reconciliation Report ***",!
 ;
 S STOPIT=0 ; quit flag
 ;Prompt user for Date Range for Rated Disability Eligibility Changes
 S RDDATE=$$DATE2^RCDMCUT2("    Enter the Date Range for Rated Disability Changes.")
 ;Quit is user up arrowed or timed out
 Q:RDDATE'>0
 S RCBEGDT=$P(RDDATE,U,2),RCENDDT=$P(RDDATE,U,3)
 ;
 ;Prompt user for Date range for VistA Last Status Date
 W !
 S VLSDATE=$$DATE2^RCDMCUT2("Include Bills with VistA Last Status Date that fall within ","the Date Range for Rated Disability Changes:",RCBEGDT,RCENDDT,"VistA Last Status Update")
 ;Quit if user up arrowed or timed out
 Q:+VLSDATE'>0
 S VLSBEGDT=$P(VLSDATE,U,2),VLSENDDT=$P(VLSDATE,U,3)
 ;
 ;Prompt user for Date range for Episodes of Care Date
 W !
 S EOCDATE=$$DATE2^RCDMCUT2("Include Bills for Episodes of Care within User Selected Date Range:",,2880101,,"Episodes of Care")
 ;Quit if user up arrowed or timed out
 Q:+EOCDATE'>0
 S EOCBEGDT=$P(EOCDATE,U,2),EOCENDDT=$P(EOCDATE,U,3)
 ; 
 ; Get Report Type (Detailed/Summary)
 S STOPIT=0
 S RPTTYPE=$$GETTYPE2^RCDMCUT2(.STOPIT)
 Q:STOPIT>0!(RPTTYPE']"")
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
 ; Logic from DEVICE^RCDMCUT2 copied here
 N %ZIS,ZTSK,ZTRTN,ZTIO,ZTDESC,POP,ZTSAVE
 S %ZIS="QM"
 W ! D ^%ZIS
 I POP S STOPIT=1 Q
 ; RCSCR is 1 if sent to screen
 S RCSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 ; If report is Queued
 I $D(IO("Q")) D  Q
 . S ZTRTN="RUN^RCDMCR4A"
 . S ZTIO=ION
 . S ZTSAVE("RCBEGDT")=""
 . S ZTSAVE("RCENDDT")=""
 . S ZTSAVE("EOCBEGDT")=""
 . S ZTSAVE("EOCENDDT")=""
 . S ZTSAVE("VLSBEGDT")=""
 . S ZTSAVE("VLSENDDT")=""
 . S ZTSAVE("RPTTYPE")=""
 . S ZTSAVE("RCSCR")=""
 . S ZTSAVE("EXCEL")=""
 . S ZTDESC="DMC 0-40 Percent SC Change Reconciliation Report Process"
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Request Queued.  TASK = "_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 ;
 Q:STOPIT>0!($D(ZTQUEUED))
 D RUN^RCDMCR4A
 I 'STOPIT D PAUSE2^RCDMCUT2
 Q
 ; 
 ; Currently, Taskman schedulable option is not being planned for this report
 ; If this is going to change later on, QUERPT^RCDMCR3A would be a good example
 ; of how to do such an option
 ;  
QUERPT ; Initial Taskman Scheduled Queued processing
 ; Set up parameters
 ; Run report
 D RUN^RCDMCR4A
 Q
 ;
RUN ;Get data and Print it out
 ;If queued ensure you delete it from the TASKS file
 I $D(ZTQUEUED) S ZTREQ="@"
 N RCPAGE
 S STOPIT=0 ; quit flag
 K ^TMP($J,"RCDMCR4")
 S RCPAGE=0
 ; Collect the data in ^TMP($J,"RCDMCR4")
 D COLLECT^RCDMCR4B(.STOPIT,RCBEGDT,RCENDDT,VLSBEGDT,VLSENDDT,EOCBEGDT,EOCENDDT,RPTTYPE)
 Q:STOPIT>0
 U IO
 ; Print Report using data in ^TMP
 D REPORT
 I 'RCSCR W !,@IOF
 D ^%ZISC
 K ^TMP($J,"RCDMCR4")
 K EXCEL,RCSCR
 Q
 ;
REPORT ;Print report
 N RUNDATE,STATUS,NAME,SSN,CHGDT,RDNAME,RDSEXTRE,BILLNO
 N SKIP,IBCNT,SCPER
 S RUNDATE=$$FMTE^XLFDT($$NOW^XLFDT,"9MP")
 D HDR
 I +$D(^TMP($J,"RCDMCR4"))'>0 W !,"No data meets the criteria." Q
 I RPTTYPE="S" D
 . S NAME=""
 . F  S NAME=$O(^TMP($J,"RCDMCR4","SUMMARY",NAME)) Q:NAME']""  D  Q:STOPIT
 . . S SSN=""
 . . F  S SSN=$O(^TMP($J,"RCDMCR4","SUMMARY",NAME,SSN)) Q:SSN']""  D  Q:STOPIT
 . . . W !
 . . . S SCPER=^TMP($J,"RCDMCR4","SUMMARY",NAME,SSN)
 . . . I EXCEL>0 W NAME,U,SSN,U,+SCPER Q
 . . . W $E(NAME,1,25) ; Veteran Name
 . . . W ?27,SSN ; SSN
 . . . W ?41,$J(+SCPER,2) ; Comb SC%
 I RPTTYPE="D" D
 . S NAME=""
 . F  S NAME=$O(^TMP($J,"RCDMCR4","DETAIL",NAME)) Q:NAME=""  D  Q:STOPIT
 . . S SSN=""
 . . F  S SSN=$O(^TMP($J,"RCDMCR4","DETAIL",NAME,SSN)) Q:SSN=""  D  Q:STOPIT
 . . . S CHGDT=""
 . . . F  S CHGDT=$O(^TMP($J,"RCDMCR4","DETAIL",NAME,SSN,CHGDT)) Q:CHGDT=""  D  Q:STOPIT
 . . . . S RDNAME=""
 . . . . F  S RDNAME=$O(^TMP($J,"RCDMCR4","DETAIL",NAME,SSN,CHGDT,RDNAME)) Q:RDNAME=""  D  Q:STOPIT
 . . . . . S RDSEXTRE=""
 . . . . . F  S RDSEXTRE=$O(^TMP($J,"RCDMCR4","DETAIL",NAME,SSN,CHGDT,RDNAME,RDSEXTRE)) Q:RDSEXTRE=""  D  Q:STOPIT
 . . . . . . S BILLNO=""
 . . . . . . F  S BILLNO=$O(^TMP($J,"RCDMCR4","DETAIL",NAME,SSN,CHGDT,RDNAME,RDSEXTRE,BILLNO)) Q:BILLNO=""  D  Q:STOPIT
 . . . . . . . S IBCNT=""
 . . . . . . . F  S IBCNT=$O(^TMP($J,"RCDMCR4","DETAIL",NAME,SSN,CHGDT,RDNAME,RDSEXTRE,BILLNO,IBCNT)) Q:IBCNT=""  D  Q:STOPIT
 . . . . . . . . ; (NAME,SSN,RDCHGDT,RDNAME,RDSEXTRE,BILLNO,IBCNT)=RDORGDT_U_RXDT_U_OPTDT_U_DISCHDT_U_DSTATUS_U_SCPER_U_VLSDT_U_CHGAMT_U_$G(RXNUM)_U_$G(RXNAM)
 . . . . . . . . N NODE,RDORGDT,RXDT,OPTDT,DISCHDT,STATUS,SCPER,VLSDT,CHGAMT,RXNUM,RXNAM
 . . . . . . . . S NODE=$G(^TMP($J,"RCDMCR4","DETAIL",NAME,SSN,CHGDT,RDNAME,RDSEXTRE,BILLNO,IBCNT))
 . . . . . . . . S RDORGDT=$P(NODE,U,1)
 . . . . . . . . S RXDT=$P(NODE,U,2)
 . . . . . . . . S OPTDT=$P(NODE,U,3)
 . . . . . . . . S DISCHDT=$P(NODE,U,4)
 . . . . . . . . S STATUS=$P(NODE,U,5)
 . . . . . . . . S SCPER=$P(NODE,U,6)
 . . . . . . . . S VLSDT=$P(NODE,U,7)
 . . . . . . . . S CHGAMT=$P(NODE,U,8)
 . . . . . . . . S RXNUM=$P(NODE,U,9)
 . . . . . . . . S RXNAM=$P(NODE,U,10)
 . . . . . . . . I EXCEL'>0 D WRLINE Q
 . . . . . . . . I EXCEL>0 D WRLINE2 Q
 ;Don't print summary if user ^ out
 Q:STOPIT
 I EXCEL'>0 D ULINE^RCDMCUT2("=",48)
 Q
 ;
WRLINE ; Write the data formated report line
 D CHKP() Q:STOPIT
 W !
 ; Disable skip for now (as per direction of customer) with condition :0
 I (NAME_SSN_+SCPER)'=$G(SKIP(1)) D
 . W $E(NAME,1,13) ; Veteran Name
 . W ?14,SSN ; SSN
 . W ?24,$J(+SCPER,2) ; Comb SC%
 . K SKIP(2),SKIP(3)
 . S:0 SKIP(1)=NAME_SSN_+SCPER
 I VLSDT'=$G(SKIP(2)) S:0 SKIP(2)=VLSDT W ?27,$$STRIP^XLFSTR($$FMTE^XLFDT(VLSDT,"8D")," ") ; Vista CHG Date
 I RDNAME'=$G(SKIP(3)) S:0 SKIP(3)=RDNAME W ?35,$E(RDNAME,1,13) ; RD Name
 W ?49,$E(RDSEXTRE,1,2)
 W ?52,$S(RDORGDT="NODATE":RDORGDT,1:$$STRIP^XLFSTR($$FMTE^XLFDT(RDORGDT,"8D")," ")) ; RD Orig Date
 W ?60,$P(BILLNO,"/",1) ; Bill Number
 W:RDORGDT'="NODATE" ?72,$J("$"_$FN(CHGAMT,",",2),11) ; Charge Amount 
 ; pick the later of OPTDT (outpatient) and DISCHDT (inpatient)
 I DISCHDT>OPTDT W:DISCHDT>0 ?84,$$STRIP^XLFSTR($$FMTE^XLFDT(DISCHDT,"8D")," ")
 E  W:OPTDT>0 ?84,$$STRIP^XLFSTR($$FMTE^XLFDT(OPTDT,"8D")," ")
 W:RXDT>0 ?92,$$STRIP^XLFSTR($$FMTE^XLFDT(RXDT,"8D")," ") ; Med Fill Date
 W ?100,RXNUM ; RX # 
 W ?109,$E(RXNAM,1,12) ; RX Name
 W ?123,$E(STATUS,1,9) ; This will be AR status for most cases, but for some, it will be IB Status ON HOLD
 Q
 ;
WRLINE2 ; Write the Excel report line
 W !
 W $$EXOUT(NAME),U
 W $$EXOUT(SSN),U
 W +SCPER,U
 W $$FMTE^XLFDT(VLSDT,"9D"),U
 W RDNAME,U
 W RDSEXTRE,U
 I RDORGDT="NODATE" W "NODATE",U
 W $S(RDORGDT="NODATE":"NODATE",1:$$FMTE^XLFDT(RDORGDT,"9D")),U
 W $P(BILLNO,"/",1),U
 W "$",$FN(CHGAMT,",",2),U
 I DISCHDT>OPTDT W $$FMTE^XLFDT(DISCHDT,"9D")
 E  I OPTDT W $$FMTE^XLFDT(OPTDT,"9D")
 W U
 I RXDT W $$FMTE^XLFDT(RXDT,"9D")
 W U
 W RXNUM,U
 W RXNAM,U
 W STATUS
 Q
 ;
CHKP(FOOTER) ;Check for End of Page
 ;INPUT:
 ;  FOOTER - Footer value. Optional. Default to 4 if nothing passed
 I $G(FOOTER)'>0 S FOOTER=4
 I $Y>(IOSL-FOOTER) D:RCSCR PAUSE^RCDMCUT2 Q:STOPIT  D HDR K SKIP
 Q
EXOUT(DATA) ; Format data so Excel won't mess it up.  
 ; Note - there are other ways Excel mangles data, but they are not expected in this report
 S DATA=$TR(DATA,"""","")
 I DATA?1"0".N S DATA=""""_DATA_"""" Q DATA
 I DATA["," S DATA=""""_DATA_""""
 Q DATA
 ;
HDR ;Print Report Header
 ; See WRLINE for header positions
 I EXCEL>0 D  Q
 . W !,"Veteran Name",U,"SSN",U,"Comb SC %"
 . I RPTTYPE="S" Q
 . W U,"VistA Chd Date",U,"RD Name",U,"Ext",U,"RD Orig Date",U,"Bill Number",U,"Charge Amount",U,"Medical Care Date",U,"RXFillDT",U,"RX #",U,"RX Name",U,"Status"
 S RCPAGE=RCPAGE+1
 W @IOF,"0-40 Percent SC Change Reconciliation ",$S(RPTTYPE="D":"Detailed",1:"Summary")," Report  -- Run Date: ",RUNDATE," --"
 W ?122,"Page "_RCPAGE
 W !?6,"RD Change Dates from ",$$FMTE^XLFDT(RCBEGDT,"9D")," to ",$$FMTE^XLFDT(RCENDDT,"9D")
 W ?57,"VistA Change Dates from ",$$FMTE^XLFDT(VLSBEGDT,"9D")," to ",$$FMTE^XLFDT(VLSENDDT,"9D")
 W !,?6,"Episode of Care Dates from ",$$FMTE^XLFDT(EOCBEGDT,"9D")," to ",$$FMTE^XLFDT(EOCENDDT,"9D")
 W !
 ;Print to screen or printer
 I RPTTYPE="S" D
 . W !,?40,"Comb"
 . W !,?5,"Veteran Name",?30,"SSN",?40,"SC %"
 I RPTTYPE="D" D
 . W !,"                                                                                      Medical"
 . W !,"                      Comb   VistA                  RD Orig                  Charge     Care"
 . W !," Veteran Name    SSN  SC % Chd Date    RD Name  Ext  Date    Bill Number     Amount     Date RXFillDT   RX #   RX Name      Status"
 D ULINE^RCDMCUT2("=",$G(IOM))
 Q
 ; Support Utility to find test cases.   Not a part of code executed by users, just by testers 
 ; This utility is provided since currently there is no way to see data in file 390 anywhere except
 ; RDEC report, and RDEC is not useful for testers
 ; 
 ; As a testers only code, it is not fully coded per usual standards
RDINFO ;
 N DR,D,DFN,ND,OCC,PN
 K ^TMP($J)
 S DFN=""
 R !,"Patient Name or SSN: ",PN:99999 Q:PN="^"
 I PN'="" D
 . I PN?9N S DFN=$O(^DPT("SSN",PN,"")) I DFN Q
 . I PN'?9N,$D(^DPT("B",PN)) S DFN=$O(^DPT("B",PN,"")) I DFN Q
 . I PN'?9N,'DFN S PN=$O(^DPT("B",PN)),DFN=$O(^DPT("B",PN,"")) W !,"Patient ",PN
 W ! S DR=$$DATE2^RCDMCUT2("    Enter the Date Range for Rated Disability Changes.")
 I 'DR Q
 D RDCHG^DGENRDUA(DFN,$P(DR,U,2),$P(DR,U,3))
 S DFN="" F  S DFN=$O(^TMP($J,"RDCHG",DFN)) Q:DFN=""  D
 . W !!,"Patient ",DFN," ",$P(^DPT(DFN,0),U)
 . S D=$P($G(^DPT(DFN,.361)),U,2) W "  Vista Chg DT: " I D W $E(D,4,5),"/",$E(D,6,7),"/",$E(D,1,3)+1700
 . W !,"  COMB SC%: ",$P($G(^DPT(DFN,.3)),U,2)
 . S D=$P($G(^DPT(DFN,.3)),U,14)
 . I D W " EFF. DATE: ",$E(D,4,5),"/",$E(D,6,7),"/",$E(D,1,3)+1700
 . W !
 . F OCC=1:1 S ND=$G(^TMP($J,"RDCHG",DFN,OCC)) Q:ND=""  D
 . . S D=$P(ND,U)
 . . W !,OCC,?5,"RD Change: " I D W $E(D,4,5),"/",$E(D,6,7),"/",$E(D,1,3)+1700
 . . W "  RD Name: ",$E($P(ND,U,3),1,30)
 . . W "  RD %: ",$P(ND,U,4)
 . . W !,?5
 . . W "  RD Extremity: ",$P(ND,U,6)
 . . S D=$P(ND,U,7)
 . . I D W "  RD Orig: ",$E(D,4,5),"/",$E(D,6,7),"/",$E(D,1,3)+1700
 Q
