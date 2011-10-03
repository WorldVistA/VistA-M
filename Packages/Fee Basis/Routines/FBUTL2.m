FBUTL2 ;WOIFO/SAB-FEE BASIS UTILITY ;7/1/2003
 ;;3.5;FEE BASIS;**61,73**;JAN 30, 1995
 Q
ADJ(FBTAS,FBADJ,FBMAX,FBDT,FBADJD,FBNOOUT) ; Prompt for adjustments
 ;
 ; Input
 ;   FBTAS  - required, total amount suspended, number, may be negative
 ;            the sum of all adjustment amounts must equal this value
 ;   FBADJ  - required, array passed by reference
 ;            will be initialized (killed)
 ;            array of any entered adjustments
 ;            format
 ;              FBADJ(#)=FBADJR^FBADJG^FBADJA
 ;            where
 ;              # = sequentially assigned number starting with 1
 ;              FBADJR = adjustment reason (internal value file 162.91)
 ;              FBADJG = adjustment group (inernal value file 162.92)
 ;              FBADJA = adjustment amount (dollar value)
 ;   FBMAX  -  optional, number, default to 1
 ;             maximum number of adjustments that may be entered by user
 ;   FBDT   -  optional, effective date, FileMan internal format
 ;             default to current date, used to determine available codes
 ;   FBADJD -  optional, array passed by reference
 ;             same format as FBADJ
 ;             if passed, it will be used to supply default values
 ;             normally only used when editing an existing payment 
 ;   FBNOOUT-  optional, boolean value, default 0, set =1 if user
 ;             should not be allowed to exit using an uparrow
 ; Result (value of $$ADJ extrinsic function)
 ;   FBRET  - boulean value (0 or 1)
 ;             = 1 when valid adjustments entered
 ;             = 0 when processed ended due to time-out or entry of '^'
 ; Output
 ;   FBADJ  - the FBADJ input array passed by reference will be modified
 ;            if the result = 1 then it will contain entered adjustments
 ;            if the result = 0 then it will be undefined
 ;
 N FBADJR,FBCAS,FBCNT,FBEDIT,FBERR,FBI,FBNEW,FBRET
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S FBRET=1
 S FBMAX=$G(FBMAX,1)
 S FBDT=$G(FBDT,DT)
 S FBNOOUT=$G(FBNOOUT,0)
 S FBTAS=+FBTAS
 K FBADJ
 ;
 I +FBTAS=0 G EXIT ; no adjustment since total amount susp. is 0
 ;
 ; if default adjustments exist then load them into array
 I $D(FBADJD) M FBADJ=FBADJD
 S (FBCNT,FBCAS)=0
 I $D(FBADJ) S FBI=0 F  S FBI=$O(FBADJ(FBI)) Q:'FBI  D
 . S FBCNT=FBCNT+1
 . S FBCAS=FBCAS+$P(FBADJ(FBI),U,3)
 ;
 ; if more than one adjustment can be entered then display number
 ;
 ;
ASKADJ ; multiply prompt for adjustments
 ;
 ; display current list of adjustments when more than 1 allowed
 I FBMAX>1!(FBCNT>1) D
 . W !!,"Current list of Adjustments: "
 . I '$O(FBADJ(0)) W "none"
 . S FBI=0 F  S FBI=$O(FBADJ(FBI)) Q:'FBI  D
 . . W ?30,"Code: "
 . . W:$P(FBADJ(FBI),U)]"" $P($G(^FB(161.91,$P(FBADJ(FBI),U),0)),U)
 . . W ?44,"Group: "
 . . W:$P(FBADJ(FBI),U,2)]"" $P($G(^FB(161.92,$P(FBADJ(FBI),U,2),0)),U)
 . . W ?56,"Amount: "
 . . W "$",$FN($P(FBADJ(FBI),U,3),"",2),!
 ;
 ; prompt for adjustment reason
 ;   if max is 1 and reason already on list then automatically select it
 I FBMAX=1,FBCNT=1 D
 . N FBI,FBADJR
 . S FBI=$O(FBADJ(0))
 . S:FBI FBADJR=$P(FBADJ(FBI),U)
 . I FBADJR S Y=FBADJR_U_$P($G(^FB(161.91,FBADJR,0)),U)
 E  D  I $D(DTOUT)!$D(DUOUT) S FBRET=0 G EXIT  ; prompt user
 . S DIR(0)="PO^161.91:EMZ"
 . S DIR("A")="Select ADJUSTMENT REASON"
 . S DIR("S")="I $P($$AR^FBUTL1(Y,,FBDT),U,4)=1"
 . S DIR("?")="Select a HIPAA Adjustment (suspense) Reason Code"
 . S DIR("?",1)="Adjustment reason codes explain why the amount paid differs"
 . S DIR("?",2)="from the amount claimed."
 . D ^DIR K DIR
 ; if value was entered then process it and ask another if not max and
 ;   total amount suspended has not been accounted for
 I +Y>0 D  G:FBRET=0 EXIT I FBCNT<FBMAX,FBCAS'=FBTAS G ASKADJ
 . S FBADJR=+Y
 . ; if specified adj. reason already in list set FBEDIT = it's number
 . S (FBI,FBEDIT)=0 F  S FBI=$O(FBADJ(FBI)) Q:'FBI  D  Q:FBEDIT
 . . I $P(FBADJ(FBI),U)=FBADJR S FBEDIT=FBI
 . S FBNEW=$S(FBEDIT:0,1:1) ; flag as new if not on list
 . ; if in list then edit the existing adj. reason
 . I FBEDIT D  Q:$D(DIRUT)  Q:FBADJR=""
 . . S DIR(0)="162.558,.01"
 . . ;S DIR(0)="PO^161.91:EMZ"
 . . ;S DIR("S")="I $P($$AR^FBUTL1(Y,,FBDT),U,4)=1"
 . . ;S DIR("A")="  ADJUSTMENT REASON"
 . . S DIR("B")=$P($G(^FB(161.91,FBADJR,0)),U)
 . . ;S DIR("?")="Enter a HIPAA Adjustment (suspense) Reason Code"
 . . ;S DIR("?",1)="Adjustment reason codes explain why the amount paid differs"
 . . ;S DIR("?",2)="from the amount claimed."
 . . D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S:FBMAX=1 FBRET=0 Q
 . . I X="@" D  Q  ; "@" removes from list
 . . . D DEL(FBEDIT)
 . . . S FBADJR=""
 . . . W "   (deleted)"
 . . I +Y>0 S FBADJR=+Y
 . . ; ensure new value of edited reason is not already on list
 . . S FBI=0 F  S FBI=$O(FBADJ(FBI)) Q:'FBI  D  Q:FBADJR=""
 . . . I $P(FBADJ(FBI),U)=FBADJR,FBI'=FBEDIT S FBADJR="" W !,$C(7),"     Change was not accepted because the new value is already on the list."
 . . Q:FBADJR=""
 . . ; upate the existing reason
 . . S $P(FBADJ(FBEDIT),U)=FBADJR
 . ;
 . ; if new reason then add to list
 . I 'FBEDIT D  Q:FBADJR=""
 . . I (FBCNT+1)>FBMAX D  Q
 . . . S FBADJR=""
 . . . W !,$C(7),"ERROR: A new reason would exceed maximum number (",FBMAX,") allowed for this invoice."
 . . . W !,"   Select a reason code on the current list instead."
 . . S FBEDIT=$O(FBADJ(" "),-1)+1
 . . S $P(FBADJ(FBEDIT),U)=FBADJR,FBCNT=FBCNT+1
 . ;
 . ; ask for adjustment group
 . S DIR(0)="162.558,1"
 . ;S DIR(0)="P^161.92:EMZ"
 . ;S DIR("S")="I $P($$AG^FBUTL1(Y,,FBDT),U,4)=1"
 . ;S DIR("A")="  ADJUSTMENT GROUP"
 . I $P(FBADJ(FBEDIT),U,2)]"" S DIR("B")=$P($G(^FB(161.92,$P(FBADJ(FBEDIT),U,2),0)),U)
 . D ^DIR K DIR I $D(DIRUT) D:FBNEW DEL(FBEDIT) Q
 . S $P(FBADJ(FBEDIT),U,2)=+Y
 . ;
 . ; ask for adjustment amount
 . S DIR(0)="162.558,2"
 . ;S DIR(0)="NA^-9999999.99:9999999.99:2^K:+X=0 X"
 . ;S DIR("A")="  ADJUSTMENT AMOUNT: "
 . S DIR("B")=$FN(FBTAS-FBCAS+$P(FBADJ(FBEDIT),U,3),"",2)
 . D ^DIR K DIR I $D(DIRUT) D:FBNEW DEL(FBEDIT) Q
 . S FBCAS=FBCAS-$P($G(FBADJ(FBEDIT)),U,3)+Y
 . S $P(FBADJ(FBEDIT),U,3)=+Y
 ;
VAL ; validate
 S FBERR=0
 I FBCAS'=FBTAS D
 . S FBERR=1
 . W !,$C(7),"ERROR: Must account for $",$FN(FBTAS-FBCAS,"",2)," more to cover the total amount suspended."
 . W !,"   The current sum of adjustments is $",$FN(FBCAS,"",2),"."
 . W !,"   The total amount suspended is $",$FN(FBTAS,"",2),"."
 I FBCNT>FBMAX D
 . S FBERR=1
 . W !,$C(7),"ERROR: Maximum number of adjustment reasons (",FBMAX,") have been exceeded."
 I FBERR G ASKADJ
 ;
EXIT ;
 ; if time-out or uparrow and total amount not covered then check if
 ; exit is allowed by the calling routine. (not allowed during edit)
 I FBRET=0,FBNOOUT S FBRET=1 I FBTAS'=FBCAS G VAL
 I FBRET=0 K FBADJ
 ;
 Q FBRET
 ;
DEL(FBI) ; delete adjustment reason from list
 S FBCAS=FBCAS-$P($G(FBADJ(FBI)),U,3)
 S FBCNT=FBCNT-1
 K FBADJ(FBI)
 S FBADJR=""
 W "   (reason deleted)"
 Q
 ;
ADJL(FBADJ) ; build list of adjustments extrinsic function
 ; Input
 ;   FBADJ  - required, array passed by reference
 ;            array adjustments
 ;            format
 ;              FBADJ(#)=FBADJR^FBADJG^FBADJA
 ;            where
 ;              # = integer number greater than 0
 ;              FBADJR = adjustment reason (internal value file 162.91)
 ;              FBADJG = adjustment group (inernal value file 162.92)
 ;              FBADJA = adjustment amount (dollar value)
 ; Result
 ;   string containing sorted list (by external reason) of adjustments
 ;   format
 ;      FBADJRE 1^FBADJGE 1^FBADJAE 1^FBADJRE 2^FBADJGE 2^FBADJAE 2
 ;   where
 ;      FBADJRE = adjustment reason (external value)
 ;      FBADJGE = adjustment group (external value)
 ;      FBADJAE = adjustment amount (with cents)
 N FBRET
 N FBARJR,FBADJRE,FBADJG,FBADJGE,FBADJA,FBADJAE
 N FBI,FBADJS
 S FBRET=""
 ;
 ; build sorted array containing external values
 S FBI=0 F  S FBI=$O(FBADJ(FBI)) Q:'FBI  D
 . ; obtain internal values
 . S FBADJR=$P(FBADJ(FBI),U)
 . S FBADJG=$P(FBADJ(FBI),U,2)
 . S FBADJA=$P(FBADJ(FBI),U,3)
 . ; convert to external values
 . S FBADJRE=$S(FBADJR:$P($G(^FB(161.91,FBADJR,0)),U),1:"")
 . S FBADJGE=$S(FBADJG:$P($G(^FB(161.92,FBADJG,0)),U),1:"")
 . S FBADJAE=$FN(FBADJA,"",2)
 . ; store in sorted array
 . S FBADJS(FBADJRE_U_FBI)=FBADJRE_U_FBADJGE_U_FBADJAE_U
 ;
 ; build list from sorted array
 S FBI="" F  S FBI=$O(FBADJS(FBI)) Q:FBI=""  D
 . S FBRET=FBRET_FBADJS(FBI)
 ; strip trailing "^" from list
 I $E(FBRET,$L(FBRET))="^" S FBRET=$E(FBRET,1,$L(FBRET)-1)
 ;
 Q FBRET
 ;
ADJLR(FBADJL) ; build list of adjustment reasons extrinsic function
 ; Input
 ;   FBADJL - required, string containing sorted list
 ;           (by external reason) of adjustments (see $$ADJL result)
 ; Result
 ;   sting of adjustment reasons delimited by commas
 ;
 N FBRET,FBADJRE
 N FBI
 S FBRET=""
 F FBI=1:3 S FBADJRE=$P(FBADJL,U,FBI) Q:FBADJRE=""  S FBRET=FBRET_FBADJRE_","
 ; strip trailing "," from list
 I $E(FBRET,$L(FBRET))="," S FBRET=$E(FBRET,1,$L(FBRET)-1)
 ;
 Q FBRET
 ;
ADJLA(FBADJL) ; build list of adjustment amounts extrinsic function
 ; Input
 ;   FBADJL - required, string containing sorted list
 ;           (by external reason) of adjustments (see $$ADJL result)
 ; Result
 ;   sting of adjustment reasons delimited by commas
 ;
 N FBRET,FBADJRE
 N FBI
 S FBRET=""
 F FBI=3:3 S FBADJRE=$P(FBADJL,U,FBI) Q:FBADJRE=""  S FBRET=FBRET_FBADJRE_","
 ; strip trailing "," from list
 I $E(FBRET,$L(FBRET))="," S FBRET=$E(FBRET,1,$L(FBRET)-1)
 ;
 Q FBRET
 ;
 ;FBUTL2
