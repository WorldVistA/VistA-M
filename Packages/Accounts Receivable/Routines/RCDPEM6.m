RCDPEM6 ;OIFO-BAYPINES/RBN - DUPLICATE EFT DEPOSITS AUDIT REPORTS ;8/14/11 3:20pm
 ;;4.5;Accounts Receivable;**276**;Mar 20, 1995;Build 87
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; General read access of IB EOB file #361.1 is allowed from AR by IA 4051
 Q
 ;
 ; DESCRIPTION: The following generates an audit report that dislays all EFTs
 ;              that have been removed by the user.  The user must select
 ;              a date range to limit the number of EFTs displayed.
 ;
 ; INPUTS:  The user is prompted for the Date/Time range
 ;
 ; OUTPUTS: A report which displays EFTs that have been removed.  The report has the following
 ;          headings:
 ;          * Trace number
 ;          * Payer name
 ;          * Deposit number
 ;          * Date removed
 ;          * User
 ;          * Justification for removal
 ;
 ; LOCAL VARIABLES: RCEXCEL - Display/print/Excel flag.
 ;                  RCPAGE - Current page number of the report.
 ;                  RCRANGE - Three ^ pieces:
 ;                            1:Dates provided successfully - 1 (Yes), 0 (No)
 ;                            2:Start Date for report
 ;                            3:End Date for report
 ;                  RCSTOP - User Requests Abort (1)
 ;                  FileMan- Several standard FileMan variables (v.gr. DIR,DIC,etc..
 ;                  Misc.  - X, Y, I and other used for counters and temp values.
 ;
 ; GLOBALS: ^RCY(344.31 - EDI THIRD PARTY EFT DETAIL file (#344.31).
 ;          ^TMP($J,"RCDPEM6",LINE #) - Report data (body of report).  Data structure:
 ;
 ;           DEPOSIT NUMBER^PAYER^TRACE NUMBER^AMOUNT^DATE REMOVED^USER^JUSTIFICATION
 ;
EN1 ; Main entry point for EFT Audit Report
 N RCRANGE,RCEXCEL,RCPAGE,Y,RCSTOP,I,START,END,ZTDESC,ZTRTN,ZTSAVE
 S (RCPAGE,RCSTOP)=0
 S RCRANGE=$$DTRNG^RCDPEM4()
 I RCRANGE=0 G EXIT
 S RCEXCEL=$$DISPTY^RCDPEM3() G:+RCEXCEL=-1 EXIT
 ;Display capture information for Excel
 I RCEXCEL D INFO
 ;Select output device
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="ENREM^RCDPEM6"
 . S ZTDESC="Duplicate EFT Deposits Report"
 . S ZTSAVE("RC*")="",ZTSAVE("VAUTD")=""
 . D ^%ZTLOAD
 . I $D(ZTSK) W !!,"Your task number "_ZTSK_" has been queued."
 . E  W !!,"Unable to queue this job."
 . K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 ;
ENREM ;
 D REPORT
 D DISPLAY(RCEXCEL)
 D EXIT
 Q
 ;
REPORT ; Generate the report ^TMP array
 ; INPUTS :  None
 ; LOCAL VARIABLES:
 ;  DTIEN    - IEN of EFT from "E" index (date/time)
 ;  START    - Start date of report date range
 ;  END      - End date of report date range
 ;  EFTIEN   - IEN of EFT
 ;
 N DTIEN,EFTIEN,X1,X2,X,Y
 K ^TMP($J,"RCDPEM6")
 S (DTIEN,EFTIEN)=""
 S END=$P(RCRANGE,U,3),START=$P(RCRANGE,U,2)
 I $P($G(RCRANGE),U,1) D
 . S DTIEN=$P(RCRANGE,U,1)-1
 . F  S DTIEN=$O(^RCY(344.31,"E",DTIEN)) Q:'DTIEN  D
 .. S EFTIEN=$O(^RCY(344.31,"E",DTIEN,EFTIEN)) Q:'EFTIEN
 .. Q:'$D(^RCY(344.31,EFTIEN,3))
 .. I (START'>DTIEN\1)&(DTIEN\1'>END) D
 .. . D PROC(EFTIEN)
 .. S EFTIEN=""
 I '$P($G(RCRANGE),U,1) D
 . F  S DTIEN=$O(^RCY(344.31,"E",DTIEN)) Q:'DTIEN  D
 .. S EFTIEN=$O(^RCY(344.31,"E",DTIEN,EFTIEN)) Q:'EFTIEN
 .. Q:'$D(^RCY(344.31,EFTIEN,3))
 .. D PROC(EFTIEN)
 .. S EFTIEN=""
 Q
 ;
DISPLAY(RCEXCEL) ; Format the display for screen/printer or MS Excel
 ; INPUTS  : RCEXCEL -  Display/print/Excel flag.
 ; RETURNS : Nothing - builds the actual report
 ; LOCAL VARIABLES:
 ;  IEN - line number of the data in ^TMP (see above)
 ;  DATE - Date/Time report was run for header
 ;  CNT - Count of EFT Deposits removed
 ;  DATA - Data stored in ^TMP($J,"DUPLICATE EFT",IEN)
 ;
 N IEN,CNT,DATE,LINE,DATA
 S IEN="",CNT=0,DATE=$$NOW()
 D HDR(RCEXCEL)
 F  S IEN=$O(^TMP($J,"DUPLICATE EFT",IEN)) Q:'IEN!RCSTOP  D
 . S CNT=CNT+1
 . S DATA=^TMP($J,"DUPLICATE EFT",IEN)
 . I 'RCEXCEL D
 .. I $Y>(IOSL-5) D HDR(RCEXCEL) Q:RCSTOP
 .. W ?1,$P(DATA,U,1)
 .. W ?16,$P(DATA,U,3),!
 .. W ?6,$P(DATA,U,2),!
 .. W ?16,$J($P(DATA,U,4),0,2)
 .. W ?28,$P(DATA,U,5)
 .. W ?50,$E($P(DATA,U,6),1,25),!
 .. D WP($P(DATA,U,7)) W !
 . I RCEXCEL D
 .. W DATA,!
 I 'RCEXCEL D
 . W !,?1,"Total number of duplicates removed: "_CNT,!
 . W !,?1,"*** END OF REPORT ***",!
 Q
 ;
PROC(EFTIEN) ;  Put the actual data into the ^TMP global based on filters.
 ; INPUTS   : EFTIEN = ien of the EFT in question
 ; RETURNS  : Nothing - Builds each entry in the ^TMP global
 ; LOCAL VARIABLES :
 ; DTRTN  - Date EFT returned
 ; JUST   - Justification for returning EFT
 ; TRACE  - Trace number of the EFT
 ; AMT    - Total amount of the EFT
 ; PAYER  - EFT payer
 ; USER   - User who completed the return EFT transaction
 ; DEPO   - Deposit # of EFT deposit
 ;
 N DTRTN,JUST,TRACE,AMT,PAYER,USER,Y,DEPO,DATA0,DATA3,Z
 S DATA0=$G(^RCY(344.31,EFTIEN,0))
 S DATA3=$G(^RCY(344.31,EFTIEN,3))
 S USER=$P(DATA3,U,1),USER=$$NAME^XUSER(USER,"F")
 S DTRTN=$$FMTE^XLFDT($P(^RCY(344.31,EFTIEN,3),U,2),2)
 S JUST=$P(DATA3,U,3)
 S PAYER=$P(DATA0,U,2) S:PAYER="" PAYER="UNKNOWN"
 S TRACE=$P(DATA0,U,4),AMT=$P(DATA0,U,7)
 S Z=$P(DATA0,U)
 S:Z]"" DEPO=$P($G(^RCY(344.3,Z,0)),U,6)
 S:'$G(DEPO) DEPO="UNKNOWN"
 S ^TMP($J,"DUPLICATE EFT",EFTIEN)=DEPO_"^"_PAYER_"^"_TRACE_"^"_AMT_"^"_DTRTN_"^"_USER_"^"_JUST
 Q
 ;
HDR(RCEXCEL) ; Print the report header
 ; INPUTS   : RCEXCEL - Display/print/Excel flag
 ; RETURNS  : Nothing - Displays the report header to the screen formated for type of output selected
 I 'RCEXCEL D  Q  ;Print report header
 . I RCPAGE D ASK^RCDPEM3(.RCSTOP,0) Q:RCSTOP
 . S RCPAGE=RCPAGE+1
 . W @IOF
 . W ?18,"Duplicate EFT Deposits - Audit Report",?66,"Page "_RCPAGE,!
 . W ?24,"Run Date: "_DATE,!
 . W ?14,"Date Range: ",$$FMTE^XLFDT(START,2)," - ",$$FMTE^XLFDT(END,2)," (DATE EFT REMOVAL)",!!
 . W ?1,"Deposit#",?16,"Trace #",!
 . W ?6,"Payer Name",?28,"Date/Time",?50,"User Who",!
 . W ?16,"Amount",?28,"Removed",?50,"Removed",!
 . W ?1,"===============================================================================",!
 ;Otherwise, print Excel header
 W "DEPOSIT NUMBER^PAYER^TRACE NUMBER^AMOUNT^DATE REMOVED^USER^JUSTIFICATION",!
 Q
 ;
EXIT ; Gracefully exit
 ; Kills of any remaining variables
 D ^%ZISC
 K X,^TMP($J,"DUPLICATE EFT"),STNAM,POP,%ZIS,Y,VAUTD
 Q
 ;
INFO ;Useful Info for Excel capture
 W !!!,?10,"Before continuing, please set up your terminal to capture the"
 W !,?10,"report data as this report may take a while to run."
 W !!,?10,"To avoid  undesired  wrapping of the data  saved to the"
 W !,?10,"file, please enter '0;256;999' at the 'DEVICE:' prompt."
 W !!,?10,"It may be necessary to set up the terminal display width"
 W !,?10,"to 256 characters which can be performed by selecting the"
 W !,?10,"Display option located within the 'Setup' menu on the"
 W !,?10,"tool bar of the terminal emulation software (e.g. KEA,"
 W !,?10,"Reflections or Smarterm).",!!
 Q
 ;
WP(A) ; Pretty print the justification comments
 ; INPUTS   : A - Justification text
 ; RETURNS  : NOTHING
 ; LOCAL VARIABLES :
 ;                 B - Character length of the justification comment
 ;                 C - Number of words in the justification comment
 ;                 I - Loop counter
 ;                 J - Line counter
 ;                 LINE - Justification text to be displayed
 I A="" Q
 N B,C,I,J,LINE
 S B=$L(A),C=$L(A," "),J=1
 S LINE(J)="Justification Comments: "
 F I=1:1:C D
 . I $L(LINE(J))+$L($P(A," ",I))>72 D
 .. S J=J+1,LINE(J)="                        "
 . S LINE(J)=LINE(J)_" "_$P(A," ",I)
 S LINE(0)=J
 F I=1:1:LINE(0) W ?1,LINE(I),!
 Q
 ;
NOW()  ;Returns current date/time in format mm/dd/yy@hh:mm:ss
 N Y,%
 D NOW^%DTC
 S Y=$$FMTE^XLFDT(%,2)
 Q Y
