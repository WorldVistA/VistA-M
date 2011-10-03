PRSPRM ;WOIFO/MGD - PTP RECONCILE MEMORANDUM ;04/20/05
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; The following routine will allow HR to complete the reconciliation
 ; process for a memorandum that has expired or been terminated.
 ;
 Q
 ;
MAIN ; Main Driver
 ;
 K ^TMP($J,"PRSPRM")
 ; Prompt for Part Time Physician
 D PTP
 I Y'>0 D KILL^PRSPRM1 Q
 S PRSIEN=+Y
 ; Find any memorandums that meet the reconciliation qualifications
 S QUIT=""
 D MEM
 I 'MIEN D KILL^PRSPRM1 Q
 I QUIT D KILL^PRSPRM1 Q
 ; Display employee and memorandum information
 D DISPLAY
 I $D(DIRUT) D KILL^PRSPRM1 Q
 ; Verify that all daily ESRs are completed
 D ESRCHK
 I QUIT D KILL^PRSPRM1 Q
 ; Display Summary information
 D SUM^PRSPBRP
 I $D(DIRUT) D KILL^PRSPRM1 Q
 ; Display Reconciliation Options
 D ROPT^PRSPBRP
 ; Check for Reconciliation choice entered electronically
 D PTPCHK^PRSPRM1
 ; Prompt HR for Reconciliation Choice
 D HRRC^PRSPRM1
 I RO="^" D KILL^PRSPRM1 Q
 ; Prompt for PTP Reconciliation Comments if Paper form was used
 D PTPRCOM^PRSPRM1
 I X="^" D KILL^PRSPRM1 Q
 ; Prompt to transfer balance to current memorandum
 D TRNS^PRSPRM1
 I QUIT D KILL^PRSPRM1 Q
 ; Prompt HR for any final reconciliation comments
 D HRCOM^PRSPRM1
 I X="^" D KILL^PRSPRM1 Q
 ; Prompt HR is they want to print the form for the Chief of Staff
 S QUIT=0
 D PRT^PRSPRM1
 I QUIT D KILL^PRSPRM1 Q
 ; Prompt for E-sig and update file
 D ESIG^PRSPRM1,KILL^PRSPRM1
 Q
 ;
PTP ; Prompt for Part Time Physician
 ;
 W !
 S DIC="^PRSPC(",DIC(0)="AEMQZ",DIC("A")="Select EMPLOYEE: "
 S DIC("S")="I $D(^PRST(458.7,""B"",+Y))"
 D ^DIC K DIC
 S PRSIEN=+Y
 Q
 ;
MEM ; Find any memorandums that meet the reconciliation qualifications
 ;
 N ENDAT,MEM,STDAT
 S MEM=0,INDX=1
 F  S MEM=$O(^PRST(458.7,"B",PRSIEN,MEM)) Q:'MEM  D
 . D MEMDAT(MEM,.STATUS,.STDAT,.ENDAT,.TDAT)
 . Q:STATUS'=3  ; Memos that have begun reconciliation have status = 3
 . I $G(TDAT)>DT Q  ; Termination Date has yet to occur
 . Q:TDAT<1&(ENDAT>DT)  ; Not Terminated and End Date has yet to occur
 . S MEM(INDX)=MEM_"^"_STDAT_"^"_ENDAT_"^"_TDAT_"^"_"Reconciliation Started"
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
 . S MIEN=0
 . W !!," # ",?5,"STARTS",?20,"ENDS",?35,"TERMINATION DATE"
 . F MEM=1:1 Q:'$D(MEM(MEM))  D
 . . S DATA=MEM(MEM)
 . . S Y=$P(DATA,U,2)
 . . D DD^%DT
 . . S START=Y
 . . S Y=$P(DATA,U,3)
 . . D DD^%DT
 . . S END=Y
 . . S Y=$P(DATA,U,4)
 . . I Y'="" D
 . . . D DD^%DT
 . . . S TDAT=Y
 . . W !,MEM,?5,START,?20,END,?35,TDAT
 . ;
ASK . ; Ask user to select which memorandum they want
 . S END="",END=$O(MEM(END),-1)
 . W !!,"Enter a number between 1 and ",END," :"
 . R ASK:DTIME
 . S ASK=$$UPPER^PRSRUTL(ASK)
 . Q:ASK=""!(ASK="^")
 . I '$D(MEM(ASK)) D  G ASK
 . . W !!,"Enter a number between 1 and ",END," or ^ to exit"
 . S MIEN=$P(MEM(ASK),U,1)
 . S DATA0=$G(^PRST(458.7,MIEN,0))  ; Memo info
 . S DATA4=$G(^PRST(458.7,MIEN,4))  ; Termination info
 Q
 ;
MEMDAT(MEM,MST,MSD,MED,MTD) ;
 ;RETURN MST- memo start date
 ;       MSD- memo stop date
 ;       MED- memo termination date
 N DATA0,DATA4
 S DATA0=$G(^PRST(458.7,MEM,0))  ; Memo info
 S DATA4=$G(^PRST(458.7,MEM,4)) ; Termination info
 S MST=$P(DATA0,U,6)
 S MSD=$P(DATA0,U,2)
 S MED=$P(DATA0,U,3)
 S MTD=$P(DATA4,U,1)
 Q
DISPLAY ; Display memorandum info to validate the correct employee was chosen
 W:$E(IOST,1,2)="C-" @IOF
 S SCRTTL=" PT Physician Reconcile Memorandum"
 S ARRAY="^TMP($J,""PRSPRM"","
 D HDR^PRSPUT1(PRSIEN,SCRTTL,ARRAY,1)
 D MEM^PRSPUT1(PRSIEN,MIEN,ARRAY)
 D AL^PRSPUT3(PRSIEN,ARRAY)
 D PPSUM^PRSPUT2(PRSIEN,MIEN,ARRAY)
 S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR
 Q
 ;
ESRCHK ; Check for any incomplete ESR within the memoranda.
 ;
 N PPDATA,TPPI
 D INDEX^PRSPUT1 ; Get last index
 W:$E(IOST,1,2)="C-" @IOF
 W $P(^PRSPC(PRSIEN,0),U,1)_" - Memorandum Summary"
 S QUIT=0
 S TPPI=""
 I TDAT'="" D
 . S DATA4=$G(^PRST(458.7,MIEN,4))
 . Q:'+DATA4
 . S TPPI=+$G(^PRST(458,"AD",$P(DATA4,U,1)))
 F I=1:1:26 D
 . S PPDATA=$G(^PRST(458.7,MIEN,9,I,0))
 . S PPE=$P(PPDATA,U,1)
 . Q:PPE=""
 . S PPI=$O(^PRST(458,"B",PPE,0))
 . Q:'PPI
 . Q:PPI>TPPI  ; Quit if PP is after termination PP
 . F DAY=1:1:14 D  Q:QUIT
 . . S ESRSTAT=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",DAY,7)),U,1)
 . . I ESRSTAT<5 S ^TMP($J,"RG",PPE)=""
 . ; Check for NP in Pay Period
 . I $P(PPDATA,U,3) S ^TMP($J,"NP",PPE)=$P(PPDATA,U,3)
 . ; Check for WP in Pay Period
 . I $P(PPDATA,U,4) S ^TMP($J,"WP",PPE)=$P(PPDATA,U,4)
 I $D(^TMP($J,"RG"))=10 D
 . S TEXT="The following Pay Periods have days with incomplete daily ESRs: "
 . D A1^PRSPUT1
 . S (PPE,PPEX)="",PPCNT=0
 . F  S PPE=$O(^TMP($J,"RG",PPE)) Q:PPE=""  D
 . . S PPEX=$S(PPEX="":PPE,1:PPEX_", "_PPE)
 . . S PPCNT=PPCNT+1
 . . I PPCNT>10 D
 . . . S TEXT=PPEX,PPCNT=0,PPEX=""
 . . . D A1^PRSPUT1
 . I PPCNT>0 D
 . . S TEXT=PPEX
 . . D A1^PRSPUT1
 . S TEXT=""
 . D A1^PRSPUT1
 . S TEXT="These will have to be completed before the memorandum can be reconciled."
 . D A1^PRSPUT1,A1^PRSPUT1
 ;
NP ; Check for Non-Pay hours
 I $D(^TMP($J,"NP"))=10 D
 . S TEXT="The following Pay Periods have Non-Pay hours:"
 . D A1^PRSPUT1
 . S PPE="",PPCNT=0,PPEX=""
 . F  S PPE=$O(^TMP($J,"NP",PPE)) Q:'PPE  D
 . . S PPEX1=PPE_" - "_^TMP($J,"NP",PPE),$E(PPEX1,15)=""
 . . S PPEX=PPEX_PPEX1
 . . S PPCNT=PPCNT+1
 . . I PPCNT>4 D
 . . . S TEXT=PPEX,PPCNT=0,PPEX=""
 . . . D A1^PRSPUT1
 . I PPCNT>0 D
 . . S TEXT=PPEX
 . . D A1^PRSPUT1
 ;
 ; Check for Without-Pay hours
WP I $D(^TMP($J,"WP"))=10 D
 . S TEXT="The following Pay Periods have Without-Pay hours:"
 . D A1^PRSPUT1
 . S PPE="",PPCNT=0,PPEX=""
 . F  S PPE=$O(^TMP($J,"WP",PPE)) Q:'PPE  D
 . . S PPEX1=PPE_" - "_^TMP($J,"WP",PPE),$E(PPEX1,15)=""
 . . S PPEX=PPEX_PPEX1
 . . S PPCNT=PPCNT+1
 . . I PPCNT>4 D
 . . . S TEXT=PPEX,PPCNT=0,PPEX=""
 . . . D A1^PRSPUT1
 . I PPCNT>0 D
 . . S TEXT=PPEX
 . . D A1^PRSPUT1
 K ^TMP($J,"RG"),^TMP($J,"NP"),^TMP($J,"WP")
 Q
