RCDPESP ;BIRM/EWL - ePayment Lockbox Site Parameters Definition - Files 344.61 & 344.6 ;27 Sept 2018 15:56:10
 ;;4.5;Accounts Receivable;**298,304,318,321,326,332**;Mar 20, 1995;Build 40
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; entry point for EDI Lockbox Parameters [RCDPE EDI LOCKBOX PARAMETERS]
 N DA,DIC,DIE,DIR,DIRUT,DLAYGO,DR,DTOUT,DUOUT,X,Y  ; FileMan variables
 ;
 W !," Update AR Site Parameters",!
 ;
 S X="RCDPE AUTO DEC" I '$D(^XUSEC(X,DUZ)) W !!,"You do not hold the "_X_" security key." Q
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
 ; function returns 1 on success
 S Y=$$EDILOCK^RCMSITE  ; Update EDI Lockbox site parameters
 I 'Y G ABORT  ; user entered '^'
 ;
 ; PRCA*4.5*304 - Enable/disable auto-auditing of paper bills
 S RCQUIT=0 W !
 S RCQUIT=$$AUDIT^RCDPESP5
 I RCQUIT G ABORT ; PRCA*4.5*326 must have single exit point
 ;
 W !
 I '$D(^RCY(344.61,1,0)) W !,"There is a problem with the RCDPE PARAMETER file (#344.61)." G EXIT
 ;
 ; PRCA*4.5*321
 ; WORKLOAD NOTIFICATION BULLETIN DAYS
 N BULL S BULL=$$GET1^DIQ(344.61,"1,",.1,"I")
 K DIR S:BULL]"" DIR("B")=$$GET1^DIQ(344.61,"1,",.1,"E")
 S DIR("?")=$$GET1^DID(344.61,.1,,"HELP-PROMPT")
 S DIR("A")=$$GET1^DID(344.61,.1,,"TITLE")
 S DIR(0)="344.61,.1"
 D ^DIR I $D(DTOUT)!$D(DUOUT) G ABORT
 I BULL'=Y D  ; update and audit
 . S RCAUDVAL(1)="344.61^.1^1^"_Y_U_BULL
 . S FDAEDI(344.61,"1,",.1)=Y D FILE^DIE(,"FDAEDI")
 . D AUDIT(.RCAUDVAL) K RCAUDVAL
 W !
 ;
 ; Enable/disable auto-posting of medical claims
 N APMC,APMCT
 ;PRCA*4.5*304 Move from Medical Auto decrease section below
 N ADMC  ; ^DD(344.61,.02,0)="AUTO-POST MED CLAIMS ENABLED^S^0:No;1:Yes;^0;2^Q"
 S ADMC=""  ; Init in case Medical Auto Posting is turned off.
 ;end PRCA*4.5*304
 ; APMC=AUTO POSTING OF MEDICAL CLAIMS ENABLED
 ; APMCT=TEMP APMC
 S APMCT=$$GET1^DIQ(344.61,"1,",.02,"I"),APMC=$S(APMCT=1:"Yes",APMCT=0:"No",1:"")
 K DIR S DIR(0)="YA",DIR("B")=$S(APMC="":"Y",1:APMC)
 S DIR("A")=$$GET1^DID(344.61,.02,,"TITLE")
 S DIR("?")=$$GET1^DID(344.61,.02,,"HELP-PROMPT")
 D ^DIR I $D(DTOUT)!$D(DUOUT) G ABORT
 I APMCT'=Y D  ; user updated value
 .S FDAEDI(344.61,"1,",.02)=Y D FILE^DIE(,"FDAEDI") K FDAEDI
 .D NOTIFY($S(Y=1:"Yes",Y=0:"No",1:"*missing*"))
 .S RCAUDVAL(1)="344.61^.02^1^"_Y_U_('Y) D AUDIT(.RCAUDVAL) K RCAUDVAL
 ;
 I Y=0 G RXPARMS
 ;
 ; Set/Reset payer exclusions for medical claim posting
 D EXCLLIST(1) ; Display the exclusion list
 D SETEXCL(1) I $G(RCQUIT) G ABORT ; SET/RESET exclusions
 D EXCLLIST(1) ; Display the exclusion list
 W !
 ;
 ; Enable/disable auto-decrease of paid medical claims
 N RETURN
 S RETURN=$$PAID^RCDPESP7
 G:RETURN=2 RXPARMS
 ;
 ; Enable/disable auto-decrease of non-paid medical claims
 I RETURN=0 S RETURN=$$NOPAY^RCDPESP7
 ;
 I RETURN=1 G ABORT
 ;
 ; Set/Reset payer exclusions for medical claim decrease
 D EXCLLIST(2) ; Display the exclusion list
 D SETEXCL(2) I $G(RCQUIT) G ABORT ; SET/RESET exclusions
 D EXCLLIST(2) ; Display the exclusion list
 W !
 ;
 ; code falls through
 ;
RXPARMS ; branch here from above
 ;
 ; Enable/disable auto-posting of pharmacy claims
 N APPC,APPCT
 ; APPC=AUTO POSTING OF PHARMACY CLAIMS ENABLED
 ; APPCT=TEMP APMC
 S APPCT=$$GET1^DIQ(344.61,"1,",1.01,"I"),APPC=$S(APPCT=1:"Yes",APPCT=0:"No",1:"")
 K DIR S DIR(0)="YA",DIR("B")=$S(APPC="":"Yes",1:APPC)
 S DIR("A")=$$GET1^DID(344.61,1.01,,"TITLE")
 S DIR("?")=$$GET1^DID(344.61,1.01,,"HELP-PROMPT")
 D ^DIR I $D(DTOUT)!$D(DUOUT) G ABORT
 I APPCT'=Y D  ; user updated value
 . S FDAEDI(344.61,"1,",1.01)=Y D FILE^DIE(,"FDAEDI") K FDAEDI
 . D NOTIFY($S(Y=1:"Yes",Y=0:"No",1:"*missing*"),1)
 . S RCAUDVAL(1)="344.61^1.01^1^"_Y_U_('Y) D AUDIT(.RCAUDVAL) K RCAUDVAL
 ;
 ; If yes, set/Reset payer exclusions for pharmacy claims posting
 I Y=1 D  G:$G(RCQUIT)=1 ABORT
 . D EXCLLIST(3) ; Display the exclusion list
 . D SETEXCL(3) Q:$G(RCQUIT)  ; SET/RESET exclusions
 . D EXCLLIST(3) ; Display the exclusion list
 . W !
 ;
 ; Show Pharmacy prompt but don't allow change
 D:$$GET1^DIQ(344.61,"1,",1.01,"I")=1  G:$G(RCQUIT)=1 ABORT
 . W !,"ENABLE AUTO-DECREASE OF PHARMACY CLAIMS (Y/N): NO//"
 . W !,"   Determines if auto-decrease of pharmacy claims are enabled for this site."
 . W !,"   NOTE:  Not editable and set to Disabled until further notice.",!
 . K DIR S DIR(0)="EA"
 . S DIR("A")="Press Enter to continue: "
 . D ^DIR I $D(DTOUT)!$D(DUOUT) S RCQUIT=1
 . W !
 ;
 ; ^DD(344.61,.06,0) = MEDICAL EFT POST PREVENT DAYS
 N MEO S MEO=$$GET1^DIQ(344.61,"1,",.06)
 K DIR S:MEO]"" DIR("B")=MEO
 S DIR("?")=$$GET1^DID(344.61,.06,,"HELP-PROMPT")
 S DIR(0)="NA^14:60:0",DIR("A")=$$GET1^DID(344.61,.06,,"TITLE") ; PRCA*4.5*321 Change max from 99 to 60
 D ^DIR I $D(DTOUT)!$D(DUOUT) G ABORT
 I MEO'=Y D  ; update and audit
 . S RCAUDVAL(1)="344.61^.06^1^"_Y_U_MEO
 . S FDAEDI(344.61,"1,",.06)=Y D FILE^DIE(,"FDAEDI")
 . D AUDIT(.RCAUDVAL) K RCAUDVAL
 ;
 ; (#.07) PHARMACY EFT POST PREVENT DAYS [7N]
 N PEO S PEO=$$GET1^DIQ(344.61,"1,",.07)
 K DIR S:PEO]"" DIR("B")=PEO
 S DIR("?")=$$GET1^DID(344.61,.07,,"HELP-PROMPT")
 S DIR(0)="NA^21:99:0",DIR("A")=$$GET1^DID(344.61,.07,,"TITLE") ; PRCA*4.5*332 Change max from 365 TO 99
 D ^DIR I $D(DTOUT)!$D(DUOUT) G ABORT
 I PEO'=Y D  ; update and audit
 . S RCAUDVAL(1)="344.61^.07^1^"_Y_U_PEO
 . S FDAEDI(344.61,"1,",.07)=Y D FILE^DIE(,"FDAEDI")
 . D AUDIT(.RCAUDVAL) K RCAUDVAL
 ;
 ; (#.13) TRICARE EFT POST PREVENT DAYS [13N] - PRCA*4.5*332
 N PEO S PEO=$$GET1^DIQ(344.61,"1,",.13)
 K DIR
 S:PEO]"" DIR("B")=PEO
 S DIR("?")=$$GET1^DID(344.61,.13,,"HELP-PROMPT")
 S DIR(0)="NA^14:60:0",DIR("A")=$$GET1^DID(344.61,.13,,"TITLE")_" "
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) D ABORT Q
 I PEO'=Y D  ; Update and audit
 . S RCAUDVAL(1)="344.61^.13^1^"_Y_U_PEO
 . S FDAEDI(344.61,"1,",.13)=Y D FILE^DIE(,"FDAEDI")
 . D AUDIT(.RCAUDVAL) K RCAUDVAL
 ;
 G EXIT
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
PAUSE ; prompt user to press return
 W ! N DIR
 S DIR("T")=3,DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR
 Q
 ;
COUNT(TYPE) ; Count active CARCs in file 344.62 (RCDPE CARC-RARC AUTO DEC)
 N NUM,I
 I (TYPE'=1)&(TYPE'=0) Q 0  ; If TYPE is not active (1) or in-active (0) quit with count = 0
 S NUM=0
 S I="" F  S I=$O(^RCY(344.62,"ACTV",TYPE,I)) Q:I=""  S NUM=NUM+1
 Q NUM
 ;
EXCLLIST(TYP) ; CHOICE determines which exclusions to list
 ; TYP - TYPE OF EXLUSION - REQUIRED
 ; IX - which index to use
 ; IEN - points to an excluded payer for the selected choice
 Q:'("^1^2^3^"[(U_$G(TYP)_U))  ; one or two only
 N IX,IEN,CT,LIST S (IEN,CT)=0 W !
 S IX=$S(TYP=1:"EXMDPOST",TYP=2:"EXMDDECR",TYP=3:"EXRXPOST",1:"") ;,TYP=4:"EXRXDECR",1:"")
 S LIST=$S(TYP=1:"",TYP=3:"",1:"** Additional ")_"Payers excluded from "_$S(TYP=1:"Medical Auto-Posting:",TYP=3:"Pharmacy Auto-Posting",1:"Medical Auto-Decrease:")
 F  S IEN=$O(^RCY(344.6,IX,1,IEN)) Q:'IEN  D
 . S CT=CT+1
 . W:CT=1 !,LIST
 . W !,"  "_$P(^RCY(344.6,IEN,0),U,1)_" "_$P(^RCY(344.6,IEN,0),U,2)
 ;
 I TYP=2 W !,"All payers excluded from Auto-Posting are also excluded from Auto-Decrease."
 W:CT=0 !,"   No "_$S(TYP=2:"additional ",1:"")_"payers excluded from "_$S(TYP=1:"Medical Auto-Posting:",TYP=3:"Pharmacy Auto-Posting",1:"Medical Auto-Decrease:")
 ; if list is for auto-decrease and there are exclusions write a message
 Q
 ;
SETEXCL(TYP) ; LOOP FOR SETTING PAYER EXCLUSIONS
 ; TYP - TYPE OF EXLUSION - REQUIRED
 N CMT,CT,DIC,DIR,DONE,FDAPAYER,FLD,IEN,PREC,RCAUDVAL,RTYP,X,Y
 ; FDAPAYER - FDA FOR FILE 344.6
 ; FLD - FIELD BEING MODIFIED
 ; RTYP - STRING REPRESENTING FIELD
 ; DONE - INDICATOR TO LEAVE LOOP
 ; RCAUDVAL - ARRAY FOR AUDITING
 ; PREC - HOLDER FOR Y(0) AFTER ^DIC CALL
 ;         FILE NUMBER^FIELD NUMBER^IEN^NEW VALUE^OLD VALUE,COMMENT
 I $G(TYP)=1 S FLD=.06,CMT=1,RTYP="MEDICAL CLAIMS POSTING"
 I $G(TYP)=2 S FLD=.07,CMT=2,RTYP="MEDICAL CLAIMS DECREASE"
 I $G(TYP)=3 S FLD=.08,CMT=3,RTYP="PHARMACY CLAIMS POSTING"
 I '$D(FLD) Q 
 ;
 W !!,"Select a Payer to add or remove from the exclusion list.",!
 S (RCQUIT,CT,DONE)=0 F  Q:DONE!RCQUIT  D
 . S DIC="^RCY(344.6,",DIC(0)="AEMQZ",DIC("A")="Payer: " D ^DIC I X="^" S RCQUIT=1 Q
 . I +$G(Y)<1 S DONE=1 Q
 . S CT=CT+1,IEN=+Y,IENS=IEN_",",PREC=Y(0)
 . K FDAPAYER
 . N COMMENT,STAT
 . S COMMENT="",STAT='$$GET1^DIQ(344.6,IENS,FLD,"I")
 . S FDAPAYER(344.6,IENS,FLD)=STAT
 . ; GET COMMENT HERE
 . K Y S DIR("A")="COMMENT: ",DIR(0)="FA^3:72"
 . S DIR("PRE")="S X=$$TRIM^XLFSTR(X,""LR"")" ; comment required and should be significant
 . S DIR("?")="Enter an explanation for "_$S(STAT:"adding the payer to",1:"removing the payer from")_" the list of Excluded Payers."
 . D ^DIR I $D(DTOUT)!$D(DUOUT)!(Y="") S RCQUIT=1 Q
 . S COMMENT=Y
 . I COMMENT]"" D
 ..  S FDAPAYER(344.6,IENS,CMT)=$S(STAT:COMMENT,1:"")
 ..  W !,$P(PREC,U)_" "_$P(PREC,U,2)_" has been "
 ..  W $S(STAT:"added to",1:"removed from")_" the list of Excluded Payers"
 ..  I TYP=1 D
 ...   W !,"If medical auto-decrease is turned on, "
 ...   I STAT W "this payer will be excluded from medical auto-decrease too."
 ...   I 'STAT,'$$GET1^DIQ(344.6,IEN_",",.07,"I") W "this payer will no longer be excluded from Medical Auto-Decrease."
 ...   I 'STAT,$$GET1^DIQ(344.6,IEN_",",.07,"I") W "Medical Auto-Decrease is set to be excluded for this payer."
 ..  K RCAUDVAL
 ..  D FILE^DIE(,"FDAPAYER")
 ..  S RCAUDVAL(1)="344.6"_U_FLD_U_IEN_U_STAT_U_('STAT)_U_COMMENT
 ..  D AUDIT(.RCAUDVAL) K RCAUDVAL
 Q
 ;
NOTIFY(VAL,TYPE) ; Notify CBO team of change to Site Parameters
 N GLB,GLO,MSG,SITE,SUBJ,XMINSTR,XMTO
 S SITE=$$SITE^VASITE
 S TYPE=+$G(TYPE)  ;init optional parameter
 ; limit subject to 65 chars.
 S SUBJ=$E("Site Parameter edit, Station #"_$P(SITE,U,3)_" - "_$P(SITE,U,2),1,65)
 S MSG(1)=" "
 S MSG(2)="        Site: "_$P(SITE,U,2)
 S MSG(3)="   Station #: "_$P(SITE,U,3)
 S MSG(4)="      Domain: "_$G(^XMB("NETNAME"))
 S MSG(5)="   Date/Time: "_$$FMTE^XLFDT($$NOW^XLFDT,"5ZPM")
 S MSG(6)="  Changed by: "_$P($G(^VA(200,DUZ,0)),U)
 S MSG(7)=" "
 S MSG(8)="  ENABLE AUTO-POSTING OF "_$S(TYPE=1:"PHARMACY",1:"MEDICAL")_" CLAIMS = "_VAL
 S MSG(9)=" "
 ;Copy message to ePayments CBO team
 S XMTO(DUZ)=""
 ; S:$$PROD^XUPROD XMTO("VHAEPAYMENTS@domain.ext")="" ; PRCA*4.5*326 autopost on/off message no longer required by ePay
 ;
 K ^TMP("XMERR",$J)
 D SENDMSG^XMXAPI(DUZ,SUBJ,"MSG",.XMTO,.XMINSTR)
 ;
 I $D(^TMP("XMERR",$J)) D
 .D MES^XPDUTL("MailMan reported a problem trying to send the notification message.")
 .D MES^XPDUTL("  ")
 .S (GLO,GLB)="^TMP(""XMERR"","_$J
 .S GLO=GLO_")"
 .F  S GLO=$Q(@GLO) Q:GLO'[GLB  D MES^XPDUTL("   "_GLO_" = "_$G(@GLO))
 .D MES^XPDUTL("  ")
 Q
 ;
AUDIT(INP) ; WRITE AUDIT RECORD(S)
 ; INP = audit value in this format:
 ;       FILE NUMBER^FIELD NUMBER^IEN^NEW VALUE^OLD VALUE^COMMENT
 Q:'$O(INP(0))   ; nothing to audit
 N FDAUDT  ; FileMan FDA array for audits
 N IDX S IDX=0
 F  S IDX=$O(INP(IDX)) Q:'IDX  D
 . K FDAUDT
 . S FDAUDT(344.7,"+1,",.01)=$$NOW^XLFDT
 . S FDAUDT(344.7,"+1,",.02)=$P(INP(IDX),U,3) ; IEN
 . S FDAUDT(344.7,"+1,",.03)=DUZ  ; user
 . S FDAUDT(344.7,"+1,",.04)=$P(INP(IDX),U,2) ; FIELD NUMBER
 . S FDAUDT(344.7,"+1,",.05)=$P(INP(IDX),U,1) ; FILE NUMBER
 . S FDAUDT(344.7,"+1,",.06)=$P(INP(IDX),U,4) ; NEW VALUE
 . S FDAUDT(344.7,"+1,",.07)=$P(INP(IDX),U,5) ; OLD VALUE
 . S FDAUDT(344.7,"+1,",.08)=$P(INP(IDX),U,6) ; COMMENT
 . D UPDATE^DIE(,"FDAUDT")
 Q
 ;
 ; *************************************************************
 ; CALLS RELATED TO CREATING EPAYMENT PAYER EXCLUSION PARAMETERS
 ; *************************************************************
 ;
NEWPYR ;Add new payers to payer table - called from AR Nightly Job (EN^RCDPEM)
 N RCDATE,RCERA,RCUPD
 ;Get date/time of last run otherwise start at previous day
 S RCDATE=$P($G(^RCY(344.61,1,0)),U,8) S:RCDATE="" RCDATE=$$FMADD^XLFDT($$NOW^XLFDT\1,-1)
 F  S RCDATE=$O(^RCY(344.4,"AFD",RCDATE)) Q:'RCDATE  D
 .S RCERA="" F  S RCERA=$O(^RCY(344.4,"AFD",RCDATE,RCERA)) Q:'RCERA  S RCUPD=$$PAYRINIT(RCERA)
 ;Update last run date
 S $P(^RCY(344.61,1,0),U,8)=$$NOW^XLFDT
 Q
 ;
PAYERPRM(IEN,EXMDPOST,EXMDDECR) ; USED TO UPDATE A NEW PAYER
 ; CHECK IEN FOR VALID INPUT
 Q:'$G(IEN)!('$D(^RCY(344.4,+$G(IEN),0))) 0
 N PFDA,PAYER,ID,CPAYERID,PIENS
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
PAYRINIT(IEN) ; Add Payer Name and Payer ID to Payer table #344.6 
 ;
 N PFDA,PAYER,ID,PIENS,ERADATE
 ;
 Q:'$G(IEN)!('$D(^RCY(344.4,+$G(IEN)))) 0
 S PAYER=$P($G(^RCY(344.4,IEN,0)),U,6) Q:PAYER="" 0
 S ID=$P($G(^RCY(344.4,IEN,0)),U,3) Q:ID="" 0
 I $D(^RCY(344.6,"CPID",PAYER,ID)) Q 1
 S ERADATE=$P($G(^RCY(344.4,IEN,0)),U,7)
 ; UPDATE PAYER PARAMETERS
 S PIENS="+1,"
 S PFDA(344.6,PIENS,.01)=PAYER
 S PFDA(344.6,PIENS,.02)=ID
 S PFDA(344.6,PIENS,.03)=ERADATE
 S PFDA(344.6,PIENS,.04)=.5
 S PFDA(344.6,PIENS,.05)=$$NOW^XLFDT
 S PFDA(344.6,PIENS,.06)=0
 S PFDA(344.6,PIENS,.07)=0
 D UPDATE^DIE(,"PFDA")
 Q 1
 ;
