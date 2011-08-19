PRSPBRP ;WOIFO/MGD - PTP BEGIN RECONCILIATION OF MEMORANDUM ;01/29/07
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; The following routine will allow HR to begin the reconciliation
 ; process for a memorandum that has expired or been terminated.  
 ; After the PT Physician is selected a summary screen will be
 ; displayed to verify that the correct memo is selected.
 ; Then a list of the reconciliation choices will be displayed and HR
 ; will either print the reconciliation process or they will e-mail it
 ; to the PT Physician.
 ;
 Q
 ;
MAIN ; Prompt for Part Time Physician
 S QUIT=0
 F  D  I QUIT D KILL Q
 . S PRSIEN=""
 . D PTP^PRSPRM
 . I PRSIEN<1 S QUIT=1 Q
 . D DRIVER
 . K ^TMP($J,"PRSPBRP")
 Q
 ;
DRIVER ; Main Driver
 ;
 ; Find any memorandums that meet the begin reconciliation qualifications
 D MEM
 Q:'MIEN
 ; Display employee and memorandum information
 D DISPLAY
 Q:$D(DIRUT)
 ; Display any outstanding PP ESRs
 D ESRCHK^PRSPRM
 ; Display Summary information
 D SUM
 Q:$D(DIRUT)
 ; Reconciliation Options
 D ROPT
 ; Prompt for Print or E-mail
 D ASK2
 Q:ASK2="^"!($G(POP))
 ; Prompt for E-sig and update file
 D ESIG
 Q
 ;
MEM ; Find any memorandums that meet the begin reconciliation qualifications
 ;
 N ENDAT,INDX,MEM,STDAT
 S MEM=0,INDX=1
 F  S MEM=$O(^PRST(458.7,"B",PRSIEN,MEM)) Q:'MEM  D
 . S DATA0=$G(^PRST(458.7,MEM,0))  ; Memo info
 . S DATA4=$G(^PRST(458.7,MEM,4)) ; Termination info
 . Q:DATA0=""
 . S STATUS=$P(DATA0,U,6)
 . Q:STATUS'=2  ; Recently ended memos would still be in status of 2
 . S STDAT=$P(DATA0,U,2)
 . S ENDAT=$P(DATA0,U,3)
 . S TDAT=$P(DATA4,U,1)
 . I TDAT,TDAT>DT Q  ; Termination Date has yet to occur
 . I TDAT S ENDAT=TDAT ; Set ENDAT to Termination Date
 . Q:TDAT=""&(ENDAT>DT)  ; Not Terminated and End Date has yet to occur
 . S MEM(INDX)=MEM_"^"_STDAT_"^"_ENDAT_"^ACTIVE"
 . S INDX=INDX+1
 ; If no memos meet the reconciliation qualifications
 I '$D(MEM(1)) D  Q
 . W !!,"No memorandums meet the reconciliation qualifications for the "
 . W "selected employee."
 . S MIEN=0
 ; If only one memo
 I '$D(MEM(2)) S MIEN=$P(MEM(1),U,1) Q
 ; Display list if more than one
 I $D(MEM(2)) D
 . W !!,"# ",?5,"STARTS          ENDS"
 . F MEM=1:1 Q:'$D(MEM(MEM))  D
 . . S DATA=MEM(MEM)
 . . S Y=$P(DATA,U,2)
 . . D DD^%DT
 . . S START=Y
 . . S Y=$P(DATA,U,3)
 . . D DD^%DT
 . . S END=Y
 . . W !,MEM,?5,START,"    ",END
 . ;
ASK . ; Ask user to select which memorandum they want
 . S END="",END=$O(MEM(END),-1)
 . W !!,"Enter a number between 1 and ",END," :"
 . R ASK:DTIME
 . S ASK=$$UPPER^PRSRUTL(ASK)
 . I ASK=""!(ASK="^") S MIEN=0 Q
 . I '$D(MEM(ASK)) D  G ASK
 . . W !!,"Enter a number between 1 and ",END," or ^ to exit"
 . S MIEN=$P(MEM(ASK),U,1)
 . S DATA0=$G(^PRST(458.7,MIEN,0))  ; Memo info
 . S DATA4=$G(^PRST(458.7,MIEN,4))  ; Termination info
 Q
 ;
DISPLAY ; Display memorandum info to validate the correct employee was chosen
 W:$E(IOST,1,2)="C-" @IOF
 S SCRTTL=" PT Physician Begin Reconciliation Process",INDX=1
 S ARRAY="^TMP($J,""PRSPBRP"","
 D HDR^PRSPUT1(PRSIEN,SCRTTL,ARRAY,1)
 D MEM^PRSPUT1(PRSIEN,MIEN,ARRAY)
 D AL^PRSPUT3(PRSIEN,ARRAY)
 D PPSUM^PRSPUT2(PRSIEN,MIEN,ARRAY)
 S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR
 Q
 ;
SUM ; Display Summary information - Screen #2
 D INDEX^PRSPUT1 ; Get last index
 S TEXT=""
 D A1^PRSPUT1
 N AHRS,AMT,COHRS,DATA0,ENDSTA,POMC,PPREM,RATE,SALARY,SPAA
 N THW,TOTNP,TOTWP
 S PPREM=$P($$MEMCPP^PRSPUT3(MIEN),U,2) ; Determine # PP already worked
 S PPREM=26-PPREM               ; Pay Periods REMaining
 S DATA0=$G(^PRST(458.7,MIEN,0))
 S AHRS=$P(DATA0,U,4)   ; Agreed Hours
 S COHRS=$P(DATA0,U,9)  ; Carryover Hours
 S COHRS=$G(COHRS,"0.00")
 S THW=$P(DATA0,U,10)   ; Total Hours Worked
 S TOTNP=$P(DATA0,U,12) ; Total NonPay Hours
 I TOTNP="" S TOTNP="0.00"
 S TOTWP=$P(DATA0,U,13) ; Total Without Pay Hours
 I TOTWP="" S TOTWP="0.00"
 S POMC=+$P(DATA0,U,14)  ; % of Memo Completed
 S POT=+$P(DATA0,U,17)   ; % Off Target
 S TEXT="    Percent Completed: "_$J(POMC,6,2)
 D A1^PRSPUT1 ; Screen 2, Line 3
 S OTHRS=AHRS/26*(26-PPREM)-TOTNP-TOTWP ; Hrs that should've been worked
 S OTHRS=THW+COHRS-OTHRS ; Off Target HouRS
 S TEXT="     Off Target Hours: "_$J(OTHRS,6,2)
 D A1^PRSPUT1 ; Screen 2, Line 4
 S TEXT="Off Target Percentage: "_$J(POT,6,2)
 D A1^PRSPUT1 ; Screen 2, Line 5
 D A1^PRSPUT1 ; Screen 2, Line 6
 S TEXT="        Non Pay Hours: "_$J(TOTNP,6,2)
 D A1^PRSPUT1 ; Screen 2, Line 7
 S TEXT="    Without Pay Hours: "_$J(TOTWP,6,2)
 D A1^PRSPUT1 ; Screen 2, Line 8
 S TEXT="      Carryover Hours: "_$J(COHRS,6,2)
 D A1^PRSPUT1,A1^PRSPUT1 ; Screen 2, Line 9
 ; Calculate amount owed
 S SALARY=$P($G(^PRSPC(PRSIEN,0)),U,29)   ; Salary
 S SPAA=$P($G(^PRSPC(PRSIEN,"T38")),U,24) ; Special Pay Annual Amount
 S RATE=SALARY+SPAA/2080
 S RATE=$J(RATE,0,2)
 S AMT=$J(OTHRS*RATE,6,2)
 S TEXT="Estimated Gross Amount Owed "
 S ENDSTA=$S(OTHRS>0:"Over",OTHRS<0:"Under",1:"Even")
 S TEXT=TEXT_$S(ENDSTA="Over":"PTP",1:"VA")_": "_AMT
 D A1^PRSPUT1 ; Screen 2, Line 10
 S TEXT="                 Ending Status: "_$J(ENDSTA,6)
 D A1^PRSPUT1 ; Screen 2,
 W !
 S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR
 Q
 ;
ROPT ; Reconciliation Options
 ;
 I $E(IOST,1,2)="C-" W @IOF
 W $P(^PRSPC(PRSIEN,0),U,1)_" - Memorandum Summary"
 D A1^PRSPUT1 ; Screen 2, Line 8 - Blank line
 S TEXT="Reconciliation Options:"
 D A1^PRSPUT1 ; Screen 2, Line 9
 ; PTP worked less than Agreed Hours
 ;I POT<-5.00 D  Q
 I POT<0 D  Q
 . S TEXT="Pay VA for negative balance"
 . S MEM(1)=TEXT_U_3
 . S TEXT="1. "_TEXT
 . D A1^PRSPUT1 ; Screen 2, Line 10
 ;
 ; PTP worked more than Agreed Hours
 ; CO policy removed I POT>5.00 D  Q
 I POT>0 D  Q
 . S TEXT="Pay Phy for positive balance"
 . S MEM(1)=TEXT_U_5
 . S TEXT="1. "_TEXT
 . D A1^PRSPUT1 ; Screen 2, Line 10
 ;
 ; PTP worked Agreed Hours exactly
 I POT=0 D  Q
 . S TEXT="No reconciliation needed"
 . S MEM(1)=TEXT_U_1
 . S TEXT="1. "_TEXT
 . D A1^PRSPUT1 ; Screen 2, Line 10
 ;
 ;***************************************************************
 ;PRS*4*93: BEGIN comment out carry over options--during testing
 ;policy was changed to not allow ptp to carry over hours within
 ;5% of agreement.
 ;***************************************************************
 ;; Within 5% of Agreed Hours
 ;; Check for next memorandum
 ;S OLDMIEN=MIEN
 ;S NMIEN=+$$MIEN^PRSPUT1(PRSIEN)
 ;S MIEN=OLDMIEN
 ;I 'NMIEN D
 ;. S TEXT="No current Memorandum on file.  Transfer not possible."
 ;. D A1^PRSPUT1
 ;. S TEXT="If applicable, exit and enter a new memorandum first."
 ;. D A1^PRSPUT1
 ;;
 ;; Negative Balance Options
 ;I POT<0 D
 ;. S TEXT="Pay VA for negative balance"
 ;. S MEM(1)=TEXT_U_3
 ;. S TEXT="1. "_TEXT
 ;. D A1^PRSPUT1 ; Screen 2, Line 12
 ;I NMIEN,POT<0 D
 ;. S TEXT="Transfer negative balance"
 ;. S MEM(2)=TEXT_U_2
 ;. S TEXT="2. "_TEXT
 ;. D A1^PRSPUT1 ; Screen 2, Line 11
 ;;
 ;; Postive Balance Options
 ;I POT>0 D
 ;. S TEXT="Pay PT Phy for positive balance"
 ;. S MEM(1)=TEXT_U_5
 ;. S TEXT="1. "_TEXT
 ;. D A1^PRSPUT1 ; Screen 2, Line 12
 ;I NMIEN,POT>0 D
 ;. S TEXT="Transfer positive balance"
 ;. S MEM(2)=TEXT_U_4
 ;. S TEXT="2. "_TEXT
 ;. D A1^PRSPUT1 ; Screen 2, Line 11
 ;;finish the remainder of the form
 ;D A1^PRSPUT1 ; Blank Line
 ;S TEXT="Enter Reconciliation Option: _____"
 ;D A1^PRSPUT1
 ;D A1^PRSPUT1 ; Blank Line
 ;S $P(DASH,"_",55)="_"
 ;S TEXT="Reconciliation Comments: "_DASH
 ;D A1^PRSPUT1 ; Reconciliation Comments Line #1
 ;D A1^PRSPUT1 ; Blank Line
 ;S DASH="",$P(DASH,"_",80)="_"
 ;S TEXT=DASH
 ;D A1^PRSPUT1 ; Reconciliation Comments Line #2
 ;D A1^PRSPUT1 ; Blank Line
 ;S TEXT=DASH
 ;D A1^PRSPUT1 ; Reconciliation Comments Line #3
 ;D A1^PRSPUT1 ; Blank Line
 ;D A1^PRSPUT1 ; Reconciliation Comments Line #4
 ;S DASH="",$P(DASH,"_",41)="_"
 ;S TEXT="Signature: "_DASH
 ;S DASH="",$P(DASH,"_",20)="_"
 ;S TEXT=TEXT_"  Date: "_DASH
 ;D A1^PRSPUT1
 ;**********************************
 ;END of comment out carry over options
 ;**********************************
 Q
 ;
ASK2 ; Prompt to e-mail or print.
 ;
 W !!,"Would you like to use a (H)ard copy or (E)lectronic reconciliation form: "
 R ASK2:DTIME
 S ASK2=$$UPPER^PRSRUTL(ASK2)
 Q:ASK2="^"
 I "^H^E^"'[("^"_ASK2_"^") D  G ASK2
 . W !!,"Enter H or E or ^ to Quit."
 Q
 ;
ESIG ; Prompt for Electronic Signature and store fields in #458.7
 ;
 N ESOK
 D ^PRSAES
 I 'ESOK K ^TMP($J,"PRSPBRP") Q
 ;
DEV I ASK2="H" D  Q:POP
 . K IOP,%ZIS
 . S %ZIS("A")="Select Device: ",%ZIS="MQ"
 . W !
 . D ^%ZIS
 . K %ZIS,IOP
 . I $D(IO("Q")) D  Q   ; Queued
 ..  S ZTDESC="PRS PTP BEGIN RECONCILE PROC"
 ..  S ZTRTN="PRINT^PRSPBRP"
 ..  S ZTSAVE("^TMP($J,""PRSPBRP"",")=""
 ..  D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued!",1:"Request Canceled!")
 ..  K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 ..  D HOME^%ZIS
 . U IO
 . D PRINT,^%ZISC
 . K %ZIS,IOP
 ; Update STATUS or memorandum
 S MIEN=MIEN_",",PRSFDA(458.7,MIEN,5)=3
 D UPDATE^DIE("","PRSFDA","MIEN"),MSG^DIALOG()
 W !!,"Memorandum Status updated to: RECONCILIATION STARTED",!
 K ^TMP($J,"PRSPBRP")
 Q
 ;
PRINT ; Print the paper version of the Reconciliation form
 ;
 S INDEX=""
 F  S INDEX=$O(^TMP($J,"PRSPBRP",INDEX)) Q:'INDEX  D
 . S TEXT=^TMP($J,"PRSPBRP",INDEX)
 . W !,TEXT
 K ^TMP($J),TEXT
 Q
 ;
KILL ; Clean up variables
 ;
 K AMT,ARRAY,ASK,ASK2,COHRS,D1,DASH,DATA,DATA0,DATA4,DAY,DIR,DIRUT
 K END,ENDSTA,INDEX,INDX,MEM,MIEN,NMIEN,NPHRS,OLDMIEN,OTHRS
 K POP,POT,PPI,PPCNT,PPREM,PRSAPGM,PRSIEN,PRSFDA,QUIT,RATE,SALARY
 K SCRTTL,SPAA,START,STATUS,TDAT,TDATE,WPHRS,ZTSAVE,X,Y
 K ^TMP($J,"PRSPBRP")
 Q
