PRSPTM ;WOIFO/MGD - PTP TERMINATE MEMORANDUM ;06/15/05
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; The following routine will allow HR to terminate a Part Time
 ; Physician's Memorandum of Service Level Expectations.  Once
 ; terminated the memorandum will need to be reconciled.
 ; For a memorandum to be eligible for termination it must have already
 ; had had at least one Pay Period processed and it must be prior to
 ; the processing of the last Pay Period covered by the memorandum.
 ;
 Q
MAIN ; Main Driver
 N STDAT,ENDAT,AHRS,ICOM,ESOK
 ; Prompt for Part Time Physician
 D PTP
 I Y'>0 D KILL Q
 S PRSIEN=+Y
 ; Find any memorandums that meet the termination qualifications
 D MEM
 Q:'$G(MIEN)
 ; Display employee and memorandum information
 D DISPLAY
 Q:$D(DIRUT)
TERM ; Issue Terminate Memorandum prompt
 W !
 S DIR(0)="YO",DIR("A")="Terminate Memoranda Y/N: "
 D ^DIR K DIR
 Q:Y'=1
 ; Prompt for Termination Date
 D TDATE
 Q:X=""!(X="^")
 ; Prompt for Termination Comments
 D TCOM
 Q:TCOM="^"
 ; Prompt for E-sig and update file
 D ESIG
 Q
 ;
PTP ; Prompt for Part Time Physician
 W !
 S DIC="^PRSPC(",DIC(0)="AEMQZ",DIC("A")="Select EMPLOYEE: "
 D ^DIC K DIC
 S PRSIEN=+Y
 Q
 ;
MEM ; Find any memorandums that meet the termination qualifications
 N MEM,INDX
 S MEM=0,INDX=1
 F  S MEM=$O(^PRST(458.7,"B",PRSIEN,MEM)) Q:'MEM  D
 . S DATA=$G(^PRST(458.7,MEM,0))
 . Q:DATA=""
 . S STATUS=$P(DATA,U,6)
 . Q:STATUS>2  ; Memorandum = 3:RECONCILIATION STARTED or 4:RECONCILED
 . S START=$P(DATA,U,2),END=$P(DATA,U,3) ; Start Date, End Date
 . ; Don't include future memoradums.  The Delete Future Memorandum
 . ; option must be used to to remove future memorandums.
 . Q:START>DT
 . ; Check for a memorandum that has already been terminated but the
 . ; Begin Reconciliation Process option has not been run yet.
 . Q:+$G(^PRST(458.7,MEM,4))
 . S PPI=$P($G(^PRST(458,"AD",END)),U,1)
 . ; The End Date for future memorandums may not be in #458 yet
 . I PPI="" D  Q
 . . S MEM(INDX)=MEM_"^"_START_"^"_END_"^ACTIVE",INDX=INDX+1
 . ; If the End Date is in #458 check the timecard status for that PP
 . ; Quit if Timecard status for the last PP of the mem is not (T)imekeeper
 . Q:$P($G(^PRST(458,PPI,"E",PRSIEN,0)),U,2)'="T"
 . S MEM(INDX)=MEM_"^"_START_"^"_END_"^ACTIVE",INDX=INDX+1
 ; If no memos meet the termination qualifications
 I '$D(MEM(1)) D  Q
 . W !!,"No memorandums meet the termination qualifications for the "
 . W "selected employee."
 . S MIEN=0
 ; If only one memo
 I '$D(MEM(2)) S MIEN=$P($G(MEM(1)),U,1) Q
 ; Display list if more than one
 I $D(MEM(2)) D
 . W !!," # ",?5,"STARTS          ENDS"
 . F MEM=1:1 Q:'$D(MEM(MEM))  D
 . . S DATA=MEM(MEM)
 . . S START=$$FMTE^XLFDT($P(DATA,U,2))
 . . S END=$$FMTE^XLFDT($P(DATA,U,3))
 . . W !!,MEM,?5,START," TO ",END
 . ;
ASK . ; Ask user to select which memorandum they want
 . S END="",END=$O(MEM(END),-1)
 . W !!,"Enter a number between 1 and ",END,": "
 . R ASK:DTIME
 . S ASK=$$UPPER^PRSRUTL(ASK)
 . I ASK=""!(ASK="^") S MIEN=0 Q
 . I '$D(MEM(ASK)) D  G ASK
 . . W !!,"Enter a number between 1 and ",END," or ^ to exit"
 . S MIEN=$P(MEM(ASK),U,1)
 Q
 ;
DISPLAY ; Display memorandum info to validate the correct employee was chosen
 S SCRTTL="Terminate PT Physician Memoranda"
 D HDR^PRSPUT1(PRSIEN,SCRTTL)
 D MEM^PRSPUT1(PRSIEN,MIEN)
 D AL^PRSPUT3(PRSIEN,)
 D PPSUM^PRSPUT2(PRSIEN,MIEN)
 S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR
 Q
 ;
TDATE ; Prompt for Termination Date
 S DATA0=$G(^PRST(458.7,MIEN,0))
 S (STDAT,STDATI)=$P(DATA0,U,2),(ENDAT,ENDATI)=$P(DATA0,U,3)
 S Y=STDAT
 D DD^%DT
 S STDAT=Y
 S Y=ENDAT
 D DD^%DT
 S ENDAT=Y
 S TDAT=0
 W !!,"Termination date must be the last day of a pay period."
 W !,"Start Date: ",STDAT,"     End Date: ",ENDAT,!
 S %DT="AEX",%DT("A")="Termination Date: ",QUIT=0
 F  D  Q:QUIT
 . N DAY14,TPPI
 . D ^%DT
 . I X=""!(X="^") S QUIT=1 Q
 . ; Validate that the Termination Date is the last day of a Pay Period.
 . S TDATE=+Y
 . Q:TDATE="^"
 . S D1=TDATE
 . D PP^PRSAPPU ; PPI and Day are set here
 . S TPPI=$G(PPI) ; termination pay period IEN (if open)
 . I DAY'=14 D  Q
 . . W !!,"The Termination Date must be the last day of a Pay Period."
 . . W !,"Please re-enter.",!
 . I TDATE<STDATI D  Q
 . . W !!,"The Termination Date can not be prior to the Start Date: ",STDAT
 . . W !,"Please re-enter.",!
 . I TDATE'<ENDATI D  Q
 . . W !!,"The Termination Date must be prior to the End Date: ",ENDAT
 . . W !,"Please re-enter.",!
 . ;
 . ; Check to make sure that no Timecards for PPs after the termination
 . ; date have a status of Payroll or Transmitted.
 . I 'TPPI S QUIT=1 Q  ; PP containing termination date is not open
 . ; loop thru PPs after the PP of terminatio and check their status
 . S FPPESR=0 ; init # of PPs that have status which prevents termination
 . S PPI=TPPI F  S PPI=$O(^PRST(458,PPI)) Q:'PPI  D  Q:DAY14>ENDATI
 . . S DAY14=$P($G(^PRST(458,PPI,1)),U,14) ; last day of PPI
 . . Q:DAY14>ENDATI  ; pay period is after end of memo
 . . S STATUS=$P($G(^PRST(458,PPI,"E",PRSIEN,0)),U,2)
 . . Q:"^P^X^"'[(U_STATUS_U)  ; quit if status not P or X
 . . ; timecard has a status that prevents termination
 . . S FPPESR=FPPESR+1
 . . S STATEX=$$EXTERNAL^DILFD(458.01,1,"",STATUS)
 . . W !,$P($G(^PRST(458,PPI,0)),U),?10,STATEX
 . ;
 . I FPPESR=0 S QUIT=1 Q  ; All tests passed. Termination date is OK
 . ;
 . W !!,"You cannot select this Pay Period because there "
 . W $S(FPPESR=1:"is ",1:"are "),FPPESR," Pay Period"
 . W $S(FPPESR>1:"s ",1:" "),"after this"
 . W !,"Pay Period where the timecard",$S(FPPESR=1:" has ",1:"s have ")
 . W "a status other than Timekeeper.",!!
 Q
 ;
TCOM ; Termination Comments
 W !
 S DIR(0)="FO^1:240^^O",DIR("A")="Termination Comments" D ^DIR
 S TCOM=Y
 Q
 ;
ESIG ; Prompt for Electronic Signature and store fields in #458.7
 ;
 N ESOK,PPE,PPNUM,RCALFLG
 D ^PRSAES
 I ESOK D
 . ; Update #458.7
 . S MIEN=MIEN_","
 . S PRSFDA(458.7,MIEN,22)=TDATE ; TERMINATION DATE
 . S PRSFDA(458.7,MIEN,23)=DUZ   ; TERMINATED BY
 . D NOW^%DTC
 . S PRSFDA(458.7,MIEN,24)=%     ; TERMINATED DATE/TIME
 . S PRSFDA(458.7,MIEN,25)=TCOM  ; TERMINATION COMMENTS
 . D UPDATE^DIE("","PRSFDA","MIEN"),MSG^DIALOG()
 . S MIEN=+MIEN ; Remove comma from end
 . ;
 . ; Check for PP that need to have their ESR's deleted
 . S X1=TDATE,X2=1
 . D C^%DTC
 . S PPI=+$G(^PRST(458,"AD",X))
 . Q:'PPI  ; There aren't any pay periods opened after the termination date
 . ;
 . S PPI=PPI-.01 ; init PPI to include 1st PP in loop
 . F  S PPI=$O(^PRST(458,PPI)) Q:'PPI  D
 . . Q:'$D(^PRST(458,PPI,"E",PRSIEN,0))  ; skip PP if no timecard/ESR
 . . ;
 . . ; Check for previously saved hours for this PP
 . . S RCALFLG=0
 . . S PPE=$P($G(^PRST(458,PPI,0)),U,1)
 . . S PPNUM=$O(^PRST(458.7,MIEN,9,"B",PPE,0))
 . . Q:PPNUM'>0
 . . S RCALFLG=$S($P($G(^PRST(458.7,MIEN,9,PPNUM,0)),U,1)'="":1,1:0)
 . . ;
 . . F DAY=1:1:14 D
 . . . S ESRSTAT=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",DAY,7)),U,1)
 . . . I ESRSTAT=5 D  ; Clear Time Card posting information
 . . . . K ^PRST(458,PPI,"E",PRSIEN,"D",DAY,2),^(3),^(10)
 . . . ;
 . . . ; delete any ESR data
 . . . ; use fileman to delete ESR DAILY STATUS so x-ref will get updated
 . . . S PRSFDA(458.02,DAY_","_PRSIEN_","_PPI_",",146)="@"
 . . . D FILE^DIE("","PRSFDA"),MSG^DIALOG()
 . . . ; delete ESR related fields
 . . . K ^PRST(458,PPI,"E",PRSIEN,"D",DAY,5),^(6),^(7)
 . . ;
 . . ; If the PP had been certified before, re-calculate totals
 . . I RCALFLG D PTP^PRSASR1(PRSIEN,PPI)
 Q
 ;
KILL ; Clean up variables
 ;
 K ASK,D1,DA,DATA,DATA0,DAY,DIR,DIRUT,END,ENDAT,ENDATI,ESRSTAT
 K FPPESR,I,INDX,MEM,MIEN,PPE,PPI,PRSIEN,PRSFDA,QUIT,QUIT1
 K SCRTTL,START,STATEX,STATUS,STDAT,STDATI,TCOM
 K TDAT,TDATE,TDATI,X,X1,X2,Y,%,%DT
 K ^TMP($J,"PRSPTM")
 Q
