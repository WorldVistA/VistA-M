RCDPESR6 ;ALB/TMK/DWA - Server auto-update file 344.4 - EDI Lockbox ;8 Aug 2018 21:44:13
 ;;4.5;Accounts Receivable;**173,214,208,230,252,269,271,298,321,332**;Mar 20, 1995;Build 40
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Reference to $$VALECME^BPSUTIL2 supported by IA# 6139
 ;
UPD3444(RCRTOT) ; Add EOB detail to list in 344.41 for file 344.4 entry RCRTOT
 ; If passed by reference, RCRTOT is returned = "" if errors
 ;
 N DA,DD,DIC,DIK,DLAYGO,DO,DR,RC,RC1,RC2,RCCOM1,RCCOM2,RCCT,RCDPNM,RCEOB,RCNPI1,RCNPI2,X,Y,Z
 S RC=0 F  S RC=$O(^TMP($J,"RCDPEOB",RC)) Q:'RC  S RC1=$G(^(RC)),RC2=$G(^(RC,"EOB")),RCEOB=+RC2 D  Q:'RCRTOT
 . ; Update 344.41 with reference to this record if it doesn't already exist
 . I RCEOB>0 Q:$D(^RCY(344.4,RCRTOT,1,"AC",RCEOB,RC))
 . I RCEOB'>0,$S($P(RC1,U,2)'="":$D(^RCY(344.4,RCRTOT,1,"AD",$P(RC1,U,2),RC)),1:0) Q
 . ; Disregard ECME reject related EEOBs; ECME# can be 7 digits or 12 digits
 . I RCEOB'>0,'$P(RC2,U,2),$$VALECME^BPSUTIL2($P(RC1,U,2)),$$REJECT^IBNCPDPU($P(RC1,U,2),$P(RC1,U,3)) Q
 . ;
 . S DA(1)=RCRTOT,X=RC,DIC="^RCY(344.4,"_DA(1)_",1,",DIC(0)="L",DLAYGO=344.41
 . S DIC("DR")=$S($G(RCEOB)>0:".02////"_RCEOB,1:".05////"_$P(RC1,U,2)_";.07////1")
 . I $P(RC2,U,2)'="" S DIC("DR")=DIC("DR")_$S($L(DIC("DR")):";",1:"")_".03///"_$P(RC2,U,2) ; amt
 . I $P(RC2,U,3)'="" S DIC("DR")=DIC("DR")_$S($L(DIC("DR")):";",1:"")_".04////"_$P(RC2,U,3) ; ins co
 . I $P(RC2,U,4) S DIC("DR")=DIC("DR")_$S($L(DIC("DR")):";",1:"")_".14////1" ; reversal
 . I $P(RC2,U,5)'="" S DIC("DR")=DIC("DR")_$S($L(DIC("DR")):";",1:"")_".15////^S X=$E($P(RC2,U,5),1,30)" ; Patient name
 . ; Process Billing Prov NPI, Rendering/Servicing NPI & name
 . S (RCCOM1,RCCOM2)=""
 . S RCNPI1=$P(RC2,U,10),RCNPI2=$P(RC2,U,11)
 . I RCNPI1'="",'$$CHKDGT^XUSNPI(RCNPI1) S RCCOM1="The Billing Provider NPI received on the 835 ("_$E(RCNPI1,1,10)_") is not a valid format."
 . I RCNPI2'="",'$$CHKDGT^XUSNPI(RCNPI2) S RCCOM2="The "_$S($P(RC2,U,12)=1:"Rendering",1:"Servicing")_" NPI received on the 835 ("_$E(RCNPI2,1,10)_") is not a valid format."
 . I RCCOM1="" S DIC("DR")=DIC("DR")_";.18////^S X=$P(RC2,U,10)"  ;Billing Provider NPI
 . I RCCOM2="" S DIC("DR")=DIC("DR")_";.19////^S X=$P(RC2,U,11)"  ;Rendering Provider NPI
 . S RCDPNM=$P(RC2,U,13) I $P(RC2,U,14)]"" S RCDPNM=RCDPNM_$S(RCDPNM]"":",",1:"")_$P(RC2,U,14)
 . S DIC("DR")=DIC("DR")_";.2////^S X=$P(RC2,U,12);.21////^S X=RCDPNM"  ; Entity Type Qualifier ^ Last name,First Name
 . S DIC("DR")=DIC("DR")_";.22////^S X=RCCOM1;.23////^S X=RCCOM2"  ;Comment on Billing provider^comment on rendering/servicing provider NPI
 . I $$VALECME^BPSUTIL2($P(RC1,U,4)) D
 .. S DIC("DR")=DIC("DR")_";.24////^S X=$P(RC1,U,4)"  ;Add ECME number (if valid) PRCA*4.5*298
 . D FILE^DICN K DO,DD,DLAYGO,DIC,DIK
 . S RCCT=+Y
 . I RCCT<0 D  Q
 .. S DA=RCRTOT,DIK="^RCY(344.4," D ^DIK
 .. S RCRTOT=0
 . ; If there is no IB EOB record, store the raw data in 344.411
 . I RC1'>0!(RCEOB'>0) D
 .. N RCDATA,RCC,RCDA
 .. S RCC=2,RCDATA(1)=$G(^TMP($J,"RCDPEOB","HDR"))
 .. ; PRCA*4.5*321 - use RC in place of RCCT to allow for gaps in ERA sequence numbers (due to ECME rejects)
 .. S Z=0 F  S Z=$O(^TMP($J,"RCDPEOB",RC,Z)) Q:'Z  S RCC=RCC+1,RCDATA(RCC)=$G(^TMP($J,"RCDPEOB",RC,Z))
 .. S RCDA(1)=RCRTOT,RCDA=RCCT
 .. D WP^DIE(344.41,$$IENS^DILF(.RCDA),1,"A","RCDATA")
 Q
 ;
 ; PRCA*4.5*332 start - 8 August 2018
ERATOT(RC3445DA,RCERR) ;function, File ERA TOTAL rec in 344.4 from entry RC3445DA in 344.5
 ; RC3445DA = ien file 344.5
 ; Returns: NEW ien file 344.4
 ;          RCERR if passed by reference, with error text
 ;          RCERR(1)=duplicated message
 N LPXREF,RCDA,RCDUP,RCFORCE,RCRAW,RCTRACE,RCX,X,Y
 S (RCERR,RCDA)=""  ; returned values
 S RCRAW(0)=$G(^RCY(344.5,RC3445DA,2,1,0))
 S RCRAW("Type")=$P(RCRAW(0),U),RCTRACE=$P(RCRAW(0),U,8),RCRAW("InsID")=$P(RCRAW(0),U,7),RCRAW("Payer")=$P(RCRAW(0),U,6),RCRAW("Method")=$P(RCRAW(0),U,17)
 ; Need header record as first entry in field
 I RCRAW("Type")'["835ERA" S RCERR="No header record found in message.  An EEOB exception record was created" G ERATOTQ
 ;
 S RCRAW("Date")=$$FMDT^RCDPESR1($P(RCRAW(0),U,9)),RCRAW("Amount")=$J(($P(RCRAW(0),U,10)/100),0,2)
 ;Elec ERA's must have a trace # and an ins co id
 I RCTRACE=""!(RCRAW("InsID")="") S RCERR="Trace # or ins ID missing on ERA transaction.  An EEOB exception record was created." G ERATOTQ
 ; Make sure it's not already there
 S (RCDUP,LPXREF)=0
 F  S LPXREF=$O(^RCY(344.4,"ATRIDUP",$$UP^XLFSTR(RCTRACE),$$UP^XLFSTR(RCRAW("InsID")),LPXREF)) Q:'LPXREF  D  Q:RCDUP
 . S LPXREF(0)=$G(^RCY(344.4,LPXREF,0))
 . I $P(LPXREF(0),U,4)=RCRAW("Date"),+$P(LPXREF(0),U,5)=+RCRAW("Amount") S RCDUP=1
 ; If ERA has a receipt and is being filed from Duplicate ERA Worklist find a new
 ; unique trace number for this payer/amount/date and override duplicate check
 S RCFORCE=+$$GET1^DIQ(344.5,RC3445DA_",",.15,"I")  ;(#.15) DUPLICATE INDICATOR [15S]
 I RCFORCE D  ; create new trace #
 . N DPCNTR S X=$E(RCTRACE,1,45)_"-DUP"  ; 49 chars. max
 . ; start with null, then add numbers until it's unique
 . F DPCNTR="",1:1 Q:'$D(^RCY(344.4,"ATRIDUP",$$UP^XLFSTR(X_DPCNTR),$$UP^XLFSTR(RCRAW("InsID"))))
 . ; above: "ATRIDUP" x-ref is TRACE NUMBER & INSURANCE CO ID
 . S (RCTRACE,RCNEWTRC)=X_DPCNTR
 ;
 I '$G(RCFORCE),RCDUP,$P(LPXREF(0),U,8) D  G ERATOTQ ; Receipt already exists - no update
 . S RCERR="This is a duplicate ERA and has already been posted",RCERR(1)=-2
 ;
 I '$G(RCFORCE),RCDUP D  G ERATOTQ  ; duplicate found
 . S RCERR="DUP",RCERR(1)=$S($P(LPXREF(0),U,12)'=$P($G(^RCY(344.5,RC3445DA,0)),U,11):$P(LPXREF(0),U,12),1:-1) G ERATOTQ
 ;
 D  ; context for FileMan variables
 . N DA,DD,DIC,DIE,DIK,DLAYGO,DO,DR,X,Y
 . S RCX=$O(^RCY(344.4,$C(1)),-1)+1,X=0  ; create new IEN
 . ; loop until no entry found
 . F RCX=RCX:1 L +^RCY(344.4,RCX,0):1 D:$T  Q:X        ; PRCA*4.5*332 Fix duplicate number issue
 . . I $D(^RCY(344.4,RCX)) L -^RCY(344.4,RCX,0) Q      ; Lock first then check for existance
 . .  S X=RCX  ; new entry #
 . ; X from above will be new .01 field value
 . S DIC(0)="L",DIC="^RCY(344.4,",DLAYGO=344.4
 . S DIC("DR")=".02////"_RCTRACE_";.03////"_RCRAW("InsID")_";.04////"_RCRAW("Date")_";.05////"_RCRAW("Amount")_";.06////"_$P(RCRAW(0),U,6)_";.09////0;.12////"_$P($G(^RCY(344.5,RC3445DA,0)),U,11)_";.07////"_$$NOW^XLFDT()_";.1////1"
 . I RCRAW("Method")'="" S DIC("DR")=DIC("DR")_";.15////"_RCRAW("Method")
 . D FILE^DICN S RCDA=$S(Y<0:"",1:+Y)  ; new IEN in 344.4
 ; done filing, unlock
 L -^RCY(344.4,RCX,0)
 I 'RCDA D
 . S RCERR="An error was encountered that prevented the adding of an ERA totals record.  An EEOB exception record was created."
 ;
ERATOTQ ; GOTO here or fall through
 Q RCDA  ; return new IEN
 ; PRCA*4.5*332 end - 8 August 2018
 ;
UPDCON(RCRTOT) ; Add contact information to file 344.4 for an ERA
 N DIE,DA,DR,Z,Q,X,Y,A,TYPE
 S Z=$G(^TMP($J,"RCDPEOB","CONTACT"))
 Q:$TR($P(Z,U,3,9),U)=""
 S DA=RCRTOT,DIE="^RCY(344.4,",DR=""
 ;
 ; If old format do
 I +$P($G(^TMP($J,"RCDPEOB","HDR")),U,16)'>0 D
 . F Q=2:1:8 S DR=DR_$S(DR'="":";3.0",1:"3.0")_(Q-1)_"///"_$S($P(Z,U,Q)="":"@",1:"/"_$P(Z,U,Q))
 ;
 ; If new format (5010) do
 I +$P($G(^TMP($J,"RCDPEOB","HDR")),U,16)>0 D
 . N CNT S CNT=0
 . I $P(Z,U,2)'="" S DR="3.01////"_$P(Z,U,2)
 .I $P(Z,U,3)'="" S DR=DR_$S(DR'="":";3.02",1:"3.02")_"////"_$P(Z,U,3)_";3.03////TE",CNT=CNT+1
 .I $P(Z,U,4)'="" D
 ..S:CNT=1 DR=DR_$S(DR'="":";3.04",1:"3.04")_"////"_$P(Z,U,4)_";3.05////FX"
 ..S:CNT=0 DR=DR_$S(DR'="":";3.02",1:"3.02")_"////"_$P(Z,U,4)_";3.03////FX"
 ..S CNT=CNT+1
 .I $P(Z,U,5)'="" D
 ..S:CNT=2 DR=DR_$S(DR'="":";3.06",1:"3.06")_"////"_$P(Z,U,5)_";3.07////EM"
 ..S:CNT=1 DR=DR_$S(DR'="":";3.04",1:"3.04")_"////"_$P(Z,U,5)_";3.05////EM"
 ..S:CNT=0 DR=DR_$S(DR'="":";3.02",1:"3.02")_"////"_$P(Z,U,5)_";3.03////EM"
 . I $P(Z,U,6)'="" S DR=DR_$S(DR'="":";5.01",1:"5.01")_"////"_$P(Z,U,6)
 D ^DIE
 Q
 ;
UPDADJ(RCRTOT) ; Add ERA level adj data to file 344.4
 N Z,Z0,DA,DIC,DLAYGO,DR,X,Y,DO,DD
 ; Remove any already there
 S Z=0 F  S Z=$O(^RCY(344.4,RCRTOT,2,Z)) Q:'Z  S DA(1)=RCRTOT,DA=Z D ^DIK
 ;
 S Z=0 F  S Z=$O(^TMP($J,"RCDPEOB","ADJ",Z)) Q:'Z  S Z0=$G(^(Z)) D
 . S DIC(0)="L",X=$P(Z0,U,3)_" ",DA(1)=RCRTOT,DIC="^RCY(344.4,"_DA(1)_",2,",DIC("DR")=$S($P(Z0,U,2)'="":".02////"_$P(Z0,U,2),1:"")
 . S DIC("DR")=DIC("DR")_$S(DIC("DR")'="":";",1:"")_$S($P(Z0,U,4)'="":".03////"_$J(-$P(Z0,U,4)/100,"",2),1:"")
 . S DIC("DR")=DIC("DR")_$S(DIC("DR")'="":";",1:"")_$S($P(Z0,U,5)'="":".04////"_$P(Z0,U,5),1:""),DLAYGO=344.42
 . S:$O(^RCY(344.4,RCRTOT,2,"B",X,0)) X=""""_X_""""
 . D FILE^DICN K DIC,DO,DD
 Q
 ;
DUPREC(RCET,RCCT,RCSTAR,RCFILE,RCALLDUP,RCEOB,RCBILL,RCDUPEOB) ; Overflow from RCDPESR2
 S ^TMP("RCERR1",$J,RCCT)=" ",^TMP("RCERR1",$J,RCCT,1)=RCET_RCCT_RCSTAR
 S ^TMP("RCERR1",$J,RCCT,2)="(Warning): EEOB detail already filed for "_RCBILL_" - "_$S(RCALLDUP:"Duplicate not stored",1:"EEOB updated"),^TMP("RCERR1",$J,RCCT,3)=" " S:RCFILE=5 ^TMP("RCERR1",$J,RCCT,"*")=^TMP("RCERR1",$J,RCCT,2)
 I RCALLDUP S RCEOB="",RCDUPEOB=-1 Q
 S $P(^TMP($J,"RCDPEOB",RCCT,"EOB"),U)=RCEOB
 Q
 ;
