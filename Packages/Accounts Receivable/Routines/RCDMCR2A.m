RCDMCR2A ;HEC/SBW - DMC Debt Validity Management Report ;9/Oct/2007
 ;;4.5;Accounts Receivable;**253**;Mar 20, 1995;Build 9
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This routine is being implemented for the Hold Debt to DMC Project.
 ;It will do the following:
 ;   A new management report option will be added in AR to assist 
 ;   managers in reviewing the processing of the bills related to 
 ;   the Debt Validity Report. This report will include bills
 ;   for veterans who are SC 50% to 100% or in receipt of VA Pension 
 ;   benefits and have bills for episodes of care within the previous
 ;   365 days (or older selected date). The user will have the option to
 ;   select if the report will be for bills where the DMC Debt Valid
 ;   field is "null", "PENDING", "YES", "NO" or All Values. The report 
 ;   will list only bills with Current Status of "ACTIVE", "OPEN", 
 ;   "SUSPENDED", "CANCELLATION", "REFUND REVIEW" and "REFUNDED".
 ;
MAIN ; Initial Interactive Processing
 N STOPIT,RCSCR,GETBEGDT,BEGDT,RCTYPE,RCDMCVAL
 W !!,"*** Print the DMC Debt Validity Management Report ***"
 W !!,"This report may take a while to process. It is recommended that"
 W !,"you Queue this report to a device that is 132 characters wide."
 ;
 S STOPIT=0 ; quit flag
 ; Prompts to the user:
 ;
 ;Prompt user for Date from which to include bills for episodes of care
 ;on report
 S GETBEGDT=$$GETBEGDT^RCDMCUT2("Report To Include Bills For Episodes of Care Beginning With User Selected Date.","    Entered Date Must be "_$$FMTE^XLFDT($$FMADD^XLFDT(DT,-365,0,0,0),"1D")_" or older!")
 Q:+GETBEGDT'>0
 S BEGDT=$P(GETBEGDT,U,2)
 ;
 S RCTYPE=$$GETTYPE^RCDMCUT2(.STOPIT)
 Q:STOPIT>0!(RCTYPE']"")
 S RCDMCVAL=$$GETDMC^RCDMCUT2(.STOPIT)
 Q:STOPIT>0!(RCDMCVAL']"")
 D:RCTYPE="D"
 . W !?5,"It is recommended that you Queue this report to a"
 . W !?5,"device that is 132 characters wide.",!
 D:RCTYPE="S"
 . W !?5,"It is recommended that you Queue this report to run.",!
 D:RCTYPE="E" EXMSG^RCDMCUT2
 ;
 D DEVICE^RCDMCUT2("RUN^RCDMCR2A","DMC Debt Validity Management Report Process",.STOPIT,.RCSCR,BEGDT,"",RCTYPE,RCDMCVAL)
 Q:STOPIT>0!($D(ZTQUEUED))
 D RUN^RCDMCR2A
 I STOPIT'=2 D PAUSE2^RCDMCUT2
 Q
 ;
QUERPT ; Initial Taskman Scheduled Queued processing
 N STOPIT,RCSCR,RCTYPE,RCDMCVAL,BEGDT
 ;Queued Report option allows print the Detailed report
 ;for all DMC Debt Values
 S STOPIT=0,RCSCR="",RCTYPE="D",RCDMCVAL="A"
 ;
 ;Get the "NUMBER OF DAYS FOR DMC REPORTS" site parameter in the AR Site
 ;Parameter (#342) file.
 S BEGDT=$$GETRDAY^RCMSITE
 ;If parameter value not greater than 364 day set default to 365 days
 S:BEGDT'>364 BEGDT=365
 ;Set report begin date to past date using Number of Days for DMC reports
 S BEGDT=$$FMADD^XLFDT(DT,0-BEGDT,0,0,0)
 ;
 D RUN^RCDMCR2A
 Q
 ;
RUN ;Get data and Print it out
 ;If queued ensure you delete it from the TASKS file
 I $D(ZTQUEUED) S ZTREQ="@"
 N RCPAGE
 ;If not passed date, default to get data 365 old
 I $G(BEGDT)'>0 S BEGDT=$$FMADD^XLFDT(DT,-365,0,0,0)
 K ^TMP($J,"RCDMCR2")
 S RCPAGE=0
 I RCDMCVAL="A" S RCDMCVAL("BLANK/NULL")="",RCDMCVAL("PENDING")="",RCDMCVAL("YES")="",RCDMCVAL("NO")=""
 I RCDMCVAL'="A" S RCDMCVAL($$EXTDMC^RCDMCUT2(RCDMCVAL))=""
 ; Collect the data in ^TMP
 D COLLECT^RCDMCR2B(.STOPIT,BEGDT,.RCDMCVAL)
 Q:$G(STOPIT)>0
 U IO
 ; Print Report using data in ^TMP
 D REPORT
 I 'RCSCR W !,@IOF
 D ^%ZISC
 K ^TMP($J,"RCDMCR2")
 K RCTYPE,RCDMCVAL,RCSCR,TESTDATE
 Q
 ;
REPORT ;Print report
 N RUNDATE,FULLHDR,STATUS,VALID,NAME,SSN,NAMEPRT,BILLNO
 N NODE,CNUM,CLOC,PRINAMT,STATUS,EDITBY,EDITDT
 S FULLHDR=1
 S RUNDATE=$$FMTE^XLFDT($$NOW^XLFDT,"9D")
 ;No report data. Print header and Message. Then quit
 I +$D(^TMP($J,"RCDMCR2"))'>0 S FULLHDR=0 D HDR W !,"No data meets the criteria." Q
 ;Summary Type report for single DMC Debt Valid value.
 ;Print summary data and then quit.
 I RCTYPE="S" D SUMRPT Q
 I RCTYPE="E" S FULLHDR=1 D HDR
 S VALID=""
 F  S VALID=$O(^TMP($J,"RCDMCR2","DETAIL",VALID)) Q:VALID']""  D  Q:STOPIT
 . ;Detailed Report - Print header with field headers when DMC Debt 
 . ;Valid value changes
 . I RCTYPE="D" S FULLHDR=1 D HDR
 . S NAME=""
 . F  S NAME=$O(^TMP($J,"RCDMCR2","DETAIL",VALID,NAME)) Q:NAME']""  D  Q:STOPIT
 . . S SSN=""
 . . F  S SSN=$O(^TMP($J,"RCDMCR2","DETAIL",VALID,NAME,SSN)) Q:SSN']""  D  Q:STOPIT
 . . . ;NAMEPRT - Use to only print Name & SSN once for multiple bills
 . . . S NAMEPRT=1
 . . . S BILLNO=""
 . . . F  S BILLNO=$O(^TMP($J,"RCDMCR2","DETAIL",VALID,NAME,SSN,BILLNO)) Q:BILLNO']""  D  Q:STOPIT
 . . . . S NODE=$G(^TMP($J,"RCDMCR2","DETAIL",VALID,NAME,SSN,BILLNO))
 . . . . S CNUM=$P(NODE,U,1),CLOC=$P(NODE,U,2),PRINAMT=$P(NODE,U,3)
 . . . . S STATUS=$P(NODE,U,4),EDITBY=$P(NODE,U,5),EDITDT=$P(NODE,U,6)
 . . . . I RCTYPE="D" S FULLHDR=1 D WRLINE Q
 . . . . I RCTYPE="E" S FULLHDR=0 D WRLINE2 Q
 . ;Print Summary for DMC Debt Valid if printing all DMC Debt Valid 
 . ;values on Detailed report
 . I RCTYPE="D",RCDMCVAL="A" D
 . . D VALSUM
 . . ;Pause Prompt when print to Screen and more Patient Data
 . . I RCSCR,$O(^TMP($J,"RCDMCR2","DETAIL",VALID))]"" D PAUSE^RCDMCUT2
 S FULLHDR=0
 D TOTSUM
 Q
 ;
 ;
WRLINE ; Write the data formated report line
 D CHKP() Q:STOPIT
 ;If Multiple Bills for Vet only print Name & SSN for 1st record on page
 W !
 I NAMEPRT>0 D
 . W $E(NAME,1,20)
 . W ?22,SSN
 . W ?30,CNUM
 . W ?42,CLOC
 . S NAMEPRT=0
 W ?50,BILLNO
 W ?63,$J("$"_$FN($P(PRINAMT,".",1),",P"),12)
 W ?77,$E(STATUS,1,13)
 W ?93,$E(EDITBY,1,20)
 W ?115,$$FMTE^XLFDT(EDITDT,"9D")
 Q
 ;
WRLINE2 ; Write the Excel report line
 W !
 W NAME_U
 W SSN_U
 W CNUM_U
 W CLOC_U
 W BILLNO_U
 W PRINAMT_U
 W VALID_U
 W STATUS_U
 W EDITBY_U
 W $$FMTE^XLFDT(EDITDT,"9D")
 Q
 ;
CHKP(FOOTER) ;Check for End of Page
 ;Input
 ;  FOOTER - Footer value. Optional. Default to 4 if nothing passed
 I $G(FOOTER)'>0 S FOOTER=4
 I $Y>(IOSL-FOOTER) D:RCSCR PAUSE^RCDMCUT2 Q:STOPIT  D HDR
 Q
 ;
HDR ;Print Report Header
 ;NAMEPRT - Use to only print Name & SSN once for multiple bills
 S NAMEPRT=1
 S RCPAGE=RCPAGE+1
 ;Header for Detailed and Excel Delimited format (132 Chars wide)
 D:RCTYPE="D"!(RCTYPE="E")
 . W @IOF,"DMC Debt Validity Management ",$$EXTTYPE^RCDMCUT2(RCTYPE)," Report"
 . W ?53,"Run Date: ",RUNDATE
 . W ?78,"Episode of Care Data from ",$$FMTE^XLFDT(BEGDT,"9D")
 . W ?120,"Page: "_RCPAGE
 ;Header for Summary Format (80 chars wide
 D:RCTYPE="S"
 . W @IOF,"DMC Debt Validity Management ",$$EXTTYPE^RCDMCUT2(RCTYPE)," Report"
 . W ?70,"Page: "_RCPAGE
 . W !,"Run Date: ",RUNDATE
 . W ?30,"Episode of Care Data from ",$$FMTE^XLFDT(BEGDT,"9D")
 ;
 W !?5,"DMC Debt Valid Field Values = ",$$EXTDMC^RCDMCUT2(RCDMCVAL)
 ;Print Underline for Summary Report header and Summary Data Header
 I RCTYPE="S"!((RCTYPE="D")&(FULLHDR'>0)) D
 . D ULINE^RCDMCUT2("=",$G(IOM))
 ;Quit if printing summary data. Don't need field headers
 Q:FULLHDR'>0
 ;Print Detail Report header
 I RCTYPE="D" D
 . W !?30,"Claim",?42,"Claim",?50,"Bill",?65,"Receivable",?93,"DMC Debt Valid",?115,"DMC Debt Valid"
 . W !,"Veteran Name",?22,"SSN",?30,"Number",?42,"Loc.",?50,"Number",?65,"Amount",?77,"Status",?93,"Edit By",?115,"Edit Date"
 . D ULINE^RCDMCUT2("=",$G(IOM))
 . I RCDMCVAL="A" W !,"***  Following data is for DMC Debt Valid Field Values of ",VALID,"  ***"
 ;Print Excel Delimited format header
 I RCTYPE="E" D
 . W !,"Veteran Name",U,"SSN",U,"Claim #",U,"Claim Loc",U,"Bill #",U,"DMC Debt Valid",U,"Amount",U,"STATUS",U,"DMC Debt Valid Edit By",U,"DMC Debt Valid Edit Date"
 Q
 ;
SUMRPT ;Print Summary report (No detailed data)
 S FULLHDR=0
 D HDR
 ;If not all DMC Debt Values then just print Total Summary and quit
 I RCDMCVAL'="A" D TOTSUM Q
 ;If DMC Debt Valid Report is for all values then print summary by DMC
 ;Debt Valid value and then the Total Summary for all DMC Debt Valid 
 ;values.
 S VALID=""
 F  S VALID=$O(^TMP($J,"RCDMCR2","DETAIL",VALID)) Q:VALID']""  D  Q:STOPIT
 . D VALSUM
 D TOTSUM
 Q
 ;
TOTSUM ;Print Total Summary
 N STAT
 ;Don't print summary if user ^ out
 Q:STOPIT
 ;Don't print field headers
 S FULLHDR=0
 D CHKP() Q:STOPIT
 W !
 ;At bottom of page need to get 3 lines of Summary Total display
 D CHKP(7) Q:STOPIT
 W !,"SUMMARY TOTAL - ",$$EXTDMC^RCDMCUT2(RCDMCVAL)
 D ULINE^RCDMCUT2("-",65)
 W !,"Total Number of Bills:",?53,$J($FN($G(^TMP($J,"RCDMCR2","TOT","BILL")),",P"),13)
 D CHKP() Q:STOPIT
 W !,"Total Number of unique veterans:",?53,$J($FN($G(^TMP($J,"RCDMCR2","TOT","VET")),",P"),13)
 D CHKP() Q:STOPIT
 W !,"Total Account Receivable Dollars:",?53,$J("$"_$FN($P($G(^TMP($J,"RCDMCR2","TOT","$")),".",1),",P"),13)
 ;Get summary data for each Status
 S STAT=""
 F  S STAT=$O(^TMP($J,"RCDMCR2","TOT-STAT",STAT)) Q:STAT']""  D  Q:STOPIT
 . D CHKP() Q:STOPIT
 . W !,"Total Number of unique ",STAT," Bill Status:",?53,$J($FN($G(^TMP($J,"RCDMCR2","TOT-STAT",STAT)),",P"),13)
 Q
 ;
VALSUM ;Print Summary Total by DMC Debt Valid value
 ;Don't print summary if user ^ out
 Q:STOPIT
 D CHKP() Q:STOPIT
 W !
 ;At bottom of page need to get 3 lines of Summary Total display
 D CHKP(7) Q:STOPIT
 W !,"SUMMARY TOTAL FOR DMC Debt Valid = ",VALID
 D ULINE^RCDMCUT2("-",75)
 W !,"Total Number of Bills (",VALID,"):",?63,$J($FN($G(^TMP($J,"RCDMCR2","SUM",VALID,"BILL")),",P"),13)
 D CHKP() Q:STOPIT
 W !,"Total Number of unique veterans (",VALID,"):",?63,$J($FN($G(^TMP($J,"RCDMCR2","SUM",VALID,"VET")),",P"),13)
 D CHKP() Q:STOPIT
 W !,"Total Account Receivable Dollars (",VALID,"):",?63,$J("$"_$FN($P($G(^TMP($J,"RCDMCR2","SUM",VALID,"$")),".",1),",P"),13)
 ;Get summary data for each Current Status
 S STAT=""
 F  S STAT=$O(^TMP($J,"RCDMCR2","SUM-STAT",VALID,STAT)) Q:STAT']""  D  Q:STOPIT
 . D CHKP() Q:STOPIT
 . W !,"Total Number of unique ",STAT," Bill Status (",VALID,"):",?63,$J($FN($G(^TMP($J,"RCDMCR2","SUM-STAT",VALID,STAT)),",P"),13)
 Q
