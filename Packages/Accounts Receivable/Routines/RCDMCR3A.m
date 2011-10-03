RCDMCR3A ;HEC/SBW - DMC Rated Disability Eligibility Change Report ; 22/OCT/2007
 ;;4.5;Accounts Receivable;**253**;Mar 20, 1995;Build 9
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This routine is being implemented for the Hold Debt to DMC Project.
 ;It will do the following:
 ;   Report option in AR to assist users in focusing on reviewing the 
 ;   legitimacy of bills for veterans who are neither SC 50% to 100% 
 ;   nor in receipt of a VA Pension benefits (Veterans not included on
 ;   the "DMC Debt Validity Report"). The report will contain 
 ;   information on veterans who have bills for episodes of care 
 ;   within the previous 365 days (or older selected date) and who 
 ;   have a new Rated Disability during a user selected time period. 
 ;
MAIN ; Initial Interactive Processing
 N STOPIT,EXCEL,RCSCR,GETBEGDT,RDDATE,RCBEGDT,RCENDDT
 W !!,"*** Print the Rated Disability Eligibility Change Report ***"
 ;
 S STOPIT=0 ; quit flag
 ;Prompt user for Date Range for Rated Disability Eligibility Changes
 S RDDATE=$$DATE^RCDMCUT2("    Enter the Date Range for Rated Disability Changes.")
 ;Quit is user up arrowed or timed out
 Q:RDDATE'>0
 S RCBEGDT=$P(RDDATE,U,2),RCENDDT=$P(RDDATE,U,3)
 ;
 ;Prompt user for Date from which to include bills for episodes of care
 ;on report
 S GETBEGDT=$$GETBEGDT^RCDMCUT2("Report To Include Bills For Episodes of Care Beginning With User Selected Date.","    Entered Date Must be "_$$FMTE^XLFDT($$FMADD^XLFDT(DT,-365,0,0,0),"1D")_" or older!")
 ;Quit if user up arrowed or timed out
 Q:+GETBEGDT'>0
 S BEGDT=$P(GETBEGDT,U,2)
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
 D DEVICE^RCDMCUT2("RUN^RCDMCR3A","DMC Rated Disability Eligibility Change Report Process",.STOPIT,.RCSCR,BEGDT,EXCEL)
 Q:STOPIT>0!($D(ZTQUEUED))
 D RUN^RCDMCR3A
 I STOPIT'=2 D PAUSE2^RCDMCUT2
 Q
 ;
QUERPT ; Initial Taskman Scheduled Queued processing
 N STOPIT,EXCEL,RCSCR,BEGDT,RCDAY,RCBEGDT,RCENDDT
 S STOPIT=0,EXCEL="",RCSCR=""
 ;
 ;Get the "NUMBER OF DAYS FOR DMC REPORTS" site parameter in the AR Site
 ;Parameter (#342) file.
 S BEGDT=$$GETRDAY^RCMSITE
 ;If parameter value not greater than 364 day set default to 365 days
 S:BEGDT'>364 BEGDT=365
 ;Set report begin date to past date using Number of Days for DMC reports
 S BEGDT=$$FMADD^XLFDT(DT,0-BEGDT,0,0,0)
 ;
 ;Get the # OF DAYS FOR RD ELIG CHG RPT" site parameter in the AR Site
 ;Parameter (#342) file.
 S RCDAY=$$GETRDDAY^RCMSITE
 ;If parameter value not greater than zero default to 31 days
 S:RCDAY'>0 RCDAY=31
 ;Set RD Beginning Date with RDDAY a negative value
 S RCBEGDT=$$FMADD^XLFDT(DT,0-RCDAY,0,0,0)
 ;Set RD End Date till tomorrow to get all data for today
 S RCENDDT=$$FMADD^XLFDT(DT,+1,0,0,0)
 ;
 D RUN^RCDMCR3A
 Q
 ;
RUN ;Get data and Print it out
 ;If queued ensure you delete it from the TASKS file
 I $D(ZTQUEUED) S ZTREQ="@"
 N RCPAGE
 ;If not passed date, default to get data 365 old
 I $G(BEGDT)'>0 S BEGDT=$$FMADD^XLFDT(DT,-365,0,0,0)
 K ^TMP($J,"RCDMCR3")
 S RCPAGE=0
 ; Collect the data in ^TMP
 D COLLECT^RCDMCR3B(.STOPIT,BEGDT,RCBEGDT,RCENDDT)
 Q:$G(STOPIT)>0
 U IO
 ; Print Report using data in ^TMP
 D REPORT
 I 'RCSCR W !,@IOF
 D ^%ZISC
 K ^TMP($J,"RCDMCR3")
 K EXCEL,RCSCR,TESTDATE
 Q
 ;
REPORT ;Print report
 N RUNDATE,FULLHDR,STATUS,NAME,SSN,CHGDT,RDNAME,RDSEXTRE,BILLNO
 N NAMEPRT,CHGDTPRT,RDPRT
 ;
 S RUNDATE=$$FMTE^XLFDT($$NOW^XLFDT,"9MP")
 ;Print header with field headers
 S FULLHDR=1
 D HDR
 I +$D(^TMP($J,"RCDMCR3"))'>0 W !,"No data meets the criteria." Q
 S NAME=""
 F  S NAME=$O(^TMP($J,"RCDMCR3","DETAIL",NAME)) Q:NAME']""  D  Q:STOPIT
 . S SSN=""
 . F  S SSN=$O(^TMP($J,"RCDMCR3","DETAIL",NAME,SSN)) Q:SSN']""  D  Q:STOPIT
 . . ;NAMEPRT - Use to only print Name & SSN once for multiple Vet RDs
 . . S NAMEPRT=1
 . . S CHGDT=0
 . . F  S CHGDT=$O(^TMP($J,"RCDMCR3","DETAIL",NAME,SSN,CHGDT)) Q:CHGDT'>0  D  Q:STOPIT
 . . . ;CHGDTPRT - Use to only print RD Change Date once for multiple
 . . . ;           RD Change Dates
 . . . S CHGDTPRT=1
 . . . S RDNAME=""
 . . . F  S RDNAME=$O(^TMP($J,"RCDMCR3","DETAIL",NAME,SSN,CHGDT,RDNAME)) Q:RDNAME']""  D  Q:STOPIT
 . . . . S RDSEXTRE=""
 . . . . F  S RDSEXTRE=$O(^TMP($J,"RCDMCR3","DETAIL",NAME,SSN,CHGDT,RDNAME,RDSEXTRE)) Q:RDSEXTRE']""  D  Q:STOPIT
 . . . . . ;CHGDTPRT - Use to only print RD Name once for multiple RD Names
 . . . . . S RDPRT=1
 . . . . . S BILLNO=""
 . . . . . F  S BILLNO=$O(^TMP($J,"RCDMCR3","DETAIL",NAME,SSN,CHGDT,RDNAME,RDSEXTRE,BILLNO)) Q:BILLNO']""  D  Q:STOPIT
 . . . . . . N NODE,CNUM,CLOC,RDLEXTRE,RDORGDT,RXDT,OPTDT,DISCHDT
 . . . . . . N STATUS
 . . . . . . S NODE=$G(^TMP($J,"RCDMCR3","DETAIL",NAME,SSN,CHGDT,RDNAME,RDSEXTRE,BILLNO))
 . . . . . . S CNUM=$P(NODE,U,1),CLOC=$P(NODE,U,2)
 . . . . . . S RDLEXTRE=$P(NODE,U,3)
 . . . . . . S RDORGDT=$P(NODE,U,4)
 . . . . . . S RXDT=$P(NODE,U,5),OPTDT=$P(NODE,U,6)
 . . . . . . S DISCHDT=$P(NODE,U,7)
 . . . . . . S STATUS=$P(NODE,U,8)
 . . . . . . I EXCEL'>0 D WRLINE Q
 . . . . . . I EXCEL>0 D WRLINE2 Q
 ;Don't print summary if user ^ out
 Q:STOPIT
 ;Don't print field headers
 S FULLHDR=0
 ;Ensure Summary data all fits on same page
 D CHKP(9) Q:STOPIT
 W !!,"SUMMARY"
 D ULINE^RCDMCUT2("=",48)
 W !,"Total Number of unique veterans:    ",$J($FN($G(^TMP($J,"RCDMCR3","SUM-VET")),",P"),13)
 W !,"Total Number of Rated Disabilities: ",$J($FN($G(^TMP($J,"RCDMCR3","SUM-RD")),",P"),13)
 W !,"Total Number of Bills:              ",$J($FN($G(^TMP($J,"RCDMCR3","SUM-BILL")),",P"),13)
 ;
 Q
 ;
WRLINE ; Write the data formated report line
 D CHKP() Q:STOPIT
 ;If Multiple Bills for Vet only print Name & SSN for 1st record on page
 W !
 I NAMEPRT>0 D
 . W $E(NAME,1,14)
 . W ?15,SSN
 . W ?21,CNUM
 . W ?32,CLOC
 . S NAMEPRT=0
 I CHGDTPRT>0 D
 . W ?38,$$STRIP^XLFSTR($$FMTE^XLFDT(CHGDT,"8D")," ")
 . S CHGDTPRT=0
 I RDPRT>0 D
 . W ?46,$E(RDNAME,1,29)
 . W ?77,RDSEXTRE
 . W ?81,$$STRIP^XLFSTR($$FMTE^XLFDT(RDORGDT,"8D")," ")
 . S RDPRT=0
 W ?89,BILLNO
 W ?101,$$STRIP^XLFSTR($$FMTE^XLFDT(RXDT,"8D")," ")
 W ?109,$$STRIP^XLFSTR($$FMTE^XLFDT(OPTDT,"8D")," ")
 W ?118,$$STRIP^XLFSTR($$FMTE^XLFDT(DISCHDT,"8D")," ")
 W ?126,$E(STATUS,1,6)
 Q
 ;
WRLINE2 ; Write the Excel report line
 W !
 W NAME_U
 W SSN_U
 W CNUM_U
 W CLOC_U
 W $$FMTE^XLFDT(CHGDT,"9D")_U
 W RDNAME_U
 W RDLEXTRE_U
 W $$FMTE^XLFDT(RDORGDT,"9D")_U
 W BILLNO_U
 W $$FMTE^XLFDT(RXDT,"9D")_U
 W $$FMTE^XLFDT(OPTDT,"9D")_U
 W $$FMTE^XLFDT(DISCHDT,"9D")_U
 W STATUS_U
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
 ;NAMEPRT - Use to print Name & SSN once for multiple Vets RDs per page
 ;CHGDTPRT - Use to print RD Change Date once for multiple RDs per page
 ;RDPRT - Use to print RD Name once for multiple RD names per page
 S NAMEPRT=1,CHGDTPRT=1,RDPRT=1
 S RCPAGE=RCPAGE+1
 W @IOF,"Rated Disability Eligibility Change Report  -- Run Date: ",RUNDATE
 W " -- Episode of Care Data from ",$$FMTE^XLFDT(BEGDT,"9D")
 W ?122,"Page: "_RCPAGE
 W !?5,"RD Change Dates from ",$$FMTE^XLFDT(RCBEGDT,"9D")," to ",$$FMTE^XLFDT(RCENDDT,"9D")
 ;Quit if printing summary data. Don't need field headers
 I FULLHDR'>0 D ULINE^RCDMCUT2("=",$G(IOM)) Q
 ;Print to screen or printer
 I EXCEL'>0 D
 . W !?21,"Claim",?32,"Claim",?38,"RD Chg",?74,"Extre-",?81,"RD Orig",?89,"BILL",?101,"RX Fill",?109,"Outpat",?118,"Dischar"
 . W !,"Veteran Name",?15,"SSN",?21,"Number",?32,"Loc.",?38,"Date",?46,"RD Name",?75,"mity",?81,"Date",?89,"Number",?101,"Date",?109,"Visit Dt",?118,"Date",?126,"Status"
 .  D ULINE^RCDMCUT2("=",$G(IOM))
 ;Export to Delimited Excel format
 I EXCEL>0 D
 . W !,"Veteran Name",U,"SSN",U,"Claim #",U,"Claim Loc",U,"RD Chg Date",U,"RD Name",U,"Extremity",U,"RD Orig Eff Date",U,"Bill #",U,"RX Fill",U,"Oupat Visit Date",U,"Discharge Date",U,"Status"
 Q
 ;
