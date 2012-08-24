RCDPEM3 ;OIFO-BAYPINES/RBN - ERA AUDIT REPORT and return EFT function ;8/15/11 11:26am
 ;;4.5;Accounts Receivable;**276,284**;Mar 20, 1995;Build 35
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; General read access of IB EOB file #361.1 is allowed from AR (IA 4051)
 Q
 ;
 ; PRCA*4.5*284 - Changed report name from 'Mark ERA returned to Payer' to 'Remove ERA from active worklist'
 ;
 ; DESCRIPTION : The following generates an audit report that displays all ERAs
 ;               that have been removed from the worklist.  The user can select
 ;               several filters with which to limit the number of ERAs displayed:
 ;                 * Station/Division - the default is all.
 ;                 * Date Range       - the default is all.
 ;                 * Start Date       - no default, P:Date removed from worklistr;R:Date ERA Received;B:Both Dates.
 ;                 
 ; INPUTS      : The user is prompted for the Station/Division.
 ;               The user is prompted for the Date/Time range
 ;               The user is prompted for the Start Date.
 ;
 ; OUTPUTS     : A report which displays returned ERAs.  The report has the following
 ;               headings:
 ;                 * User name - The name of the user who performed the transaction.
 ;                 * Date/Time ERA received from the payer.
 ;                 * Date/Time ERA removed from worklist.
 ;                 * Freetext justification for returning the ERA to payer.
 ;                 * ERA number.
 ;                 * Trace number.
 ;                 * Dollar amount of ERA.
 ;                 * Payer name.
 ;
 ; LOCAL VARIABLES: RCNAME   - Name of user who performed transaction.
 ;                  RCDTRV   - Date/time ERA was received from payer.
 ;                  RCDTMK   - Date/time ERA was marked as removed
 ;                  RCJUST   - Justification for removal of ERA from EEOB worklist (free text).
 ;                  RCERA    - The ERA number.
 ;                  RCTRACE  - The ERA trace number.
 ;                  RCTOT    - Total dollar amount of the ERA.
 ;                  RCPNAM   - Payer name of the ERA.
 ;                  RCSTDIV  - Station/Division.
 ;                  RCDTRNG  - Date/Time range of report (an array: range_flag^start_date^end_date).
 ;                  RCDISP   - Display/print/Excel flag.
 ;                  RCPAGE   - Current page number of the report.
 ;                  RCPRB    - Selected Start Date (W:Date Removed from Worklsit;R:Date ERA Received;B:Both Dates).
 ;                  FileMan  - Several standard FileMan variables (v.gr. DIR,DIC,etc..
 ;                  Misc.    - X, Y, I and other used for counters and temp values.
 ;
 ; GLOBALS        : ^RCY(344.4 - ELECTRONIC REMITTANCE ADVICE file (#344.4).
 ;                  ^TMP($J,"RCDPEM3",LINE #) - Report data (body of report).  Data structure:
 ;      
 ; STATION NAME^STATION #^TRACE #^PAYER^DEPOSIT #^DATE REMOVED^USER^REMOVE REASON^ERA #^ERA DATE^T0TAL AMOUNT
 ;
EN ; Main entry point for ERA Audit Report
 N RCDTRNG,RCRANGE,RCDIV,RCSTA,RCDISP,RCPAGE,STANUM,STANAM,RCSTART,RCEND,RCSTOP,RCPG,RCIND,I,RCSTN,RCPRB
 N %ZIS,POP,VAUTD,ZTDESC,ZTRTN,ZTSAVE
 ;
 S (RCSTART,RCEND,RCSTOP,RCPG,RCPRB)=0
 S RCRANGE="0^^"
 S RCDTRNG=0
 S RCPAGE=0
 S RCIND=1
 ; PRCA*4.5*276 - Modify Header display
 S RCDIV="ALL"
 S RCPRB=$$DTPRB^RCDPEM4()
 I RCPRB=0 G EXIT
 S RCRANGE=$$DTRNG^RCDPEM4()
 I RCRANGE=0 G EXIT
 S RCSTART=$P(RCRANGE,U,2),RCEND=$P(RCRANGE,U,3)
 D DIVISION^VAUTOMA Q:Y=-1
 I 'VAUTD&($D(VAUTD)'=11) G EXIT
 I VAUTD=0 D
 .S (I,RCDIV)="" F  S I=$O(VAUTD(I)) Q:'I  S RCDIV=RCDIV_", "_VAUTD(I)
 .S RCDIV=$E(RCDIV,3,$L(RCDIV))
 .Q
 S RCDISP=$$DISPTY() G:+RCDISP=-1 EXIT
 I $D(DUOUT)!$D(DTOUT) G EXIT
 I RCDISP D INFO^RCDPEM6
 S:'VAUTD RCIND=RCIND+1
 S:$P($G(RCRANGE),U)>0 RCIND=RCIND+3
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="ENRPT^RCDPEM3"
 . S ZTDESC="ERA's Removed from Active Worklist Audit Report"
 . S ZTSAVE("RC*")="",ZTSAVE("VAUTD")=""
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task number "_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 ;
ENRPT ;
 D REPRT
 D DISP(RCDISP)
 D EXIT
 Q
 ;
DISPTY() ; Get display/output type
 ; INPUTS   : User input from keyboard
 ; RETURNS  : Output destination (0=Display; 1=MS Excel)
 ; LOCAL VARIABLES :
 ; DIR,DUOUT - Standard FileMan variables
 ; Y         - User input
 N DIR,DUOUT,Y
 S DIR(0)="Y"
 S DIR("A")="EXPORT THE REPORT TO Microsoft Excel (Y/N): "
 S DIR("B")="NO"
 D ^DIR K DIR
 I $D(DUOUT)!$D(DIRUT) S Y=-1
 Q Y
 ;
ERASTA(ERAIEN) ; Get the station for this ERA (ERAIEN = ien of the ERA in question)
 ; INPUTS :  ERAIEN - ien of the ERA in question.
 ; LOCAL VARIABLES:
 ; ERAEOB  - EOB corresponding to the ERA
 ; ERABILL - Bill corresponding to the ERA
 ; STA     - IEN of the Station of the ERA, or -1 if not found
 N ERAEOB,ERABILL,STA,STNAM,STNUM
 S (ERAEOB,ERABILL,STA,STNAM,STNUM)=""
 S STA=-1,STNUM=""
 I ERAIEN D
 . S ERAEOB=$P($G(^RCY(344.4,ERAIEN,1,1,0)),U,2) Q:'ERAEOB
 . S ERABILL=$P($G(^IBM(361.1,ERAEOB,0)),U,1) Q:'ERABILL
 . S STA=$P(^DGCR(399,ERABILL,0),U,22) Q:'STA
 . S STNAM=$$EXTERNAL^DILFD(399,.22,,STA)
 . S STNUM=$P($G(^DG(40.8,STA,0)),U,2) ;IA 417
 S:$G(STNAM)="" STNAM="UNKNOWN",STNUM="UNKNOWN"
 S STNAM=STNAM_"^"_STNUM
 Q STNAM
 ;
REPRT ; Generate the report ^TMP array
 ; INPUTS : None
 ; LOCAL VARIABLES:
 ; DTIEN  - IEN of ERA from "E" index (date/time)
 ; DTERA  - Date ERA received
 ; START  - Start date of report date range
 ; END    - End date of report date range
 ; ERAIEN - IEN of ERA
 ; STANAM - Name of Station/Division
 ; STANUM - Station/Division number
 ; RCPRB  - Start date (W:Date Removed from Worklist;R:Date ERA Received;B:Both Dates)
 N DTIEN,START,END,ERAIEN,X1,X2,X,DTERA
 K ^TMP($J,"RCDPEM3")
 S (DTIEN,ERAIEN)=""
 ; If user picked W:Date Removed from Worklist OR B:Both Dates, use index "AD"
 I (RCPRB="W")!(RCPRB="B") D
 . S DTIEN=$P(RCRANGE,U,1)
 . S END=$P(RCRANGE,U,3)
 . S START=$P(RCRANGE,U,2)
 . F  S DTIEN=$O(^RCY(344.4,"AD",DTIEN)) Q:'DTIEN!(DTIEN\1>END)  D
 . . F  S ERAIEN=$O(^RCY(344.4,"AD",DTIEN,ERAIEN)) Q:'ERAIEN  D
 . . . Q:'$D(^RCY(344.4,ERAIEN,6))
 . . . I (START'>DTIEN\1)&(DTIEN\1'>END) D PROC(ERAIEN)
 ; If user picked R:Date ERA Received OR B:Both Dates, use index "AC"
 S (DTIEN,ERAIEN)=""
 I (RCPRB="R")!(RCPRB="B") D
 . S END=$P(RCRANGE,U,3)
 . S START=$P(RCRANGE,U,2)
 . F  S DTIEN=$O(^RCY(344.4,"AC",DTIEN)) Q:'DTIEN  D
 . . F  S ERAIEN=$O(^RCY(344.4,"AC",DTIEN,ERAIEN)) Q:'ERAIEN  D
 . . . Q:'$D(^RCY(344.4,ERAIEN,6))
 . . . Q:$D(^TMP($J,"RCDPEM3",$P(^RCY(344.4,ERAIEN,0),U,1)))  ;data is in ^TMP global
 . . . S DTERA=$P($G(^RCY(344.4,ERAIEN,0)),U,4)\1 Q:'DTERA 
 . . . I START>DTERA Q
 . . . I END<DTERA Q
 . . . D PROC(ERAIEN)
 Q
 ;
DISP(RCDISP) ; Format the display for screen/printer or MS Excel
 ; INPUTS  : RCDISP -  Display/print/Excel flag.
 ; RETURNS : Nothing - builds the actual report
 ; LOCAL VARIABLES: IEN - line number of the data in ^TMP (see above)
 N IEN,LEN,RCNAM
 D HDR(RCDISP)
 S IEN=0
 ; PRCA*4.5*276 - Modify Display
 F  S IEN=$O(^TMP($J,"RCDPEM3",IEN)) Q:'IEN!RCSTOP  D
 . I 'RCDISP D
 . . W !
 . . I $Y>(IOSL-5) D HDR(RCDISP) Q:RCSTOP
 . . ; W $P(^TMP($J,"RCDPEM3",IEN),U,2),! Trace#
 . . W $P(^TMP($J,"RCDPEM3",IEN),U,3) ;ERA
 . . W ?15,$P(^TMP($J,"RCDPEM3",IEN),U,2),! ; Payer Name
 . . W ?5,$P(^TMP($J,"RCDPEM3",IEN),U,4)
 . . W ?29,$P(^TMP($J,"RCDPEM3",IEN),U,5) ; Date Time Removed
 . . W ?46,$P(^TMP($J,"RCDPEM3",IEN),U,6) ; ERA Rec
 . . S RCNAM=$P(^TMP($J,"RCDPEM3",IEN),U,7) ; Tot Paid
 . . W ?58,$E(RCNAM,1,19),! ; User who removed
 . . S A=$P(^TMP($J,"RCDPEM3",IEN),U,8)
 . . D WP(A)
 . I RCDISP D
 . . W !,^TMP($J,"RCDPEM3",IEN)
 W !
 W !,"******** END OF REPORT ********",!
 Q
 ;
PROC(ERAIEN) ;  Put the actual data into the ^TMP global based on filters.
 ; INPUTS : ERAIEN  - ERAIEN = ien of the ERA in question
 ; RETURNS: Nothing - Builds each entry in the ^TMP global
 ; LOCAL VARIABLES :
 ; ERAEOB - EOB corresponding to this ERA
 ; RCDIV  - Name of station
 ; STNUM  - Station number
 ; DTERA  - Date of ERA
 ; DTRTN  - Date ERA removed from worklist
 ; JUST   - Justification for removal of ERA
 ; TRACE  - Trace number of the ERA
 ; AMT    - Total amount of the ERA
 ; PAYER  - ERA payer
 ; USER   - User who completed the removal of the ERA from the worklist
 ; Y      - Used for time conversion
 ; DEPO   - Amount of ERA deposit
 N STATION,ERAEOB,DTERA,DTRTN,JUST,TRACE,AMT,PAYER,USER,Y,DEPO,ERA,RCLOCDV,PAYER
 S RCSTA=$$ERASTA(ERAIEN)
 I $P(RCSTA,U)=-1 S RCSTA="UNKNOWN",RCSTN="UNKNOWN"
 E  S RCSTN=$P(RCSTA,U,2),RCSTA=$P(RCSTA,U,1)
 ; PRCA*4.5*276 - Modify Display
 Q:RCDIV'[RCSTA&(RCDIV'="ALL")
 S ERAEOB=$P($G(^RCY(344.4,ERAIEN,1,1,0)),U,2)
 S Y=$P(^RCY(344.4,ERAIEN,0),U,4)
 S DTERA=$$FMTE^XLFDT(Y,"2D")
 S USER=$P(^RCY(344.4,ERAIEN,6),U,1)
 S USER=$$NAME^XUSER(USER,"F")
 S Y=$P(^RCY(344.4,ERAIEN,6),U,2)
 ; D DD^%DT
 S DTRTN=$$FMTE^XLFDT(Y,2)
 S JUST=$P(^RCY(344.4,ERAIEN,6),U,3)
 S ERA=$P(^RCY(344.4,ERAIEN,0),U,1)
 S TRACE=$P(^RCY(344.4,ERAIEN,0),U,2)
 S AMT=$P(^RCY(344.4,ERAIEN,0),U,5)
 S PAYER=""
 S:ERAEOB PAYER=$P($G(^IBM(361.1,ERAEOB,0)),U,2)
 S:ERAEOB&($G(PAYER)) PAYER=$$EXTERNAL^DILFD(361.1,.02,,PAYER)
 I '$D(PAYER)!(PAYER="") S PAYER="UNKNOWN"
 S DEPO=$P($G(^RCY(344.1,ERAIEN,0)),U,8)
 S:DEPO DEPO=$P($G(^RCY(344,DEPO,0)),U,6)
 S:DEPO DEPO=$P($G(^RCY(344.1,DEPO,0)),U,1)
 S:'$G(DEPO) DEPO="UNKNOWN"
 ; PRCA*4.5*276 - Remove Trace# from Excel
 S ^TMP($J,"RCDPEM3",ERA)=RCSTA_"^"_PAYER_"^"_ERA_"^"_DTRTN_"^"_DTERA_"^"_AMT_"^"_USER_"^"_JUST
 Q
 ;
HDR(RCDISP) ; Print the report header
 ; INPUTS   : RCDISP - Display/print/Excel flag
 ; RETURNS  : Nothing - Displays the report header to the screen formatted for type of output selected
 ; LOCAL VARIABLES :
 ; MSG  - Array containing the header data.
 ; DATE - The date of the report
 ; Y,%  - Used for date conversion
 N MSG,DATE,Y,%,Z,END,START
 S END=$P(RCRANGE,U,3)
 S START=$P(RCRANGE,U,2)
 ; PRCA*4.5*284 - Modify headers
 I 'RCDISP D
 . I RCPAGE D ASK(.RCSTOP,0) Q:RCSTOP
 . S RCPAGE=RCPAGE+1
 . D NOW^%DTC
 . S Y=%
 . S DATE=$$FMTE^XLFDT(Y,2)
 . W @IOF
 . W "                                                                                "
 . S Z="             ERAs Removed from Active Worklist - Audit Report            Page "_RCPAGE
 . W $J("",80-$L(Z)\2),Z,!
 . S Z="DIVISIONS: "_RCDIV W $J("",80-$L(Z)\2),Z,!
 . S Z="Run Date/Time:  "_DATE W $J("",80-$L(Z)\2),Z,!
 . S Z="DATE RANGE: "_$P($$FMTE^XLFDT(START,2),"@")_" - "_$P($$FMTE^XLFDT(END,2),"@")
 . S Z=Z_" ("_$S(RCPRB="B":"Received & Removed",RCPRB="W":"Date Removed from Worklist",1:"Date ERA Received")_")"
 . W $J("",80-$L(Z)\2),Z,!
 . W !
 . W "ERA#           Payer Name",!
 . W "    Date/Time                Date ERA         Total Amt   User Who",!
 . W "    Removed                  Received         Paid        Removed",!
 . W "================================================================================"
 I RCDISP D
 . W "STATION NAME^PAYER^ERA NUMBER^DATE REMOVED^DATE RECEIVED^AMOUNT^USER^REMOVED REASON"
 Q
 ;
PAUSE ;  Pause the display until the user presses enter/return
 ; Straight FileMan call and variables - See FileMan documentation
 N DIR,DUOUT
 S DIR(0)="E"
 D ^DIR K DIR
 I $D(DUOUT) G EXIT
 Q
 ;
EXIT ; Gracefully exit
 ; Kills off any remaining variables and resets output device
 ;
 D ^%ZISC
 K X,STNAM,STNUM,^TMP($J,"RCDPEM3")
 Q
 ;
WP(A,T) ; Pretty print the justification comments
 ; INPUTS   : A - Justification text
 ; RETURNS  : Nothing - Displays the justification comments on display nicely formatted
 ;
 K ^UTILITY($J,"W")
 N JUST,X,DIWL,DIWR,DIWF
 S JUST=A
 ; PRCA*4.5*284- Change 'Justification Comments' to 'Removed Reason'
 ;
 W "Removed Reason:  "
 I $L(JUST)<62 W JUST,!
 E  D
 . S X=JUST,DIWL=18,DIWR=78,DIWF="W"
 . D ^DIWP,^DIWW
 Q
 ;
RETN ; Entry point for remove EFT
 N DIR,X,Y,DTOUT,DIC,RCY,DIE,DA,DR,MSG,%,RCYDISP
 D OWNSKEY^XUSRB(.MSG,"RCDPE REMOVE DUPLICATES",DUZ)
 I 'MSG(0) W !,"SORRY, YOU ARE NOT AUTHORIZED TO USE THIS OPTION",! S DIR(0)="E" D ^DIR K DIR Q
 W !!,"          WARNING: REMOVING AN EFT IS **NOT** REVERSIBLE"
 W !,"  USE THIS OPTION ONLY IF YOU ARE SURE YOU WANT TO REMOVE THIS EFT."
 W !,"PLEASE BE AWARE THAT ONCE AN EFT IS REMOVED --- IT CANNOT BE RESTORED.",!!
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Are you sure you want to continue"
 D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT)!'Y Q
 S DIC="^RCY(344.31,"
 S DIC(0)="AEMQ",DIC("S")="I '$P(^(0),U,8)"
 D ^DIC K DIC
 S RCY=+Y
 Q:RCY=-1
 S RCYDISP=$P(^RCY(344.31,RCY,0),U) ; Get the actual EFT number
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("A",1)="THIS WILL MARK THE EFT # "_+RCYDISP_" AS REMOVED"
 S DIR("A")="ARE YOU SURE YOU WANT TO CONTINUE?: "
 W !
 D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT)!(Y=0) D NOCHNG Q
 S DIE="^RCY(344.31,",DA=RCY,DR=".19" D ^DIE
 I $D(Y) D NOCHNG Q
 D NOW^%DTC S DR=".08////1;.17////"_DUZ_";.18////"_% D ^DIE
 W !!
 S DIR(0)="EA"
 S DIR("A")="PRESS RETURN TO CONTINUE"
 S DIR("A",1)="EFT # "_RCYDISP_" HAS BEEN MARKED AS REMOVED"
 D ^DIR
 Q
 ;
ASK(STOP,MODE) ; Ask to continue
 ; If passed by reference ,RCSTOP is returned as 1 if print is aborted
 I $E(IOST,1,2)'["C-" Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S:MODE DIR("A")="Enter RETURN to finish"
 S DIR(0)="E" W ! D ^DIR K DIR
 I ($D(DIRUT))!($D(DUOUT)) S STOP=1 Q
 Q
 ;
TEXT ; Filtered by messages
 ;;No Filters Applied
 ;;Station/Division
 ;;
 ;;Date Range
 ;;Station/Division, Date Range
 ;;Payer
 ;;Station/Division, Payer
 ;;
 ;;Date Range, Payer
 ;;Station/Division, Date Range, Payer
 Q
 ;
NOCHNG ;
 N DIR,X,Y,DTOUT,DUOUT
 S DIR(0)="EA"
 S DIR("A")="PRESS RETURN TO CONTINUE: "
 S DIR("A",1)="***  This EFT was NOT Removed."
 W !! D ^DIR
 Q
