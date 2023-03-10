RCDPESP ;BIRM/EWL - ePayment Lockbox Site Parameters Definition - Files 344.61 & 344.6 ; 6/3/19 1:59pm
 ;;4.5;Accounts Receivable;**298,304,318,321,326,332,345,349**;Mar 20, 1995;Build 44
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; entry point for EDI Lockbox Parameters [RCDPE EDI LOCKBOX PARAMETERS]
 N CATS,DA,DIC,DIE,DIR,DIRUT,DLAYGO,DR,DTOUT,DUOUT,X,Y  ; FileMan variables
 ;
 W !," Update AR Site Parameters",!
 ;
 S X="RCDPE AUTO DEC"
 I '$D(^XUSEC(X,DUZ)) D  Q
 . W !!,"You do not hold the "_X_" security key."
 ; Lock the parameter file
 L +^RCY(344.61,1):DILOCKTM E  D  Q
 . W !!," Another user is currently using the AR Site Parameters option."
 . W !," Please try again later."
 ;
 ; PRCA*4.5*326 - Once lock is successful, take a snapshot of the parameters for monitoring
 D EN^RCDPESP6
 ;
 ; Check parameter file
 N FDAEDI,FDAPAYER,IEN,IENS,RCQUIT
 ; FDAPAYER - FDA array for RCDPE AUTO-PAY EXCLUSION file (#344.6)
 ; FDAEDI - FDA array for RCDPE PARAMETER file (#344.61)
 ; RCAUDVAL - audit data for RCDPE PARAMETER AUDIT file (#344.7)
 ; IEN - entry #
 ; IENS - IEN_comma
 ; RCQUIT - exit flag
 ;
 ; PRCA*4.5*349 - Added categories prompt
 S CATS=$$CATS^RCDPESPC
 I CATS="" D  Q
 . S RCQUIT=1
 . D ABORT
 S RCQUIT=0
 I CATS'="AL" D ENCATS^RCDPESPC Q
 ; Call below answers:
 ; NUMBER OF DAYS EFT UNMATCHED
 ; NUMBER OF DAYS ERA UNMATCHED
 ; # OF DAYS ENTRY CAN REMAIN IN SUSP
 ; AUTO-DECREASE FIRST PARTY
 ; PRCA*4.5*349 - Added headings to old version of option
 W !,"### EDI Lockbox Site & First Party Parameters ###",!
 S Y=$$EDILOCK^RCMSITE  ; Update EDI Lockbox site parameters
 I 'Y D  Q  ; user entered '^'
 . S RCQUIT=1
 . D ABORT
 ;
 ; PRCA*4.5*304 - Enable/disable auto-auditing of paper bills
 W !!,"### Auto-Audit Site Parameters ###"
 S RCQUIT=$$AUDIT^RCDPESP5  ; Auto-Audit site parameters
 I RCQUIT D ABORT Q  ; PRCA*4.5*326 must have single exit point
 ;
 I '$D(^RCY(344.61,1,0)) D  Q  ;
 . W !!,"There is a problem with the RCDPE PARAMETER file (#344.61).",!
 . D EXIT
 ;
 W !!,"### Workload Notification Day Parameter ###"
 S RCQUIT=$$BULLDAY  ; Workload Notification Day parameter
 I RCQUIT D ABORT Q
 ;
 ; Ask Medical Claims Auto-Post/Auto-Decrease questions
 W !,"### Medical Claims Auto-Post/Auto-Decrease Parameters ###",!
 S RCQUIT=$$MPARMS
 I $G(RCQUIT) D ABORT Q
 W !
 ;
 ; Ask Rx Auto-Post/Auto-Decrease questions
 W !,"### Pharmacy Auto-Post/Auto-Decrease Parameters ###",!
 S RCQUIT=$$RXPARMS
 I $G(RCQUIT) D ABORT Q
 W !
 ;
 W !,"### TRICARE Auto-Post/Auto-Decrease Parameters ###",!
 ; PRCA*4.5*349 - Ask TRICARE Auto-Post/Auto-Decrease questions
 S RCQUIT=$$TPARMS
 I $G(RCQUIT) D ABORT Q
 W !
 ;
 W !,"### EFT Lock-Out Parameters ###",!
 S RCQUIT=$$EFTLK  ; Set EFT lock-out paramters 
 I $G(RCQUIT) D ABORT Q
 D EXIT
 Q
BULLDAY() ; Workload Notification Bulletin Days question
 ; (SELECT DAY TO SEND WORKLOAD NOTIFICATION)
 ; Returns: 1 - User '^' or timed out, 0 otherwise
 ; PRCA*4.5*321 - New parameter
 N BULL,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FDAEDI,RCAUDVAL,X,Y
 ;
 S BULL=$$GET1^DIQ(344.61,"1,",.1,"I")
 K DIR
 S:BULL'="" DIR("B")=BULL
 S DIR("?")=$$GET1^DID(344.61,.1,,"HELP-PROMPT")
 S DIR("A")=$$PADPRMPT^RCDPESPB($$GET1^DID(344.61,.1,,"TITLE"))
 S DIR(0)="344.61,.1"
 W ! D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 I BULL'=Y D  ; update and audit
 . S RCAUDVAL(1)="344.61^.1^1^"_Y_U_BULL
 . S FDAEDI(344.61,"1,",.1)=Y
 . D FILE^DIE(,"FDAEDI")
 . D AUDIT(.RCAUDVAL)
 W !
 Q 0
 ;
APOST(AUPSTYP,ONOFF) ; Turn Auto-Posting On/Off for Medical,RX,TRICARE Claims
 ; PRCA*4.5*345
 ; Input: AUPSTYP - 0 - Medical Auto-Posting
 ;                  1 - Pharmacy Auto-Posting
 ;                  2 - TRICARE Auto-Posting
 ; Output: ONOFF passed by ref. 1 - Auto-Posting of Medical/Pharmacy/TRICARE Claims with Payments on, 0 otherwise
 ; Returns: 1 - User '^' or timed out, 0 otherwise
 N APCT,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FLD,FDAEDI,RCAUDVAL
 S FLD=$S(AUPSTYP=0:.02,AUPSTYP=1:1.01,1:1.05) ; PRCA*4.5*349 - Add TRICARE
 S APCT=$$GET1^DIQ(344.61,"1,",FLD,"I")
 S DIR(0)="YA",DIR("B")=$S((APCT=1)!(APCT=""):"Yes",1:"No")
 S DIR("A")=$$PADPRMPT^RCDPESPB($$GET1^DID(344.61,FLD,,"TITLE"))
 S DIR("?")=$$GET1^DID(344.61,FLD,,"HELP-PROMPT")
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 S ONOFF=Y
 I APCT'=Y D  ; User updated value
 . S FDAEDI(344.61,"1,",FLD)=Y
 . D FILE^DIE(,"FDAEDI")
 . D NOTIFY(Y,AUPSTYP)
 . S RCAUDVAL(1)="344.61^"_FLD_"^1^"_Y_U_APCT
 . D AUDIT(.RCAUDVAL)
 Q 0
 ;
 ; PRCA*4.5*349 - Refactored MPARMS to separate Auto-Post and Auto-Decrease questions
MPARMS() ; Medical Auto-Posting Questions
 ; Returns: 1 - User '^' or timed out, 0 otherwise
 N RETURN,ONOFF
 S RETURN=$$MAUTOP(.ONOFF)
 Q:RETURN RETURN
 Q:ONOFF=0 0
 Q $$MAUTOD^RCDPESPC
 ;
 ; PRCA*4.5*349 - New function to ask only Medical Auto-Post questions
MAUTOP(ONOFF) ; Medical Claims Auto-Posting/Auto-Decrease questions
 ; Output: ONOFF passed by ref. 1 - Auto-Posting of Medical Claims with Payments on
 ;                              0 - otherwise
 ; Returns: 1 - User '^' or timed out, 0 otherwise
 N DIR,DIROUT,DIRUT,DTPIT,DUOUT,RCOLD,RCQUIT ; PRCA*4.5*349
 S RCQUIT=$$APOST(0,.ONOFF)  ; Auto-Posting of Med Claims parameter
 Q:RCQUIT 1
 Q:ONOFF=0 0  ; Medical Claim Auto-Posting turned off
 ;
 D EXCLLIST(1)  ; Display existing Payer exclusions for Med Auto-Post
 Q:$$SETEXCL(1) 1  ; Set/Reset Payer Exclusions
 D EXCLLIST(1)  ; Display new Payer Exclusion list
 Q 0
 ;
 ; PRCA*4.5*349 - Refactored RXPARMS to separate Auto-Post and Auto-Decrease questions
RXPARMS() ; Pharmacy Auto-Posting Questions
 ; Returns: 1 - User '^' or timed out, 0 otherwise
 N RETURN,ONOFF
 S RETURN=$$RXAUTOP(.ONOFF)
 Q:RETURN RETURN
 Q:ONOFF=0 0
 Q $$RXAUTOD^RCDPESPC
 ;
 ; PRCA*4.5*349 - New function to ask only Pharmacy Auto-Post questions
RXAUTOP(ONOFF) ; Rx Claims Auto-Posting/Auto-Decrease questions
 ; Enable/disable auto-posting of pharmacy claims
 ; PRCA*4.5*349 - Subroutine re-written as was intended for PRCA*4.5*345
 ; Output: ONOFF passed by ref. 1 - Auto-Posting of Medical Claims with Payments on
 ;                              0 - otherwise
 ; Returns: 1 - User '^' or timed out, 0 otherwise
 N RETURN
 Q:$$APOST(1,.ONOFF) 1 ; Auto-Posting of Rx Claims parameter
 Q:ONOFF=0 0 ; Rx Auto-Posting turned off
 D EXCLLIST(3) ; Display existing Payer exclusions for Rx Auto-Post
 Q:$$SETEXCL(3) 1 ; Set/Reset Payer Exclusions
 D EXCLLIST(3) ; Display the new Payer Exclusion list
 W !
 Q 0
 ;
ABORT ; Called when user enters a '^' or times out
 ; fall through to EXIT
 ;
EXIT ; Unlock, ask user to press return, exit
 D EXIT^RCDPESP6 ; PRCA*4.5*326 - Send mail message if parameters have been edited.
 L -^RCY(344.61,1)
 D PAUSE
 Q
 ;
 ; PRCA*4.5*349 - Refactored TPARMS to separate Auto-Post and Auto-Decrease questions
TPARMS() ; Pharmacy Auto-Posting Questions
 ; Returns: 1 - User '^' or timed out, 0 otherwise
 N RETURN,ONOFF
 S RETURN=$$TAUTOP(.ONOFF)
 Q:RETURN RETURN
 Q:ONOFF=0 0
 Q $$TAUTOD^RCDPESPC
 ;
 ; PRCA*4.5*349 - New function to ask only TRICARE Auto-Post questions
TAUTOP(ONOFF) ; TRICARE Auto-Posting questions
 ; PRCA*4.5*349 - Added function
 ; Output: ONOFF passed by ref. 1 - Auto-Posting of Medical Claims with Payments on
 ;                              0 - otherwise
 ; Returns: 1 - User '^' or timed out, 0 otherwise
 N RCQUIT,RETURN
 S RCQUIT=$$APOST(2,.ONOFF)         ; Auto-Posting of TRICARE Claims parameter
 I RCQUIT Q 1
 Q:ONOFF=0 0                        ; TRICARE Claim Auto-Posting turned off
 D EXCLLIST(5)                      ; Display existing Payer exclusions for TRICARE Auto-Post
 Q:$$SETEXCL(5) 1                   ; Set/Reset Payer Exclusions
 D EXCLLIST(5)                      ; Display the new Payer Exclusion list
 Q 0
 ;
EFTLK() ; Set EFT lock-out parameters, PRCA*4.5*345
 ; Returns: 1 - User '^' or timed out
 ; 0 otherwise
 Q:$$EFTLKPRM(.06) 1  ; (#.06) MEDICAL EFT POST PREVENT DAYS [6N]
 Q:$$EFTLKPRM(.07) 1  ; (#.07) PHARMACY EFT POST PREVENT DAYS [7N]
 Q:$$EFTLKPRM(.13) 1  ; (#.13) TRICARE EFT POST PREVENT DAYS [13N]
 Q 0
 ;
EFTLKPRM(FLD) ; Ask a Medical/Rx EFT lock-out question, PRCA*4.5*345
 ; NUMBER OF DAYS (AGE) OF UNPOSTED xxx EFTS TO PREVENT POSTING
 ; Input: FLD - Field # of question being asked
 ; Returns: 1 - User '^' or timed out
 ; 0 otherwise
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,RCVAL,X,Y
 S RCVAL=$$GET1^DIQ(344.61,"1,",FLD)
 S:RCVAL'="" DIR("B")=RCVAL,DA=1  ; default value and IEN
 S DIR(0)="344.61,"_FLD_"A",DIR("A")=$$PADPRMPT^RCDPESPB($$GET1^DID(344.61,FLD,,"TITLE"))
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 I RCVAL'=Y D  ; Update and audit
 . N AUDVAL
 . S RCAUDVAL(1)="344.61^"_FLD_"^1^"_Y_U_RCVAL
 . S FDAEDI(344.61,"1,",FLD)=Y D FILE^DIE(,"FDAEDI")
 . D AUDIT(.RCAUDVAL)
 Q 0
 ;
PAUSE ; prompt user to press return
 W ! N DIR
 S DIR("T")=3,DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR
 Q
 ;
COUNT(ACTVCARC,PDCLM,CLMTYP) ;Count active CARCs in file 344.62 (RCDPE CARC-RARC AUTO DEC)
 ; PRCA*4.5*345 - Added PDCLM,CLMTYP
 ; Input: ACTVCARC: 0 - Count inactive CARCs, 1 - Count active CARCs
 ; PDCLM: 0 - Paid Claims, 1 - No-Pay Claims
 ; CLMTYP: - 0 - Medical, 1 - pharm, 2 - TRICARE
 ; Returns: 0 - Invalid parameter, otherwise the number of active CARCs are returned
 N I,NUM,XREF  ; PRCA&4.5*345 - Added XREF
 I (ACTVCARC'=0),(ACTVCARC'=1) Q 0 ; If ACTVCARC is not active (1) or inactive (0) quit with zero
 S XREF=""
 I 'PDCLM,'CLMTYP S XREF="ACTV"  ; (#.02) CARC AUTO DECREASE [2S]
 I XREF="",'PDCLM,CLMTYP=1 S XREF="ACTVR"  ; (#2.01) CARC PHARM AUTO DECREASE
 I XREF="",'PDCLM,CLMTYP=2 S XREF="ACTVT"  ; PRCA*4.5*349 (#3.01) CARC TRICARE W PYMNTS AUTO-DEC [1S]
 I XREF="",PDCLM,CLMTYP=0 S XREF="ACTVN"  ; (#.08) CARC AUTO DECREASE NO-PAY [1S]
 I XREF="",PDCLM,CLMTYP=2 S XREF="ACTVNT"  ; PRCA*4.5*349 (#3.07) CARC TRICARE AUTO-DECRS NO-PAY [7S]
 ;
 I XREF="" Q 0  ; need a cross-reference, return zero
 ; count entries on the cross-ref.
 S NUM=0,I="" F  S I=$O(^RCY(344.62,XREF,ACTVCARC,I)) Q:I=""  S NUM=NUM+1
 Q NUM
 ;
EXCLLIST(TYP) ; Display Payer Exclusion lists for Auto-Post and Auto-Decrease
 ; for Medical, Pharmacy and TRICARE
 ; PRCA*4.5*349 - Added Rx/TRICRE options
 ; Input: TYP - 1 - Medical Auto-Post payer exclusions
 ;              2 - Medical Auto-Decrease payer exclusions
 ;              3 - Rx Auto-Post payer exclusions
 ;              4 - Rx Auto-Decrease payer exclusions
 ;              5 - TRICARE Auto-Post payer exclusions
 ;              6 - TRICRE Auto-Decrease payer exclusions
 ;
 Q:'("^1^2^3^4^5^6^"[(U_$G(TYP)_U))  ; PRCA*4.5*349 - TYP must be valid
 N CT,EXCHDR,IEN,IX,LIST
 S (IEN,CT)=0
 W !
 ; Determine which index to used
 ; PRCA*4.5*345 Start modified code block - added Rx/TRICARE options
 I TYP=1 D
 . S IX="EXMDPOST"
 . S LIST="Payers excluded from Medical Auto-Posting:"
 E  I TYP=2 D
 . S IX="EXMDDECR"
 . S LIST="Additional Payers excluded from Medical Auto-Decrease:"
 E  I TYP=3 D
 . S IX="EXRXPOST"
 . S LIST="Payers excluded from Pharmacy Auto-Posting:"
 E  I TYP=4 D
 . S IX="EXRXDECR"
 . S LIST="Additional Payers excluded from Pharmacy Auto-Decrease:"
 ; PRCA*4.5*349 - Add TRICARE
 E  I TYP=5 D
 . S IX="EXTRPOST"
 . S LIST="Additional Payers excluded from TRICARE Auto-Posting:"
 E  D
 . S IX="EXTRDECR"
 . S LIST="Additional Payers excluded from TRICARE Auto-Decrease:"
 ;
 ; if list is for auto-decrease and there are exclusions write a message
 S (IEN,CT)=0
 F  D  Q:'IEN
 . S IEN=$O(^RCY(344.6,IX,1,IEN))
 . Q:'IEN
 . S CT=CT+1
 . W:CT=1 !,LIST
 . W !," "_$P(^RCY(344.6,IEN,0),U,1)_" "_$P(^RCY(344.6,IEN,0),U,2)
 ;
 I TYP=2!(TYP=4)!(TYP=6) D
 . W !,"All payers excluded from Auto-Posting are also excluded from Auto-Decrease."
 ;
 I CT=0 W !," No "_LIST
 ; PRCA*4.5*349 - End modified code block
 Q
 ;
SETEXCL(TYP) ; LOOP FOR SETTING PAYER EXCLUSIONS for Medical, Rx and TRICARE and Auto-Decrease payer exclusions
 ; PRCA*4.5*349 - Added Rx/TRICARE sets
 ; Input: TYP - 1 - Set Medical Auto-Post payer exclusions
 ;              2 - Set Medical Auto-Decrease payer exclusions
 ;              3 - Set Rx Auto-Post payer exclusions
 ;              4 - Set Rxl Auto-Decrease payer exclusions
 ;              5 - Set TRICARE Auto-Post payer exclusions
 ;              6 - Set TRICARE Auto-Decrease payer exclusions
 ; Returns: 1 - User '^' or timed out
 ;          0 otherwise
 ;
 N CMT,CT,DIC,DIR,DONE,FDAPAYER,FLD,IEN,PREC,RCAUDVAL,RCQUIT,RTYP,X,XX,Y
 ; PRCA*4.5*349 - Added Rx/TRICARE claims decrease
 I $G(TYP)=1 S FLD=.06,CMT=1,RTYP="MEDICAL CLAIMS POSTING"
 E  I $G(TYP)=2 S FLD=.07,CMT=2,RTYP="MEDICAL CLAIMS DECREASE"
 E  I $G(TYP)=3 S FLD=.08,CMT=3,RTYP="PHARMACY CLAIMS POSTING"
 E  I $G(TYP)=4 S FLD=.12,CMT=4,RTYP="PHARMACY CLAIMS DECREASE"
 E  I $G(TYP)=5 S FLD=.13,CMT=5,RTYP="TRICARE CLAIMS POSTING"
 E  S FLD=.14,CMT=6,RTYP="TRICARE CLAIMS DECREASE"
 ;
 W !!,"Select a Payer to add or remove from the exclusion list.",!
 S (RCQUIT,CT,DONE)=0
 F  Q:DONE!RCQUIT  D
 . S DIC="^RCY(344.6,",DIC(0)="AEMQZ",DIC("A")="Payer: "
 . S DIC("S")="I $$PAYTYP^RCDPESPB("_TYP_","_FLD_")" ; PRCA*4.5*349
 . D ^DIC
 . I X="^" S RCQUIT=1 Q
 . I +$G(Y)<1 S DONE=1 Q
 . S CT=CT+1,IEN=+Y,PREC=Y(0)
 . K FDAPAYER
 . N COMMENT,STAT
 . S COMMENT="",STAT='$$GET1^DIQ(344.6,IEN_",",FLD,"I")
 . S FDAPAYER(344.6,IEN_",",FLD)=STAT
 . ; GET COMMENT HERE
 . K Y S DIR("A")="COMMENT: ",DIR(0)="FA^3:72"
 . S DIR("PRE")="S X=$$TRIM^XLFSTR(X,""LR"")" ; comment required and should be significant
 . S DIR("?")="Enter an explanation for "_$S(STAT:"adding the payer to",1:"removing the payer from")_" the list of Excluded Payers."
 . S XX="Enter an explanation for "
 . S XX=XX_$S(STAT:"adding the payer to",1:"removing the payer from")
 . S DIR("?")=XX_" the list of Excluded Payers."
 . D ^DIR
 . I $D(DTOUT)!$D(DUOUT) S RCQUIT=1 Q
 . I Y="" S DONE=1 Q  ; stop loop
 . S COMMENT=Y
 . I COMMENT'="" D
 . . S FDAPAYER(344.6,IEN_",",CMT)=$S(STAT:COMMENT,1:"")
 . . W !,$P(PREC,U)_" "_$P(PREC,U,2)_" has been "_$S(STAT:"added to",1:"removed from")_" the list of Excluded Payers"
 . . I TYP=1 D
 . . . W !,"If Medical Auto-Decrease is turned on, "
 . . . I STAT W "this payer will be excluded from Medical Auto-Decrease too."
 . . . I 'STAT,'$$GET1^DIQ(344.6,IEN_",",.07,"I") W "this payer will no longer be excluded from Medical Auto-Decrease."
 . . . I 'STAT,$$GET1^DIQ(344.6,IEN_",",.07,"I") W "Medical Auto-Decrease is set to be excluded for this payer."
 . . ;
 . . ; PRCA*4.5*349 - Added if below
 . . I TYP=3 D
 . . . W !,"If pharmacy auto-decrease is turned on, "
 . . . I STAT W "this payer will be excluded from Pharmacy auto-decrease too."
 . . . I 'STAT,'$$GET1^DIQ(344.6,IEN_",",.12,"I") D
 . . . . W "this payer will no longer be excluded from Pharmacy Auto-Decrease."
 . . . I 'STAT,$$GET1^DIQ(344.6,IEN_",",.12,"I") D
 . . . . W "Pharmacy Auto-Decrease is set to be excluded for this payer."
 . . ;
 . . ; PRCA*4.5*349 - Added if below
 . . I TYP=5 D
 . . . W !,"If TRICARE auto-decrease is turned on, "
 . . . I STAT W "this payer will be excluded from TRICARE Auto-Decrease too."
 . . . I 'STAT,'$$GET1^DIQ(344.6,IEN_",",.14,"I") D
 . . . . W "this payer will no longer be excluded from TRICARE Auto-Decrease."
 . . . I 'STAT,$$GET1^DIQ(344.6,IEN_",",.14,"I") D
 . . . . W "TRICARE Auto-Decrease is set to be excluded for this payer."
 . . K RCAUDVAL
 . . D FILE^DIE(,"FDAPAYER")
 . . S RCAUDVAL(1)="344.6"_U_FLD_U_IEN_U_STAT_U_('STAT)_U_COMMENT
 . . D AUDIT(.RCAUDVAL)
 ;
 Q RCQUIT
 ;
NOTIFY(VAL,TYPE) ; Notification of change to Site Parameters
 N C,G,GLB,MSG,SITE,SUBJ,XMINSTR,XMTO
 S SITE=$$SITE^VASITE
 S TYPE=$G(TYPE)  ; optional parameter
 ; limit subject to 65 chars.
 S SUBJ=$E("Site Parameter edit, Station #"_$P(SITE,U,3)_" - "_$P(SITE,U,2),1,65)
 D XMSGBODY^RCDPESPB(.MSG)  ; body of message
 S C=MSG  ; line count
 S C=C+1
 S MSG(C)="  ENABLE AUTO-POSTING OF "_$S(TYPE=1:"PHARMACY",TYPE=2:"TRICARE",1:"MEDICAL")_" CLAIMS = "
 S MSG(C)=MSG(C)_$$FRMT^RCDPESP6(VAL,"B")
 S C=C+1,MSG(C)=" "
 ;send message to mail group
 S XMTO(DUZ)="",XMTO("G.RCDPE AUDIT")=""
 K ^TMP("XMERR",$J)
 D SENDMSG^XMXAPI(DUZ,SUBJ,"MSG",.XMTO,.XMINSTR)
 I $D(^TMP("XMERR",$J)) D
 . D MES^XPDUTL("MailMan reported a problem trying to send the notification message.")
 . D MES^XPDUTL("MailMan error text:")
 . S (G,GLB)=$NA(^TMP("XMERR",$J))
 . F  S G=$Q(@G) Q:G'[GLB  D MES^XPDUTL(" "_@G)
 . D MES^XPDUTL("* End of MailMan Error *")
 Q
 ;
AUDIT(INP) ; WRITE AUDIT RECORD(S)
 ; INP = audit value in this format:
 ;       FILE NUMBER^FIELD NUMBER^IEN^NEW VALUE^OLD VALUE^COMMENT
 Q:'$O(INP(0))   ; nothing to audit
 N RCI,RCNOW
 S RCNOW=$$NOW^XLFDT
 S RCI=0 F  S RCI=$O(INP(RCI)) Q:'RCI  D
 . N FDAUDT,X S X=INP(RCI)
 . S FDAUDT(344.7,"+1,",.01)=RCNOW  ;TIMESTAMP [1D]
 . S FDAUDT(344.7,"+1,",.02)=$P(X,U,3)  ;MODIFIED IEN [2N]
 . S FDAUDT(344.7,"+1,",.03)=DUZ  ;CHANGED BY [3P:200]
 . S FDAUDT(344.7,"+1,",.04)=$P(X,U,2)  ;CHANGED FIELD [4N]
 . S FDAUDT(344.7,"+1,",.05)=$P(X,U)  ;MODIFIED FILE [5S]
 . S FDAUDT(344.7,"+1,",.06)=$P(X,U,4)  ;NEW VALUE [6F]
 . S FDAUDT(344.7,"+1,",.07)=$P(X,U,5)  ;OLD VALUE [7F]
 . S FDAUDT(344.7,"+1,",.08)=$P(X,U,6)  ;COMMENT [8F]
 . D UPDATE^DIE(,"FDAUDT")
 Q
 ;
 ; CALLS RELATED TO CREATING EPAYMENT PAYER EXCLUSION PARAMETERS
 ;
NEWPYR ;Add new payers to payer table - called from AR Nightly Job (EN^RCDPEM)
 ; PRCA*4.5*326 - Add payers that are just on EFTs to file 344.6
 N RCDATE,RCFDA,RCEFT,RCERA,RCUPD,RCXD
 ;Get date/time of last run otherwise start at previous day
 S RCDATE=$P($G(^RCY(344.61,1,0)),U,8) S:RCDATE="" RCDATE=$$FMADD^XLFDT($$NOW^XLFDT\1,-1)
 S RCXD=RCDATE
 F  S RCXD=$O(^RCY(344.4,"AFD",RCXD)) Q:'RCXD  D
 . S RCERA="" F  S RCERA=$O(^RCY(344.4,"AFD",RCXD,RCERA)) Q:'RCERA  D  ;
 . . S RCUPD=$$PAYRINIT(RCERA,344.4)
 ;
 S RCXD=$$FMADD^XLFDT($P(RCDATE,".",1),-1)
 F  S RCXD=$O(^RCY(344.31,"ADR",RCXD)) Q:'RCXD  D
 . S RCEFT="" F  S RCEFT=$O(^RCY(344.31,"ADR",RCXD,RCEFT)) Q:'RCEFT  D  ;
 . . S RCUPD=$$PAYRINIT(RCEFT,344.31)
 ;
 ;Update last run date
 S RCFDA(344.61,"1,",.08)=$$NOW^XLFDT()
 D FILE^DIE("","RCFDA")
 ; PRCA*4.5*326 - End modified block
 Q
 ;
PAYERPRM(IEN,EXMDPOST,EXMDDECR) ; update new payer
 Q:'$G(IEN)!('$D(^RCY(344.4,+$G(IEN),0))) 0  ; IEN valid?
 N ID,PAYER,PFDA,PIENS
 S PAYER=$E($$GET1^DIQ(344.4,IEN_",",.06),1,35)
 Q:PAYER="" 0
 S ID=$E($$GET1^DIQ(344.4,IEN_",",.03),1,30)
 I '$D(^RCY(344.6,"CPID",PAYER,ID)) Q 0
 ; FILE CURRENT SETTINGS
 S PIENS=$O(^RCY(344.6,"CPID",PAYER,ID,0))_","
 S PFDA(344.6,PIENS,.04)=DUZ
 S PFDA(344.6,PIENS,.05)=$$NOW^XLFDT
 S PFDA(344.6,PIENS,.06)=+$G(EXMDPOST)
 S PFDA(344.6,PIENS,.07)=+$G(EXMDDECR)
 D FILE^DIE(,"PFDA")
 Q 1
 ;
PAYRINIT(IEN,FILE) ; Add Payer Name and Payer ID to Payer table #344.6 
 ;
 N PFDA,PAYER,ID,PIENS,ERADATE,RCFLD
 ;
 Q:'$G(IEN)!('$D(^RCY(FILE,+$G(IEN)))) 0
 ; PRCA*4.5*326 - Add payers from EFTs
 S RCFLD("NAME")=$S(FILE=344.4:.06,1:.02)
 S RCFLD("ID")=.03
 S RCFLD("DATE")=$S(FILE=344.4:.07,1:.13)
 ;
 S PAYER=$$GET1^DIQ(FILE,IEN_",",RCFLD("NAME")) Q:PAYER="" 0
 S ID=$$GET1^DIQ(FILE,IEN_",",RCFLD("ID")) Q:ID="" 0
 I $D(^RCY(344.6,"CPID",PAYER,ID)) Q 1
 S ERADATE=$$GET1^DIQ(FILE,IEN_",",RCFLD("DATE"),"I")
 ; PRCA*4.5*326 - End modified block
 ;
 ; UPDATE PAYER PARAMETERS
 S PIENS="+1,"
 S PFDA(344.6,PIENS,.01)=PAYER
 S PFDA(344.6,PIENS,.02)=ID
 S PFDA(344.6,PIENS,.03)=ERADATE
 S PFDA(344.6,PIENS,.04)=.5
 S PFDA(344.6,PIENS,.05)=$$NOW^XLFDT
 S PFDA(344.6,PIENS,.06)=0
 S PFDA(344.6,PIENS,.07)=0
 I FILE=344.31 S PFDA(344.6,PIENS,.11)=1 ; PRCA*4.5*326
 D UPDATE^DIE(,"PFDA")
 Q 1
