PRSPRM1 ;WOIFO/MGD - PTP RECONCILE MEMORANDUM - 1 ;01/29/07
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; The following routine will allow HR to complete the reconciliation
 ; process for a memorandum that has expired or been terminated.
 ;
 Q
 ;
PTPCHK ; Check for Reconciliation info entered by PTP on electronic form
 ;
 S DATA2=$G(^PRST(458.7,MIEN,2))
 S PTPRC=$P(DATA2,U,1),PTPRCOM=$P(DATA2,U,2)
 I PTPRC="" S PTPRCE="" Q
 S PTPRCE=$$RCE(PTPRC)
 S END="",END=$O(MEM(END),-1) ; Find range on options
 F I=1:1:END D  Q:ACTRC=PTPRC
 . S ACTRC=$P($G(MEM(I)),U,2) ; Numerical choice entered by PTP
 S TEXT=""
 D A1^PRSPUT1
 S TEXT="PTP's Reconciliation Choice: "_I_"  "_PTPRCE
 D A1^PRSPUT1
 ; Set this into ^TMP for long messages
 S TEXT="PTP's Reconciliation Comments: "_$E(PTPRCOM,1,48)
 S INDEX=INDEX+1,^TMP($J,"PRSPRM",INDEX)=TEXT
 W !,TEXT
 S TEXT=$E(PTPRCOM,49,128),INDEX=INDEX+1
 I TEXT'="" S ^TMP($J,"PRSPRM",INDEX)=TEXT W !,TEXT
 S TEXT=$E(PTPRCOM,129,208),INDEX=INDEX+1
 I TEXT'="" S ^TMP($J,"PRSPRM",INDEX)=TEXT W !,TEXT
 S TEXT=$E(PTPRCOM,209,240),INDEX=INDEX+1
 I TEXT'="" S ^TMP($J,"PRSPRM",INDEX)=TEXT W !,TEXT
 S TEXT=""
 D A1^PRSPUT1 ; Blank Line
 Q
 ;
HRRC ; HR Reconciliation Choice
 S END="",END=$O(MEM(END),-1) ; Find range on options
 ; Prompt for Reconciliation Option
RO W !!,"Enter Reconciliation Option: "
 R RO:DTIME
 S RO=$$UPPER^PRSRUTL(RO)
 I RO="" S RO="^"
 Q:RO="^"
 I '$D(MEM(RO)) D  G RO
 . I END>1 D
 . . W !!,"Enter a number between 1 and ",END," or ^ to exit"
 . I END'>1 D
 . . W !!,"Enter 1 or ^ to exit"
 S PTPRCE=$P(MEM(RO),U,1),PTPRC=$P(MEM(RO),U,2)
 W "  "_PTPRCE
 S TEXT="Enter Reconciliation Option: "_RO
 S INDEX=INDEX+1
 S ^TMP($J,"PRSPRM",INDEX)=TEXT,TEXT=""
 S INDEX=INDEX+1
 D A1^PRSPUT1 ; Blank Line
 Q
 ;
PTPRCOM ; Prompt for PTP's Reconciliation Comments if paper form was used
 ;
 Q:PTPRCOM'=""&(PTPRC)  ; PTP didn't enter any reconciliation comments
 W !
 S DIR(0)="FO^1:240^^",DIR("A")="PTP's Reconciliation Comments"
 D ^DIR K DIR
 I PTPRCOM="",(X'=""&(X'="^")) D
 . S PTPHRCOM="PTP/hr: "_X
 . S TEXT="Reconciliation Comments: "_$E(PTPHRCOM,1,48)
 . S INDEX=INDEX+1,^TMP($J,"PRSPRM",INDEX)=TEXT
 . S TEXT="",TEXT=$E(PTPHRCOM,49,128),INDEX=INDEX+1
 . I TEXT'="" S ^TMP($J,"PRSPRM",INDEX)=TEXT
 . S TEXT="",TEXT=$E(PTPHRCOM,129,208),INDEX=INDEX+1
 . I TEXT'="" S ^TMP($J,"PRSPRM",INDEX)=TEXT
 . S TEXT="",TEXT=$E(PTPHRCOM,209,240),INDEX=INDEX+1
 . I TEXT'="" S ^TMP($J,"PRSPRM",INDEX)=TEXT
 . S TEXT="",INDEX=INDEX+1
 . D A1^PRSPUT1 ; Blank Line
 Q
 ;
TRNS ; Transfer hours to current memorandum
 ;
 Q:PTPRC'=2&(PTPRC'=4)
 Q:'NMIEN
 ;
 D MEM^PRSPUT1(PRSIEN,NMIEN)
 D A1^PRSPUT1 ; Blank Line
 ;
 ; Transfer Prompt
 S TPROMPT="Transfer "_$S(OTHRS>0:"+",1:"")_OTHRS_" hours: "
 S DIR(0)="Y"
 S DIR("A")=TPROMPT
 D ^DIR K DIR
 I X="^" D  Q
 . S QUIT=1
 . W !!,"Memorandum will have to be reconciled at a future date."
 S TEXT=TPROMPT_" "_X
 S INDEX=INDEX+1
 S ^TMP($J,"PRSPRM",INDEX)=TEXT
 S INDEX=INDEX+1,TEXT=""
 D A1^PRSPUT1 ; Blank Line
 ;
CAL ; Calculate results after transfer
 S DATA=$G(^PRST(458.7,NMIEN,0))
 S AHRS=$P(DATA,U,4) ;     AGREED HOURS
 S THRSWK=$P(DATA,U,10) ;  TOTAL HOURS WORKED
 S NPAYHRS=$P(DATA,U,12) ; NONPAY HOURS
 S WPAYHRS=$P(DATA,U,13) ; WITHOUT PAY HOURS
 S POMC=$P(DATA,U,14) ;   PERCENTAGE OF MEMORANDUM COMPLETED
 S POHC=$P(DATA,U,15) ;   PERCENTAGE OF HOURS COMPLETED
 S AHTCM=$P(DATA,U,16) ;  AVERAGE HOURS TO COMPLETE MEMORANDUM
 S POT=$P(DATA,U,17) ;    % OFF TARGET
 ;
 S AAHRS=AHRS-NPAYHRS-WPAYHRS ; AGREED HOURS adjusted for NP and WP
 S I=$P($$MEMCPP^PRSPUT3(NMIEN),U,2) ; Determine # PP already worked
 S PPREM=26-I ; Pay Periods REMaining
 S NTHRSWK=THRSWK+OTHRS   ; New Total Hours Worked
 S NPOHC=$FN(THRSWK/AAHRS,"",2) ; New % Of Hours Completed
 S NAHTCM=(AAHRS-THRSWK)/PPREM ; Average Hours/PP To Complete Memorandum
 S NAHTCM=$FN(NAHTCM,"",2)
 I I>0 D
 . S NPOT=(AHRS/26*I)-NPAYHRS-WPAYHRS
 . S NPOT=THRSWK-NPOT/NPOT,NPOT=NPOT*100,NPOT=$FN(NPOT,"",2)
 I I=0 S NPOT=0
 ;
 ; Display updated Memorandum info
 D MEM^PRSPUT1(PRSIEN,NMIEN,,,OTHRS)
 Q
 ;
HRCOM ; Prompt for HR's final reconciliation comments
 W !
 S DIR(0)="FO^1:240^^",DIR("A")="Enter Final Reconciliation Comments"
 D ^DIR K DIR
 S HRCOM=X
 I HRCOM'=""&(HRCOM'="^") D
 . S TEXT="Enter Final Reconciliation Comments: "_$E(HRCOM,1,44)
 . S INDEX=INDEX+1,^TMP($J,"PRSPRM",INDEX)=TEXT
 . S TEXT="",TEXT=$E(HRCOM,44,123),INDEX=INDEX+1
 . I TEXT'="" S ^TMP($J,"PRSPRM",INDEX)=TEXT
 . S TEXT="",TEXT=$E(HRCOM,124,203),INDEX=INDEX+1
 . I TEXT'="" S ^TMP($J,"PRSPRM",INDEX)=TEXT
 . S TEXT="",TEXT=$E(HRCOM,204,240),INDEX=INDEX+1
 . I TEXT'="" S ^TMP($J,"PRSPRM",INDEX)=TEXT
 S TEXT="",INDEX=INDEX+1
 D A1^PRSPUT1 ; Blank Line
 Q
 ;
PRT ; Print form for Chief of Staff approval
 ;
 S DIR(0)="Y"
 S DIR("A")="Print reconciliation for Chief of Staff approval "
 D ^DIR K DIR
 I X="^" S QUIT=1 Q
 Q:X="N"!(X="n")  ; Quit on 2nd pass
 S INDX="",INDX=$O(^TMP($J,"PRSPRM",INDX),-1),INDX=INDX+1
 S ^TMP($J,"PRSPRM",INDX)="",INDX=INDX+1 ; Blank Line
 S $P(DASH,"_",34)="_"
 S TEXT="Chief of Staff signature "_DASH_"  Date "
 S DASH="",$P(DASH,"_",14)="_",TEXT=TEXT_DASH
 S ^TMP($J,"PRSPRM",INDX)=TEXT
 ;
 W !
 K IOP,%ZIS
 S %ZIS("A")="Select Device: ",%ZIS="MQ"
 D ^%ZIS
 I POP D  Q
 . S QUIT=1
 . K %ZIS,IOP
 I $D(IO("Q")) D  Q
 .  S ZTDESC="PRS PTP COMPLETE RECONCILE"
 .  S ZTRTN="PRINT^PRSPRM1"
 .  S ZTSAVE("^TMP($J,""PRSPRM"",")=""
 .  D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued!",1:"Request Canceled!")
 .  K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 .  D HOME^%ZIS
 U IO
 D PRINT^PRSPRM1,^%ZISC
 K %ZIS,IOP
 Q
 ;
ESIG ; Prompt for Electronic Signature and store fields in #458.7
 ;
 N ESOK
 D ^PRSAES
 Q:'ESOK
 ; Set fields when transferring + or - balance
 I PTPRC=2!(PTPRC=4) D
 . S IEN4587=NMIEN_","
 . S PRSFDA(458.7,IEN4587,8)=OTHRS   ; CARRYOVER HOURS
 . S PRSFDA(458.7,IEN4587,14)=+NPOHC  ; % OF HOURS COMPLETED
 . S PRSFDA(458.7,IEN4587,15)=+NAHTCM ; AVE HRS/PP TO COMPLETE MEM
 . S PRSFDA(458.7,IEN4587,16)=+NPOT   ; % OFF TARGET
 . D UPDATE^DIE("","PRSFDA","IEN4587"),MSG^DIALOG()
 ; Update the status of the old memorandum
 S IEN4587=MIEN_","
 I PTPRCOM=""&($G(PTPHRCOM)'="") D   ; PTP Reconciliation Comm from paper
 . S PRSFDA(458.7,IEN4587,18)=PTPHRCOM
 S PRSFDA(458.7,IEN4587,19)=DUZ   ; RECONCILED BY
 D NOW^%DTC
 S PRSFDA(458.7,IEN4587,20)=%     ; DATE/TIME RECONCILED
 S PRSFDA(458.7,IEN4587,21)=HRCOM ; HR RECONCILIATION COMMENTS
 S PRSFDA(458.7,IEN4587,5)=4      ; STATUS = RECONCILED
 D UPDATE^DIE("","PRSFDA","IEN4587"),MSG^DIALOG()
 Q
 ;
PRINT ; Print the paper version of the Reconciliation form
 ;
 S INDEX=""
 F  S INDEX=$O(^TMP($J,"PRSPRM",INDEX)) Q:'INDEX  D
 . S TEXT=^TMP($J,"PRSPRM",INDEX)
 . W !,TEXT
 Q
 ;
RCE(PTPRC) ;
 I PTPRC=1 S PTPRCE="No reconciliation needed"
 I PTPRC=2 S PTPRCE="Transfer negative balance"
 I PTPRC=3 S PTPRCE="Pay VA for negative balance"
 I PTPRC=4 S PTPRCE="Transfer positive balance"
 I PTPRC=5 S PTPRCE="Pay Phy for positive balance"
 Q PTPRCE
 ;
KILL ; Clean up variables
 ;
 K ACTRC,AHRCOM,AHRS,AAHRS,AHTCM,AMT,ARRAY,ASK,ASK2,D1,DASH
 K DATA,DATA0,DATA2,DATA4,DATA5,DAY,DIR,DIRUT,END,ENDDAT,ENDSTA
 K ESRSTAT,HRCOM,I,IEN4587,INDEX,INDX,MEM,MIEN,NAHTCM,NMIEN,NPAYHRS
 K NPHRS,NPOHC,NPOMC,NPOT,NTHRSWK,OLDMIEN,OTHRS,OTP,POP,POHC,POMC
 K POT,PPE,PPI,PPEX,PPEX1,PPCNT,PPREM,PRPRCE,PRSAPGM,PRSIEN,PRSFDA
 K PTPHRCOM,PTPRC,PTPRCE,PTPRCOM,QUIT,RATE,RO,SALARY,SCRTTL,SHRCOM
 K SPAA,START,STATUS,STDAT,SSN,TDAT,TDATE,TEXT,THRSWK
 K TPROMPT,WPAYHRS,WPHRS,ZTSAVE,X,Y,%
 K ^TMP($J,"PRSPRM")
 Q
