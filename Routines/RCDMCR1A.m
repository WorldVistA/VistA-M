RCDMCR1A ;HEC/SBW - DMC Debt Validity Report  ;28/SEP/2007
 ;;4.5;Accounts Receivable;**253**;Mar 20, 1995;Build 9
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This routine is being implemented for the Hold Debt to DMC Project.
 ;It will do the following:
 ;   Report option in AR to assist users in focusing on reviewing the 
 ;   legitimacy of bills for veterans who are SC 50% to 100% or in
 ;   receipt of VA Pension benefits. The report contains information
 ;   on veterans who meet the above criteria and have bills for episodes
 ;   of care within the previous 365 days (or older selected date) with
 ;   a DMC Debt Valid field not flagged as 'YES' or 'NO'. Authorized 
 ;   billing staff can run the report to ensure that all bills meeting 
 ;   the above criteria are  reviewed and if necessary the appropriate 
 ;   action is taken as follows:
 ;        Bill is appropriate - Update the Debt Validity Status field to
 ;            'YES' in order that the bill is referred to DMC via the 
 ;            automated process if all other DMC criteria is met
 ;        Bill is inappropriate - Update the Debt Validity Status Field
 ;            to 'NO' and staff will cancel the bill using existing 
 ;            functionality
 ;        Inappropriate bill sent to DMC - Staff to initiate action to
 ;            cancel DMC collection or refund payments using existing 
 ;            functionality
 ;
MAIN ; Initial Interactive Processing
 N STOPIT,GETBEGDT,BEGDT,EXCEL,RCSCR
 W !!,"*** Print the Debt Validity Report ***"
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
 S EXCEL=$$EXCEL^RCDMCUT2()
 ;Quit if user Up Arrowed or Timed Out
 Q:EXCEL="^"
 D:EXCEL>0 EXMSG^RCDMCUT2
 D:EXCEL'>0
 . W !!,"This report may take a while to process. It is recommended that"
 . W !,"you Queue this report to a device that is 132 characters wide."
 ;
 D DEVICE^RCDMCUT2("RUN^RCDMCR1A","DMC Debt Validity Report Process",.STOPIT,.RCSCR,BEGDT,EXCEL)
 Q:STOPIT>0!($D(ZTQUEUED))
 D RUN^RCDMCR1A
 I STOPIT'=2 D PAUSE2^RCDMCUT2
 Q
 ;
QUERPT ; Initial Taskman Scheduled Queued processing
 N STOPIT,EXCEL,RCSCR,BEGDT
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
 D RUN^RCDMCR1A
 Q
 ;
RUN ;Get data and Print it out
 ;If queued ensure you delete it from the TASKS file
 I $D(ZTQUEUED) S ZTREQ="@"
 N RCPAGE
 ;If not passed date, default to get data 365 old
 I $G(BEGDT)'>0 S BEGDT=$$FMADD^XLFDT(DT,-365,0,0,0)
 K ^TMP($J,"RCDMCR1")
 S RCPAGE=0
 ; Collect the data in ^TMP
 D COLLECT^RCDMCR1B(.STOPIT,BEGDT)
 Q:$G(STOPIT)>0
 U IO
 ; Print Report using data in ^TMP
 D REPORT
 I 'RCSCR W !,@IOF
 D ^%ZISC
 K ^TMP($J,"RCDMCR1")
 K EXCEL,RCSCR,TESTDATE
 Q
 ;
REPORT ;Print report
 N RUNDATE,FULLHDR,STATUS,IEN,NAME,SSN,NAMEPRT,BILLNO,NODE
 N CNUM,CLOC,ELIG,ELIGDT,RXDT,OPTDT,DISCHDT,DMCREFDT,DMCVALID
 S RUNDATE=$$FMTE^XLFDT($$NOW^XLFDT,"9MP")
 ;Print header with field headers
 S FULLHDR=1
 D HDR
 I +$D(^TMP($J,"RCDMCR1"))'>0 W !,"No data meets the criteria." Q
 S NAME=""
 F  S NAME=$O(^TMP($J,"RCDMCR1","DETAIL",NAME)) Q:NAME']""  D  Q:STOPIT
 . S SSN=""
 . F  S SSN=$O(^TMP($J,"RCDMCR1","DETAIL",NAME,SSN)) Q:SSN']""  D  Q:STOPIT
 . . ;NAMEPRT - Use to only print Name & SSN once for multiple bills
 . . S NAMEPRT=1
 . . S BILLNO=""
 . . F  S BILLNO=$O(^TMP($J,"RCDMCR1","DETAIL",NAME,SSN,BILLNO)) Q:BILLNO']""  D  Q:STOPIT
 . . . S NODE=$G(^TMP($J,"RCDMCR1","DETAIL",NAME,SSN,BILLNO))
 . . . S CNUM=$P(NODE,U,1),CLOC=$P(NODE,U,2),ELIG=$P(NODE,U,3)
 . . . S ELIGDT=$P(NODE,U,4),RXDT=$P(NODE,U,5),OPTDT=$P(NODE,U,6)
 . . . S DISCHDT=$P(NODE,U,7),DMCREFDT=$P(NODE,U,8),DMCVALID=$P(NODE,U,9)
 . . . S STATUS=$P(NODE,U,10)
 . . . I EXCEL'>0 D WRLINE Q
 . . . I EXCEL>0 D WRLINE2 Q
 ;Don't print summary if user ^ out
 Q:STOPIT
 ;Don't print field headers
 S FULLHDR=0
 ;Ensure all Summary data fits on page
 D CHKP(9) Q:STOPIT
 W !!,"SUMMARY - BILLS REFERRED TO DMC"
 D ULINE^RCDMCUT2("-",55)
 W !,"Total Number of Bills Referred:            ",$J($FN($G(^TMP($J,"RCDMCR1","SUM-BILL")),",P"),13)
 W !,"Total Number of unique veterans referred:  ",$J($FN($G(^TMP($J,"RCDMCR1","SUM-VET")),",P"),13)
 W !,"Total Account Receivable Dollars referred: ",$J("$"_$FN($G(^TMP($J,"RCDMCR1","SUM-$")),",P"),13)
 ;Ensure all Summary data fits on page
 D CHKP(9) Q:STOPIT
 W !!,"SUMMARY - TOTAL BILLS"
 D ULINE^RCDMCUT2("-",46)
 W !,"Total Number of Bills:            ",$J($FN($G(^TMP($J,"RCDMCR1","TOT-BILL")),",P"),13)
 W !,"Total Number of unique veterans:  ",$J($FN($G(^TMP($J,"RCDMCR1","TOT-VET")),",P"),13)
 W !,"Total Account Receivable Dollars: ",$J("$"_$FN($G(^TMP($J,"RCDMCR1","TOT-$")),",P"),13)
 ;
 Q
 ;
WRLINE ; Write the data formated report line
 D CHKP() Q:STOPIT
 ;If Multiple Bills for Vet only print Name & SSN for 1st record on page
 W !
 I NAMEPRT>0 D
 . W $E(NAME,1,16)
 . W ?18,SSN
 . W ?25,CNUM
 . W ?37,CLOC
 . W ?44,ELIG
 . Q:ELIGDT>0
 . S NAMEPRT=0
 W ?60,BILLNO
 W ?73,$$STRIP^XLFSTR($$FMTE^XLFDT(RXDT,"8D")," ")
 W ?83,$$STRIP^XLFSTR($$FMTE^XLFDT(OPTDT,"8D")," ")
 W ?92,$$STRIP^XLFSTR($$FMTE^XLFDT(DISCHDT,"8D")," ")
 W ?101,DMCVALID
 W ?110,$E(STATUS,1,9)
 W ?121,$$STRIP^XLFSTR($$FMTE^XLFDT(DMCREFDT,"8D")," ")
 I NAMEPRT>0,ELIGDT>0 W !?44,$$STRIP^XLFSTR($$FMTE^XLFDT(ELIGDT,"8D")," ") S NAMEPRT=0
 Q
 ;
WRLINE2 ; Write the Excel report line
 W !
 W NAME_U
 W SSN_U
 W CNUM_U
 W CLOC_U
 W ELIG_U
 W $$FMTE^XLFDT(ELIGDT,"9D")_U
 W BILLNO_U
 W $$FMTE^XLFDT(RXDT,"9D")_U
 W $$FMTE^XLFDT(OPTDT,"9D")_U
 W $$FMTE^XLFDT(DISCHDT,"9D")_U
 W DMCVALID_U
 W STATUS_U
 W $$FMTE^XLFDT(DMCREFDT,"9D")
 Q
 ;
CHKP(FOOTER) ;Check for End of Page
 ;INPUT
 ;  FOOTER - Footer value. Optional. Default to 4 if nothing passed
 I $G(FOOTER)'>0 S FOOTER=4
 I $Y>(IOSL-FOOTER) D:RCSCR PAUSE^RCDMCUT2 Q:STOPIT  D HDR
 Q
 ;
HDR ;Print Report Header
 ;NAMEPRT - Use to only print Name & SSN once for multiple bills
 S NAMEPRT=1
 S RCPAGE=RCPAGE+1
 W @IOF,"DMC Debt Validity Report"
 W ?40,"Run Date: ",RUNDATE
 W ?72,"Episode of Care Data from ",$$FMTE^XLFDT(BEGDT,"9D")
 W ?115,"Page: "_RCPAGE
 ;If summary data print underline and quit. Don't need field headers.
 I FULLHDR'>0 D ULINE^RCDMCUT2("=",$G(IOM)) Q
 ;Print to screen or printer
 I EXCEL'>0 D
 . W !!?25,"Claim",?37,"Claim",?44,"Eligibility/",?60,"Bill",?73,"RX Fill/",?83,"Outpat",?92,"Dischar",?101,"DMC Debt",?121,"DMC Ref"
 . W !,"Veteran Name",?18,"SSN",?25,"Number",?37,"Loc.",?44,"SC Eff. Date",?60,"Number",?73,"ReFill Dt",?83,"Visit Dt",?92,"Date",?101,"Valid",?110,"Status",?121,"Date"
 . D ULINE^RCDMCUT2("=",$G(IOM))
 ;Export to Delimited Excel format
 I EXCEL>0 D
 . W !!,"Veteran Name",U,"SSN",U,"Claim #",U,"Claim Loc",U,"Eligibility",U,"SC Eff Date",U,"Bill #",U,"RX Fill",U,"Outpat Visit Date",U,"Discharge Date",U,"DMC Debt Valid",U,"Status",U,"DMC Refer Date"
 Q
 ;
