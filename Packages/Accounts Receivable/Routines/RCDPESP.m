RCDPESP ;BIRM/EWL - ePayment Lockbox Site Parameters Definition - Files 344.61 & 344.6 ;Nov 19, 2014@15:26:16
 ;;4.5;Accounts Receivable;**298**;Nov 11, 2013;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; entry point for EDI Lockbox Parameters [RCDPE EDI LOCKBOX PARAMETERS]
 N DA,DIC,DIE,DIR,DIRUT,DLAYGO,DR,DUOUT,X,Y  ; FileMan variables
 ;
 W !," Update AR Site Parameters",!
 ;
 S X="RCDPE AUTO DEC" I '$D(^XUSEC(X,DUZ)) W !!,"You do not hold the "_X_" security key." Q
 ; Lock the parameter file
 L +^RCY(344.61,1):DILOCKTM E  D  Q
 .W !!," Another user is currently using the AR Site Parameters option."
 .W !," Please try again later."
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
 S RCQUIT=0 W !
 I '$D(^RCY(344.61,1,0)) W !,"There is a problem with the RCDPE PARAMETER file (#344.61)." G EXIT
 ;
 ;----------------------------------------------
 ; Enable/disable auto-posting of medical claims
 ;----------------------------------------------
 N APMC,APMCT
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
 ; Enable/disable auto-decrease of medical claims
 N ADMC  ; ^DD(344.61,.03,0)="AUTO-DECREASE MED ENABLED^S^0:No;1:Yes;^0;3^Q"
 K FDAEDI  ; used for FILE^DIE call
 S ADMC=$$GET1^DIQ(344.61,"1,",.03,"I")  ; get current value
 K DIR S DIR(0)="YA",DIR("B")=$S(ADMC=""!(ADMC=1):"Yes",1:"No")
 S DIR("A")=$$GET1^DID(344.61,.03,,"TITLE")
 S DIR("?")=$$GET1^DID(344.61,.03,,"HELP-PROMPT")
 D ^DIR I $D(DTOUT)!$D(DUOUT) G ABORT
 ; if user changed value, update and audit
 S:ADMC'=Y FDAEDI(344.61,"1,",.03)=Y,RCAUDVAL(1)="344.61^.03^1^"_Y_U_ADMC
 I Y=0 D  G RXPARMS  ; value set to No, update (if needed), go to Pharmacy params.
 . D:$D(FDAEDI) FILE^DIE(,"FDAEDI"),AUDIT(.RCAUDVAL) K RCAUDVAL
 ;
 ; Set number of days to wait before auto-decrease amount
 N ADMT ; ^DD(344.61,.04,0) = AUTO-DECREASE MED DAYS DEFAULT
 S ADMT=$$GET1^DIQ(344.61,"1,",.04)
 K DIR S:ADMT]"" DIR("B")=ADMT
 S (DIR("?"),DIR("??"))=$$GET1^DID(344.61,.04,,"HELP-PROMPT")
 S DIR(0)="NA^0:7:0",DIR("A")=$$GET1^DID(344.61,.04,,"TITLE")
 D ^DIR I $D(DTOUT)!$D(DUOUT) G ABORT
 S:ADMT'=Y FDAEDI(344.61,"1,",.04)=Y,RCAUDVAL(2)="344.61^.04^1^"_Y_U_ADMT
 ;
 ; Set maximum amount for auto-decrease amount
 N ADMA ; ^DD(344.61,.05,0)= AUTO-DECREASE MED AMT DEFAULT
 S ADMA=$$GET1^DIQ(344.61,"1,",.05)
 K DIR S:ADMA]"" DIR("B")=ADMA
 S DIR("?")=$$GET1^DID(344.61,.05,,"HELP-PROMPT")
 S DIR(0)="NA^1:1500:0",DIR("A")=$$GET1^DID(344.61,.05,,"TITLE")
 D ^DIR I $D(DTOUT)!$D(DUOUT) G ABORT
 S:ADMA'=Y FDAEDI(344.61,"1,",.05)=Y,RCAUDVAL(3)="344.61^.05^1^"_Y_U_ADMA
 D FILE^DIE(,"FDAEDI")
 D:$D(RCAUDVAL) AUDIT(.RCAUDVAL)
 K RCAUDVAL
 ;
 ; Set/Reset payer exclusions for medical claim decrease
 D EXCLLIST(2) ; Display the exclusion list
 D SETEXCL(2) I $G(RCQUIT) G ABORT ; SET/RESET exclusions
 D EXCLLIST(2) ; Display the exclusion list
 ; code falls through
 ;
RXPARMS ; branch here from above
 ;------------------------
 ; Dummy code for Pharmacy
 ;------------------------
 W !!,"* ENABLE AUTO-POSTING OF PHARMACY CLAIMS(Y/N): N *",!
 ;
 ; set MEDICAL EFT OVERRIDE ^DD(344.61,.06,0) = MEDICAL EFT POST PREVENT DAYS
 N MEO S MEO=$$GET1^DIQ(344.61,"1,",.06)
 K DIR S:MEO]"" DIR("B")=MEO
 S DIR("?")=$$GET1^DID(344.61,.06,,"HELP-PROMPT")
 S DIR(0)="NA^14:99:0",DIR("A")=$$GET1^DID(344.61,.06,,"TITLE")
 D ^DIR I $D(DTOUT)!$D(DUOUT) G ABORT
 I MEO'=Y D  ; update and audit
 .S RCAUDVAL(1)="344.61^.06^1^"_Y_U_MEO
 .S FDAEDI(344.61,"1,",.06)=Y D FILE^DIE(,"FDAEDI")
 .D AUDIT(.RCAUDVAL) K RCAUDVAL
 ;
 ;----------------------------------------------
 ; Set PHARMACY EFT OVERRIDE
 ;----------------------------------------------
 N PEO S PEO=$$GET1^DIQ(344.61,"1,",.07)
 K DIR S:PEO]"" DIR("B")=PEO
 S DIR("?")=$$GET1^DID(344.61,.07,,"HELP-PROMPT")
 S DIR(0)="NA^21:999:0",DIR("A")=$$GET1^DID(344.61,.07,,"TITLE")
 D ^DIR I $D(DTOUT)!$D(DUOUT) G ABORT
 I PEO'=Y D  ; update and audit
 .S RCAUDVAL(1)="344.61^.07^1^"_Y_U_PEO
 .S FDAEDI(344.61,"1,",.07)=Y D FILE^DIE(,"FDAEDI")
 .D AUDIT(.RCAUDVAL) K RCAUDVAL
 ;
 G EXIT
 ;
ABORT ; Called when user enters a '^' or times out
 ; fall through to EXIT
 ;
EXIT ; unLOCK, ask user to press return, exit
 L -^RCY(344.61,1)
 D PAUSE
 Q
 ;
PAUSE ; prompt user to press return
 W ! N DIR
 S DIR("T")=3,DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR
 Q
 ;
EXCLLIST(TYP) ; CHOICE determines which exclusions to list
 ; TYP - TYPE OF EXLUSION - REQUIRED
 ; IX - which index to use
 ; IEN - points to an excluded payer for the selected choice
 Q:'("^1^2^"[(U_$G(TYP)_U))  ; one or two only
 N IX,IEN,CT,LIST S (IEN,CT)=0 W !
 S IX=$S(TYP=1:"EXMDPOST",TYP=2:"EXMDDECR",1:"") ;,TYP=3:"EXRXPOST",TYP=4:"EXRXDECR",1:"")
 S LIST="Payers excluded from "_$S(TYP=1:"Auto-Posting:",1:"Auto-Decrease:")
 F  S IEN=$O(^RCY(344.6,IX,1,IEN)) Q:'IEN  D
 . S CT=CT+1
 . W:CT=1 !,LIST
 . W !,"  "_$P(^RCY(344.6,IEN,0),U,1)_" "_$P(^RCY(344.6,IEN,0),U,2)
 ;
 W:CT=0 !,"No excluded payers for "_$S(TYP=1:"Auto-Posting.",1:"Auto-Decrease.")
 ; if list is for auto-decrease and there are exclusions write a message
 I TYP=2,CT W !,"All payers excluded from auto-posting are excluded from auto-decrease."
 Q
 ;
SETEXCL(TYP) ; LOOP FOR SETTING PAYER EXCLUSIONS
 ; TYP - TYPE OF EXLUSION - REQUIRED
 N FDAPAYER,IEN,DONE,CT,X,Y,FLD,RTYP,DIC,DIR,RCAUDVAL,PREC,CMT
 ; FDAPAYER - FDA FOR FILE 344.6
 ; FLD - FIELD BEING MODIFIED
 ; RTYP - STRING REPRESENTING FIELD
 ; DONE - INDICATOR TO LEAVE LOOP
 ; RCAUDVAL - ARRAY FOR AUDITING
 ; PREC - HOLDER FOR Y(0) AFTER ^DIC CALL
 ;         FILE NUMBER^FIELD NUMBER^IEN^NEW VALUE^OLD VALUE,COMMENT
 I $G(TYP)=1 S FLD=.06,CMT=1,RTYP="MEDICAL CLAIMS POSTING"
 I $G(TYP)=2 S FLD=.07,CMT=2,RTYP="MEDICAL CLAIMS DECREASE"
 I '$D(FLD) Q 
 ;
 W !!,"Select a Payer to add or remove from the exclusion list.",!
 S (RCQUIT,CT,DONE)=0 F  Q:DONE!RCQUIT  D
 . S DIC="^RCY(344.6,",DIC(0)="AEMQZ",DIC("A")="Payer: " D ^DIC I X="^" S RCQUIT=1 Q
 . I +$G(Y)<1 S DONE=1 Q
 . S CT=CT+1,IEN=+Y,IENS=IEN_",",PREC=Y(0)
 . K FDAPAYER
 . N COMMENT,STAT
 . S COMMENT=""
 . S STAT='$$GET1^DIQ(344.6,IENS,FLD,"I")
 . S FDAPAYER(344.6,IENS,FLD)=STAT
 . ; GET COMMENT HERE
 . K Y S DIR("A")="Comment: ",DIR(0)="FA^3:72"
 . S DIR("?")="Enter an explanation for "_$S(STAT:"adding the payer to",1:"removing the payer from")_" the list of Excluded Payers."
 . D ^DIR I $D(DTOUT)!$D(DUOUT)!(Y="") S RCQUIT=1 Q
 . S COMMENT=Y
 . I COMMENT]"" D
 . . I STAT S FDAPAYER(344.6,IENS,CMT)=COMMENT
 . . E  S FDAPAYER(344.6,IENS,CMT)=""
 . . W !,$P(PREC,U,1)_" "_$P(PREC,U,2)_" has been "
 . . W $S(STAT:"added to",1:"removed from")_" the list of Excluded Payers"
 . . I TYP=1 D
 . . . W !,"If auto-decrease is turned on, "
 . . . I STAT W "this payer will be excluded from auto-decrease too."
 . . . I 'STAT,'$$GET1^DIQ(344.6,IEN_",",.07,"I") W "this payer will no longer be excluded from auto-decrease."
 . . . I 'STAT,$$GET1^DIQ(344.6,IEN_",",.07,"I") W "auto-decrease is set to be excluded for this payer."
 . . K RCAUDVAL
 . . D FILE^DIE(,"FDAPAYER")
 . . S RCAUDVAL(1)="344.6"_U_FLD_U_IEN_U_STAT_U_('STAT)_U_COMMENT
 . . D AUDIT(.RCAUDVAL) K RCAUDVAL
 Q
 ;
NOTIFY(VAL) ; Notify CBO team of change to Site Parameters
 N GLB,GLO,MSG,SITE,SUBJ,XMINSTR,XMTO
 S SITE=$$SITE^VASITE
 ; limit subject to 65 chars.
 S SUBJ=$E("Site Parameter edit, Station #"_$P(SITE,U,3)_" - "_$P(SITE,U,2),1,65)
 S MSG(1)=" "
 S MSG(2)="        Site: "_$P(SITE,U,2)
 S MSG(3)="   Station #: "_$P(SITE,U,3)
 S MSG(4)="      Domain: "_$G(^XMB("NETNAME"))
 S MSG(5)="   Date/Time: "_$$FMTE^XLFDT($$NOW^XLFDT,"5ZPM")
 S MSG(6)="  Changed by: "_$P($G(^VA(200,DUZ,0)),U)
 S MSG(7)=" "
 S MSG(8)="  ENABLE AUTO-POSTING OF MEDICAL CLAIMS = "_VAL
 S MSG(9)=" "
 ;Copy message to ePayments CBO team
 S XMTO(DUZ)=""
 S:$$PROD^XUPROD XMTO("VHAEPAYMENTS@DOMAIN.EXT")=""
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
 Q:'$G(IEN)!('$D(^RCY(344.4,+$G(IEN)))) 0
 N PFDA,PAYER,ID,PIENS,ERADATE
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
