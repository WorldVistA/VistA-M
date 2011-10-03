PRSPSRC ;WOIFO/MGD - PTP SELECT RECONCILIATION CHOICE ;04/22/05
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; The following routine will allow HR to complete the reconciliation
 ; process for a memorandum that has expired or been terminated.
 ;
 Q
 ;
MAIN(PRSIEN,MIEN) ; Main Driver
 ; PRSIEN optional parameter-employee file 450 ien
 ; MIEN optional parameter-ien of memo that needs ptps reconcile choice
 ;
 Q:'DUZ
 I $G(PRSIEN)'>0 D
 . S SSN=$P($G(^VA(200,DUZ,1)),"^",9)
 . I SSN'="" S PRSIEN=$O(^PRSPC("SSN",SSN,0))
 Q:$G(PRSIEN)'>0
 ;
 ;if MIEN passed make sure it qualifies
 I $G(MIEN)>0,'$D(^PRST(458.7,"AST",PRSIEN,3,MIEN)) D  Q
 . W @IOF
 . W !!,"Memorandum status is not Reconciliation Started."
 ;if MIEN not passed then Find memos that qualify for reconcile
 K ^TMP($J,"PRSPRM")
 I $G(MIEN)'>0 D 
 .  D MEM^PRSPRM
 E  D
 .  D MEMDAT^PRSPRM(MIEN,.STATUS,.STDAT,.ENDAT,.TDAT)
 I $G(MIEN)'>0 D KILL^PRSPRM1 Q
 ;
 S DATA2=$G(^PRST(458.7,MIEN,2))
 I +DATA2 D  D KILL^PRSPRM1 Q
 . W !!,"You have already selected the following reconciliation option:"
 . W !!,"Reconciliation Option: ",$$EXTERNAL^DILFD(458.7,17,"",+DATA2)
 . W !,"Reconciliation Comments: ",$P(DATA2,U,2)
 ; Display employee and memorandum information
 D DISPLAY^PRSPRM
 I $D(DIRUT) D KILL^PRSPRM1 Q
 ; Verify that all daily ESR are completed
 S QUIT=0
 D ESRCHK^PRSPRM
 I QUIT D KILL^PRSPRM1 Q
 ; Display Summary information
 D SUM^PRSPBRP
 ; Display Reconciliation Choices
 D ROPT^PRSPBRP
 ; Prompt PTP for Reconciliation Choice
 D PTPRC
 I RO="^" D KILL^PRSPRM1 Q
 S PTPRC=$P(MEM(RO),U,2)
 ; Prompt for PTP Reconciliation Comments
 D PTPRCOM
 I X="^" D KILL^PRSPRM1 Q
 D SAVE
 D KILL^PRSPRM1
 Q
 ;
 ;
PTPRC ; PTP Reconciliation Choice
 S END="",END=$O(MEM(END),-1) ; Find range on options
 ; Prompt for Reconciliation Choice
RO W !!,"Enter Reconciliation Choice: "
 R RO:DTIME
 I RO="" S RO="^"
 Q:RO="^"
 I '$D(MEM(RO)) D  G RO
 . I END>1 D
 . . W !!,"Enter a number between 1 and ",END," or ^ to exit"
 . I END'>1 D
 . . W !!,"Enter 1 or ^ to exit"
 S PTPRCE=$P(MEM(RO),U,1),PTPRC=$P(MEM(RO),U,2)
 W "  "_PTPRCE
 S TEXT="Enter Reconciliation Choice: "_RO
 S INDEX=INDEX+1
 S ^TMP($J,"PRSPRM",INDEX)=TEXT,TEXT=""
 S INDEX=INDEX+1
 D A1^PRSPUT1 ; Blank Line
 Q
 ;
PTPRCOM ; Prompt for PTP's Reconciliation Comments if paper form was used
 ;
 S DIR(0)="FO^1:240^^",DIR("A")="PTP's Reconciliation Comments"
 D ^DIR
 I X="^" Q
 S PTPRCOM=X
 S TEXT="Reconciliation Comments: "_$E(PTPRCOM,1,48)
 S INDEX=INDEX+1,^TMP($J,"PRSPRM",INDEX)=TEXT
 S TEXT="",TEXT=$E(PTPRCOM,49,128),INDEX=INDEX+1
 I TEXT'="" S ^TMP($J,"PRSPRM",INDEX)=TEXT
 S TEXT="",TEXT=$E(PTPRCOM,129,208),INDEX=INDEX+1
 I TEXT'="" S ^TMP($J,"PRSPRM",INDEX)=TEXT
 S TEXT="",TEXT=$E(PTPRCOM,209,240),INDEX=INDEX+1
 I TEXT'="" S ^TMP($J,"PRSPRM",INDEX)=TEXT
 S TEXT="",INDEX=INDEX+1
 D A1^PRSPUT1 ; Blank Line
 Q
 ;
SAVE ; Save PTP info into #458.7
 ;
 N ESOK,HOL
 K PRSFDA,IEN4587
 D ^PRSAES
 I 'ESOK D  Q
 . W !!,"Your Reconciliation Choice was not saved."
 I ESOK D
 . S IEN4587=MIEN_","
 . S PRSFDA(458.7,IEN4587,17)=PTPRC
 . S PRSFDA(458.7,IEN4587,18)=PTPRCOM
 . D UPDATE^DIE("","PRSFDA","IEN4587"),MSG^DIALOG()
 ;
 K DATA,DATA2,DIR,DIRUT,END,ENDAT,INDEX,MEM,PTPRC,PTPRCE,PTPRCOM,QUIT
 K RO,SSN,STATUS,STDAT,TDAT,TEXT,X
 Q
