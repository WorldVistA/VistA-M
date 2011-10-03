FBUTL4 ;WOIFO/SAB-FEE BASIS UTILITY ;7/6/2003
 ;;3.5;FEE BASIS;**61**;JAN 30, 1995
 Q
RR(FBRRMK,FBMAX,FBDT,FBRRMKD) ; Prompt for Remittance Remarks
 ;
 ; Input
 ;   FBRRMK - required, array passed by reference
 ;            will be initialized (killed)
 ;            array of any entered remark codes
 ;            format
 ;              FBRRMK(#)=FBRRMKC
 ;            where
 ;              # = sequentially assigned number starting with 1
 ;              FBRRMKC = remittance remark (internal value file 162.93)
 ;   FBMAX  -  optional, number, default to 2
 ;             maximum number of remarks that may be entered by user
 ;   FBDT   -  optional, effective date, FileMan internal format
 ;             default to current date, used to determine available codes
 ;   FBRRMKD-  optional, array passed by reference
 ;             same format as FBRRMK
 ;             if passed, it will be used to supply default values
 ;             normally only used when editing an existing payment 
 ; Result (value of $$RR extrinsic function)
 ;   FBRET  - boulean value (0 or 1)
 ;             = 1 when process did not end due to time-out or "^"
 ;             = 0 when process ended due to time-out OR "^"
 ; Output
 ;   FBRRMK-  the FBRRMK input array passed by reference will be modified
 ;            it will contain any entered remarks
 ;
 N FBRRMKC,FBCNT,FBEDIT,FBERR,FBI,FBNEW,FBRET
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S FBRET=1
 S FBMAX=$G(FBMAX,2)
 S FBDT=$G(FBDT,DT)
 K FBRRMK
 ;
 ; if default remarks exist then load them into array
 I $D(FBRRMKD) M FBRRMK=FBRRMKD
 S FBCNT=0
 I $D(FBRRMK) S FBI=0 F  S FBI=$O(FBRRMK(FBI)) Q:'FBI  S FBCNT=FBCNT+1
 ;
ASKRR ; multiply prompt for remarks
 ;
 ; display current list of remarks when more than 1 allowed
 I FBMAX>1!(FBCNT>1) D
 . W !!,"Current list of Remittance Remarks: "
 . I '$O(FBRRMK(0)) W "none"
 . S FBI=0 F  S FBI=$O(FBRRMK(FBI)) Q:'FBI  D
 . . W:$P(FBRRMK(FBI),U)]"" $P($G(^FB(161.93,$P(FBRRMK(FBI),U),0)),U),", "
 . W !
 ;
 ; prompt for remark
 ;   if max is 1 and reason already on list then automatically select it
 I FBMAX=1,FBCNT=1 D
 . N FBI,FBRRMKC
 . S FBI=$O(FBRRMK(0))
 . S:FBI FBRRMKC=$P(FBRRMK(FBI),U)
 . I FBRRMKC S Y=FBRRMKC_U_$P($G(^FB(161.93,FBRRMKC,0)),U)
 E  D  I $D(DTOUT)!$D(DUOUT) S FBRET=0 G EXIT  ; prompt user
 . S DIR(0)="PO^161.93:EMZ"
 . S DIR("A")="Select REMITTANCE REMARK"
 . S DIR("S")="I $P($$RR^FBUTL1(Y,,FBDT),U,4)=1"
 . S DIR("?")="Select a HIPAA Remittance Remark Code."
 . S DIR("?",1)="Select a remittance remark code to provide non-financial"
 . S DIR("?",2)="information critical to understanding the adjudication of the claim."
 . D ^DIR K DIR
 ;
 ; if value was entered then process it and ask another if not max
 ;I +Y>0 D  G:FBRET=0 EXIT I FBCNT<FBMAX!(FBRRMKC="") G ASKRR
 I +Y>0 D  G:FBRET=0 EXIT G ASKRR
 . S FBRRMKC=+Y
 . ; if specified remark already in list set FBEDIT = it's number
 . S (FBI,FBEDIT)=0 F  S FBI=$O(FBRRMK(FBI)) Q:'FBI  D  Q:FBEDIT
 . . I $P(FBRRMK(FBI),U)=FBRRMKC S FBEDIT=FBI
 . S FBNEW=$S(FBEDIT:0,1:1) ; flag as new if not on list
 . ; if in list then edit the existing remark
 . I FBEDIT D  Q:$D(DIRUT)  Q:FBRRMKC=""
 . . S DIR(0)="162.559,.01"
 . . S DIR("B")=$P($G(^FB(161.93,FBRRMKC,0)),U)
 . . D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S:FBMAX=1 FBRET=0 Q
 . . I X="@" D  Q  ; "@" removes from list
 . . . D DEL(FBEDIT)
 . . I +Y>0 S FBRRMKC=+Y
 . . ; ensure new value of edited remark is not already on list
 . . S FBI=0 F  S FBI=$O(FBRRMK(FBI)) Q:'FBI  D  Q:FBRRMKC=""
 . . . I $P(FBRRMK(FBI),U)=FBRRMKC,FBI'=FBEDIT S FBRRMKC="" W !,$C(7),"     Change was not accepted because the new value is already on the list."
 . . Q:FBRRMKC=""
 . . ; upate the existing reason
 . . S $P(FBRRMK(FBEDIT),U)=FBRRMKC
 . ;
 . ; if new reason then add to list
 . I 'FBEDIT D  Q:FBRRMKC=""
 . . I (FBCNT+1)>FBMAX D  Q
 . . . S FBRRMKC=""
 . . . W !!,$C(7),"ERROR: A new reason would exceed maximum number (",FBMAX,") allowed for this invoice."
 . . . W !,"  If necessary, a code on the current list can be selected and changed."
 . . S FBEDIT=$O(FBRRMK(" "),-1)+1
 . . S $P(FBRRMK(FBEDIT),U)=FBRRMKC,FBCNT=FBCNT+1
 ;
 ; validate
 I FBCNT>FBMAX D  G ASKRR
 . W !!,$C(7),"ERROR: Maximum number of remittance remark codes (",FBMAX,") have been exceeded."
 ;
EXIT ;
 Q FBRET
 ;
DEL(FBI) ; delete remark from list
 S FBCNT=FBCNT-1
 K FBRRMK(FBI)
 S FBRRMKC=""
 W "   (deleted)"
 Q
 ;
RRL(FBRRMK) ; build list of remittance remarks extrinsic function
 ; Input
 ;   FBRRMK- required, array passed by reference
 ;           array of remittance remarks
 ;            format
 ;              FBRRMK(#)=FBRRMKC
 ;            where
 ;              # = integer number greater than 0
 ;              FBRRMKC = remittance remark (internal value file 162.93)
 ; Result
 ;   string containing sorted list (by external code) of remarks
 ;   format
 ;      FBRRMKCE 1, FBRRMKCE 2
 ;   where
 ;      FBRRMKCE = remittance remark code (external value)
 N FBRET
 N FBRRMKC,FBRRMKCE
 N FBRRMKS,FBI
 S FBRET=""
 ;
 ; build sorted array containing external values
 S FBI=0 F  S FBI=$O(FBRRMK(FBI)) Q:'FBI  D
 . ; obtain internal values
 . S FBRRMKC=$P(FBRRMK(FBI),U)
 . ; convert to external values
 . S FBRRMKCE=$S(FBRRMKC:$P($G(^FB(161.93,FBRRMKC,0)),U),1:"")
 . ; store in sorted array
 . S FBRRMKS(FBRRMKCE_U_FBI)=FBRRMKCE_","
 ;
 ; build list from sorted array
 S FBI="" F  S FBI=$O(FBRRMKS(FBI)) Q:FBI=""  D
 . S FBRET=FBRET_FBRRMKS(FBI)
 ; strip trailing "," from list
 I $E(FBRET,$L(FBRET))="," S FBRET=$E(FBRET,1,$L(FBRET)-1)
 ;
 Q FBRET
 ;
 ;FBUTL4
