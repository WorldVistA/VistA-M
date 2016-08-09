RCDPUDEP ;WISC/RFJ - Deposit Utilities ;29/MAY/2008
 ;;4.5;Accounts Receivable;**114,173,257,283,297,304**;Mar 20, 1995;Build 104
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ;
ADDDEPT(DEPOSIT,DEPDATE) ;  if the deposit is not entered, add it
 ;
 ;  if deposit date is missing, do not add the deposit
 I 'DEPDATE Q 0
 ;
 ;  already in file, deposit number and deposit date match
 N DA,RCDPFLAG
 S DA=0 F  S DA=$O(^RCY(344.1,"B",DEPOSIT,DA)) Q:'DA  I $P($G(^RCY(344.1,DA,0)),"^",3)=DEPDATE S RCDPFLAG=1 Q
 I $G(RCDPFLAG) Q DA
 ;
 ;  add it
 N %,%DT,D0,DA,DD,DI,DIC,DIE,DLAYGO,DO,DQ,DR,X,Y
 S DIC="^RCY(344.1,",DIC(0)="L",DLAYGO=344.1
 ;  .03 = deposit date               .06 = opened by
 ;  .07 = date/time opened           .12 = status (set to 1:open)
 S DIC("DR")=".03////"_DEPDATE_";.06////"_DUZ_";.07///NOW;.12////1;"
 S X=DEPOSIT
 D FILE^DICN
 I Y>0 Q +Y
 Q 0
 ;
 ;
SELDEPT(ADDNEW) ;  select a deposit
 ;  if $g(addnew) allow adding a new deposit
 ;  returns -1 for timeout or ^, 0 for no selection, or ien of deposit
 N %,%T,%Y,C,D0,DA,DIC,DIE,DLAYGO,DQ,DR,DTOUT,DUOUT,RCDEFLUP,X,Y
 S DIC="^RCY(344.1,",DIC(0)="QEAM",DIC("A")="Select DEPOSIT: "
 S DIC("W")="D DICW^RCDPUDEP"
 ;  use special lookup on input
 S RCDEFLUP=1
 I $G(ADDNEW) S DIC(0)="QEALM",DLAYGO=344.1,DIC("DR")=".03///TODAY;.06////"_DUZ_";.07///NOW;.12////1;"
 D ^DIC
 I Y<0,'$G(DUOUT),'$G(DTOUT) S Y=0
 Q +Y
 ;
 ;
DICW ;  write identifier code for receipt lookup
 N DATA
 S DATA=$G(^RCY(344.1,Y,0)) I DATA="" Q
 ;  opened by
 W ?13,"by: ",$E($P($G(^VA(200,+$P(DATA,"^",6),0)),"^"),1,15)
 ;  date opened
 I '$P(DATA,"^",7) S $P(DATA,"^",7)="???????"
 W ?35," on: ",$E($P(DATA,"^",7),4,5),"/",$E($P(DATA,"^",7),6,7),"/",$E($P(DATA,"^",7),2,3)
 ;  total dollars
 W ?50," amt: $",$J($P(DATA,"^",4),9,2)
 ;  status
 W ?69," ",$P("N/A^OPEN^DEPOSITED^CONFIRMED^PROCESSED^VOID","^",+$P(DATA,"^",12)+1)
 Q
 ;
 ;
LOOKUP ;  special lookup on deposits, called from ^dd(344.1,.01,7.5)
 ;  if rcdeflup flag not set, do not use special lookup
 I '$D(RCDEFLUP) Q
 ;  1:OPEN;3:CONFIRMED
 ;  user entered O.? for lookup on open deposits
 I X["O."!(X["o.") S DIC("S")="I $P(^(0),U,12)=1" S X="?" Q
 ;  user entered C.? for lookup on confirmed deposits
 I X["C."!(X["c.") S DIC("S")="I $P(^(0),U,12)=3" S X="?" Q
 ;  deposit ticket # manually added is for electronic ticket only
 ;  PRCA*283 - remove the restriction.
 ;I $G(DIC(0))["L",$$AUTODEP(X) D EN^DDIOL(" ** Deposit #'s starting with "_$E(X,1,3)_" can only be used by automatic deposits",,"!") S X="" Q
 ; PRCA*297 - change format of ticket #.
 I $G(DIC(0))["L",'$D(^RCY(344.1,"B",X)),X'?1A6N D MSG,EN^DDIOL(.MSG) S X="" Q
 K DIC("S"),MSG(1),MSG(2),MSG(3),MSG
 Q
 ;
 ;
EDITDEP(DA,ASKDATE) ;  edit the deposit
 ;  if $g(askdate) ask only the deposit date
 N %,D,D0,DI,DIC,DIE,DQ,DR,J,X,Y
 S (DIC,DIE)="^RCY(344.1,",DR=""
 ;  deposit date(.03), do not allow edit if closed or either lockbox
 I $$CHECKDEP^RCDPDPLU(DA) S DR=".03BANK DEPOSIT DATE//TODAY;"
 ;  bank(.13)
 S DR=DR_".13//"_$P($G(^RC(342.1,+$O(^RC(342.1,"AC",9,0)),0)),"^")_";"
 ;  bank trace(.05)
 S DR=DR_".05;"
 ;  agency title(.17)
 S DR=DR_".17//"_$P($G(^RC(342.1,+$O(^RC(342.1,"AC",10,0)),0)),"^")_";"
 ;  agency location code(.14), comments(1)
 S DR=DR_".14//"_$P(^RC(342,1,0),"^",7)_";1;"
 ;
 ;  only ask deposit date
 I $G(ASKDATE) S DR=".03BANK DEPOSIT DATE//TODAY;"
 D ^DIE
 Q
 ;
 ;
CONFIRM(DA) ;  confirm the deposit
 N %DT,D,D0,DI,DIC,DIE,DQ,DR,X,Y
 S (DIC,DIE)="^RCY(344.1,"
 S DR=".04///"_$$TOTAL(DA)_";.12////3;.1////"_DUZ_";.11///NOW;"
 D ^DIE
 Q
 ;
 ;
TOTAL(RCDEPTDA) ;  compute total dollars for all receipts on the deposit
 N RCRECTDA,RCTRANDA,TOTAL
 S RCRECTDA=0
 F  S RCRECTDA=$O(^RCY(344,"AD",RCDEPTDA,RCRECTDA)) Q:'RCRECTDA  D
 .   S RCTRANDA=0
 .   F  S RCTRANDA=$O(^RCY(344,RCRECTDA,1,RCTRANDA)) Q:'RCTRANDA  D
 .   .   S TOTAL=$G(TOTAL)+$P($G(^RCY(344,RCRECTDA,1,RCTRANDA,0)),"^",4)
 Q +$G(TOTAL)
 ;
AUTODEP(X) ; Function returns 1 if the deposit ticket # in X is in the auto
 ; deposit number space 269xxx, 369xxx, 469xxx, 569xxx, or 669xxx
 ; and hasn't been previously entered via lockbox interface.
 ; 
 N Y
 S Y=0
 I $L(X)=6,$E(X,2,3)="69","23456"[$E(X),'$D(^RCY(344.1,"B",X)) S Y=1
 Q Y
 ;
CHK ; Check if a valid input
 D MSG
 I '$D(X) D EN^DDIOL(.MSG) Q
 I X?6N!(X?9N) Q
 I X?1A6N Q
 D EN^DDIOL(.MSG)
 K X,MSG(1),MSG(2),MSG(3),MSG
 Q
 ;
MSG ;
 S MSG(1)=" * Ticket numbers must have one alpha character followed by six digits or"
 S MSG(2)="   any 6 or 9 digits existing deposit ticket #."
 S MSG(3,"F")="!"
 Q
 ;
 ;PRCA*4.5*304
PREPDEPT()   ;Check to see if Deposit number is currently in use.
 ;
 N RCARRAY,RCDEP,RCNOW,RCOPT,RCRESULT,RCDA,RCTODAY,RCVALID,RCANS,MSG
 ;
 ; Ask for the deposit number, checking for the lookup
 ; continue until the user wishes to quit.
 ;
 ; Exist Deposit retrieval loop if the user wishes to exit or the user selects a deposit 
 F  D  Q:RCOPT=""  Q:RCANS
 . N DA,DIR,X,Y,DTOUT,DIROUT,DUOUT,DIRUT    ;define ^DIR variables
 . S (RCOPT,Y,X)="",RCANS=0
 . S DIR(0)="FO"
 . S DIR("?")="^D ARYLST^RCDPUDEP"
 . S DIR("??")="^D ARYPRNT^RCDPUDEP"
 . S DIR("A")="Select Deposit"
 . D ^DIR
 . ;
 . ; Exit if user wishes to abort 
 . I $G(DTOUT)!($G(DUOUT))!($G(DIROUT))!(Y="") Q
 . S RCDEP=Y
 . ;
 . K DA,DIR,X,Y,DTOUT,DIROUT,DUOUT,DIRUT   ; clean up ^DIR variables
 . ;
 . S RCVALID=0
 . ; quit if input is invalid, 
 . S:(RCDEP?6N)!(RCDEP?9N) RCVALID=1
 . S:(RCDEP?1A6N) RCVALID=1
 . I 'RCVALID D  Q
 . . S RCOPT="X"  ; Allow the user to retry
 . . D MSG
 . . D EN^DDIOL(.MSG)
 . . K MSG
 . ;
 . ; if it exists, display and ask for a deposit date with today as the default
 . ; Parameters - File,,Field(s),Look Up flags,deposit #,,,,,result array
 . ;
 . ; Valid Deposit, re-init exit flag
 . S RCOPT=0  ; 
 . ;
 . D FIND^DIC(344.1,"","@;.01;.03I;.12I","M",RCDEP,"","","","","RCARRAY")
 . ;
 . ; Numeric deposit ticket numbers can only be edited, not created.
 . I (+$G(RCARRAY("DILIST",0))=0),(RCDEP?9N) D MSG,EN^DDIOL(.MSG) K MSG Q
 . ;
 . ;if the deposit number has been used before, then check with user to see if a new
 . ;  one should be created.  If not, then and "x" is returned.  Otherwise, the new
 . ;  the user's selection is returned.
 . I +$G(RCARRAY("DILIST",0))>0 S RCOPT=$$DISPOPT(.RCARRAY)
 . ;
 . Q:(RCOPT="u")!(RCOPT="x")!(RCOPT="")
 . ;
 . ; If user selected a deposit, return the deposit #
 . I +RCOPT S RCDA=$G(RCARRAY("DILIST",2,RCOPT)),RCANS=RCOPT Q
 . ;
 . ; Confirm with user to add new deposit number
 . ; Reset ^DIR input and output variables
 . N DA,DIR,X,Y,DTOUT,DIROUT,DUOUT,DIRUT   ; define ^DIR variables
 . S DIR(0)="YO",DIR("B")="NO"
 . S DIR("A")="  Are you adding "_RCDEP_" as a new Deposit ticket (Y/N) "
 . D ^DIR
 . ;
 . ; Exit if user wishes to abort 
 . ;I $G(DTOUT)!($G(DUOUT))!($G(DIROUT)) S RCOPT="" Q
 . I $G(DTOUT)!($G(DUOUT))!($G(DIROUT)) Q
 . ;
 . S RCANS=+Y
 . K DA,DIR,X,Y,DTOUT,DIROUT,DUOUT,DIRUT  ;clean up ^DIR variables
 ;
 ; Exit if user wishes to quit (RCOPT="").
 Q:RCOPT="" ""
 Q:+RCOPT RCDA
 ;
 ;  add it
 N %,%DT,D0,DA,DD,DI,DIC,DIE,DLAYGO,DO,DQ,DR,X,Y
 S DIC="^RCY(344.1,",DIC(0)="L",DLAYGO=344.1
 ;
 ;Init local versions of NOW and TODAY
 S RCNOW=$$NOW^XLFDT,RCTODAY=$P(RCNOW,".")
 ;
 ;  .03 = deposit date               .06 = opened by
 ;  .07 = date/time opened           .12 = status (set to 1:open)
 S DIC("DR")=".03////"_RCTODAY_";.06////"_DUZ_";.07///"_RCNOW_";.12////1"
 S X=RCDEP
 D FILE^DICN
 I Y>0 Q +Y
 Q 0
 ;
 ;PRCA*4.5*304
DISPOPT(RCARRAY) ; display the deposits to select from
 ;
 N RCARYCT,RCCT,RCDATA,RCDPDT,RCIEN,RCNOW,RCTODAY
 N DA,DIR,MSG,X,Y,DTOUT,DIROUT,DUOUT,DIRUT
 ;
 ;Init local versions of NOW and TODAY
 S RCNOW=$$NOW^XLFDT,RCTODAY=$P(RCNOW,".")
 ;
 ;Get the number of entries in the array
 S RCARYCT=+RCARRAY("DILIST",0)
 ;
 ; Loop to retrieve user's desired version of the Deposit.
 F  D  Q:Y'=""
 . ;Create some separation from the last item printed
 . W !!  ; Create some separation
 . ;
 . ;Display options to user
 . F RCCT=1:1:RCARYCT D
 . . S RCIEN=$G(RCARRAY("DILIST",2,RCCT))
 . . S RCDATA=$G(^RCY(344.1,RCIEN,0)) I RCDATA="" Q
 . . W RCCT,?3,$P(RCDATA,U)
 . . W ?13,"by: ",$E($P($G(^VA(200,+$P(RCDATA,"^",6),0)),"^"),1,15)
 . . I '$P(RCDATA,"^",7) S $P(RCDATA,"^",7)="???????"
 . . W ?35," on: ",$E($P(RCDATA,"^",7),4,5),"/",$E($P(RCDATA,"^",7),6,7),"/",$E($P(RCDATA,"^",7),2,3)
 . . W ?50," amt: $",$J($P(RCDATA,"^",4),9,2)
 . . W ?69," ",$P("N/A^OPEN^DEPOSITED^CONFIRMED^PROCESSED^VOID","^",+$P(RCDATA,"^",12)+1),!
 . ;
 . ; ask user which deposit to edit or select the default which is NEW
 . ;
 . S DIR(0)="FO" ;,DIR("B")="NEW"
 . S DIR("A",1)="  Enter the line# to view an existing deposit or (N) to create a NEW deposit"
 . S DIR("A")="  or e(X)it"
 . D ^DIR
 . W !   ;spacing after DIR call.
 . ;
 . ; Exit if user wishes to abort 
 . I $G(DTOUT)!($G(DUOUT))!($G(DIROUT)) S Y="^" Q
 . ;
 . ;The user entered an incorrect deposit # so exit.
 . S Y=$$UP^XLFSTR(Y)
 . I (Y'?1N.N),(Y'="N") S Y="x" Q
 . ;
 . ; If New, double-check to see if deposit hasn't been created for today already.  If so, clear the user response
 . ; and ask them to try again.
 . I Y="N" D
 . . ; Double-check to ensure a current one for today is not open already.
 . . F RCCT=1:1:RCARYCT D  Q:Y=""
 . . . S RCDPDT=$G(RCARRAY("DILIST","ID",RCCT,".03"))
 . . . I RCDPDT=RCTODAY D
 . . . . S Y=""               ;Invalid response.  Re-init and force the user to retry
 . . . . S MSG(1)="ERROR: Entered Deposit Ticket# already exists for today - Please"
 . . . . S MSG(2)="       select the appropriate line # to modify the existing"
 . . . . S MSG(3)="       deposit or e(X)it to enter a different Deposit Ticket#."
 . . . . D EN^DDIOL(.MSG)
 . . . . K MSG
 . . . S RCSTAT=$G(RCARRAY("DILIST","ID",RCCT,".12"))
 . . . I RCSTAT'=3 D    ; If the deposit is not confirmed, error out
 . . . . S Y=""               ;Invalid response.  Re-init and force the user to retry
 . . . . S MSG(1)="ERROR: Cannot create new deposit ticket- there is an existing"
 . . . . S MSG(2)="       deposit with the same # that is not in CONFIRMED status"
 . . . . D EN^DDIOL(.MSG)
 . . . . K MSG
 . I (Y?1N.N),(Y<1)!(Y>RCARYCT) S Y="u"
 ;
 Q:Y="^" ""   ;  send a "t" to indicate a user requested exit to force a reprompt of the Select Deposit Prompt.  
 Q Y
 ;
 ; Mimic ? and ?? functionality in DIC calls
 ;PRCA*4.5*304
ARYLST ;
 ;
 N X,Y,DIROUT,DIRUT,DUOUT,DTOUT,DIR
 S DIR("A",1)="Answer with AR DEPOSIT TICKET #"
 S DIR("A")="Do you want the entire "_$P($G(^RCY(344.1,0)),U,4)_"-Entry AR DEPOSIT List? "
 S DIR(0)="Y",DIR("B")="N"
 D ^DIR
 ;
 ;User answered Yes (value 1), so print the list as if doing a ??
 I Y=1 D ARYPRNT  ;print the list
 Q 
 ;
 ;Print the list of deposits (mimicking a ^DIC or pointer type DIR call)
 ;PRCA*4.5*304
ARYPRNT ;
 ;
 N I,Y,ENDFLG,RCCT
 ;
 W !!,?3,"Choose from:",!
 S I="",(ENDFLG,RCCT)=0
 F  S I=$O(^RCY(344.1,"B",I)) Q:I=""  D  Q:ENDFLG
 . S Y=""
 . F  S Y=$O(^RCY(344.1,"B",I,Y)) Q:Y=""  D  Q:ENDFLG
 . . S RCCT=RCCT+1
 . . W ?3,I
 . . D DICW
 . . W !   ;Write the end
 . . I RCCT>(IOSL-3) D
 . . . ;ask if user wishes to continue, reset line counter
 . . . S ENDFLG=$$PROMPT(),RCCT=0
 ;
 ;Print the list
 ;
 ;End of list printout
 W !!,?5,"You may enter a new AR DEPOSIT, if you wish",!
 W ?5,"Answer must be 7 characters in length. 9 digits can only be entered",!
 W ?5,"by automated payments.",!!
 Q
 ;
 ;PRCA*4.5*304
 ;Prompt user to continue
PROMPT() ;
 ;
 N X,Y,DIROUT,DIRUT,DUOUT,DTOUT,DIR
 S DIR("A")="'^' to stop"
 S DIR(0)="FO"
 D ^DIR
 ;
 ;If time out or user ^ then send exit flag, otherwise, continue
 I $D(DTOUT)!$D(DUOUT) Q 1
 Q 0
