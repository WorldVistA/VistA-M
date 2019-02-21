RCDPUREC ;WISC/RFJ - receipt utilities ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**114,148,169,173,208,222,293,298,321,326**;Mar 20, 1995;Build 26
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
ADDRECT(TRANDATE,RCDEPTDA,PAYTYPDA) ;  add a receipt
 ;
 ;  if deposit or payment type is missing, do not add the receipt
 I 'RCDEPTDA!('PAYTYPDA) Q 0
 ;
 N DA,DATA,RCDPFLAG,RECEIPT,TYPE
 ;  if a receipt has already been added for this transmission date
 ;  and deposit number, do not add a new one
 S DA=0 F  S DA=$O(^RCY(344,"AD",+RCDEPTDA,DA)) Q:'DA  S DATA=$G(^RCY(344,DA,0)) I $P($P(DATA,"^",3),".")=TRANDATE,$P(DATA,"^",4)=PAYTYPDA S RCDPFLAG=1 Q
 I $G(RCDPFLAG) Q DA
 ;
 Q $$BLDRCPT(TRANDATE,RCDEPTDA,PAYTYPDA)
 ;
BLDRCPT(TRANDATE,RCDEPTDA,PAYTYPDA,RCDUZ) ; function, Build a receipt with/without deposit
 ; LAYGO new entry to AR BATCH PAYMENT file (#344)
 ; returns new IEN on success, else zero
 ;
 N GOTONE,RECEIPT,TYPE
 ; ATTMPT - count of attempts
 ; GOTONE - new receipt # flag
 S GOTONE=0
 ;  build unique receipt number for date
 S TYPE=$E($G(^RC(341.1,PAYTYPDA,0))) I TYPE="" S TYPE="Z"  ; ^RC(341.1,0) = AR EVENT TYPE
 I TYPE="C",$G(RCDEPTDA)["ERACHK" S RCDEPTDA=+RCDEPTDA,TYPE="E" ; ERA plus paper check EDI Lockbox receipt
 ;
 ; Accounts Receivable Nightly Process Background Job [PRCA NIGHTLY PROCESS]
 ; -----
 ;
 ;lockbox receipt in the form of L980901A0, do not include century
 F  D  Q:+GOTONE&$L(RECEIPT)  ; must be new and non-null
 .;find a unique receipt #
 .S RECEIPT=$$NEXT(TYPE_$E(TRANDATE,2,7))  ;get last two digits from 00 to ZZ 
 .I RECEIPT="" Q
 .I $D(^RCY(344,"B",RECEIPT)) Q  ; AR BATCH PAYMENT file (#344), RECEIPT # field (#.01)
 .I $D(^PRCA(433,"AF",RECEIPT)) Q  ; AR TRANSACTION file (#433), RECEIPT # field (#13)
 .S GOTONE=1
 ;
 ;
 L +^RCY(344,"B",RECEIPT):DILOCKTM E  Q 0 ; PRCA*4.5*298, if LOCK timeout return zero
 ;
 ; add entry to AR BATCH PAYMENT file (#344)
 N %,%DT,D0,DA,DD,DI,DIC,DIE,DLAYGO,DO,DQ,DR,X,Y
 S DIC="^RCY(344,",DIC(0)="L",DLAYGO=344
 ;  .02 = opened by                  .03 = date opened = transmission dt
 ;  .04 = type of payment            .06 = deposit ticket
 ;  .14 = status (set to 1:open)
 S DIC("DR")=".02////"_$S($G(RCDUZ):RCDUZ,1:DUZ) ; PRCA*4.5*326 Use RCDUZ passed in
 S DIC("DR")=DIC("DR")_";.03///"_TRANDATE_";.04////"_PAYTYPDA_$S(RCDEPTDA:";.06////"_RCDEPTDA,1:"")_";.14////1;"
 S X=RECEIPT
 D FILE^DICN
 L -^RCY(344,"B",RECEIPT)
 I Y>0 Q +Y  ; Y set by DICN, return new IEN
 Q 0  ; entry not created
 ;
 ;
NEXT(RECEIPT) ; function, get next 2 chars. in sequence 00 to ZZ for receipt
 ;
 ;  start with 00
 I '$D(^RCY(344,"B",RECEIPT_"00")),'$D(^RCY(344,"B",RECEIPT_"00A")) Q RECEIPT_"00"
 ;
 N DIGIT1,DIGIT2,LAST
 ;  get the last one used and increment by 1
 S LAST=$O(^RCY(344,"B",RECEIPT_"ZZ"),-1)  ;example L2980901ZZ
 S DIGIT1=$A($E(LAST,8)),DIGIT2=$A($E(LAST,9))
 ;  increment the ascii value of last digit
 S DIGIT2=DIGIT2+1
 ;  ascii 48=0, 57=9, 65=A, 90=Z
 I DIGIT2>57,DIGIT2<65 S DIGIT2=65 ;an A
 ;  digit2 above a Z, set digit2 to a 0 and increment digit 1
 I DIGIT2>90 S DIGIT2=48,DIGIT1=DIGIT1+1
 I DIGIT1>57,DIGIT1<65 S DIGIT1=65 ;an A
 ;  digit 1 is above a Z, reset and reuse the Z
 I DIGIT1>90 S DIGIT1=90,DIGIT2=90
 ;
 ; If Receipt # already on file get another one
 F  Q:'$D(^RCY(344,"B",RECEIPT_$C(DIGIT1)_$C(DIGIT2)))  D
 . S RECEIPT=$E(RECEIPT,1)_$E(1000001+$E(RECEIPT,2,7),2,7)
 ;
 Q RECEIPT_$C(DIGIT1)_$C(DIGIT2)
 ;
 ;
SELRECT(ADDNEW,RCDEPTDA) ;  select a receipt
 ;  if $g(addnew) allow adding a new receipt
 ;  if $g(rcdeptda) allow selection of receipts for the deposit only
 ;  if $g(addnew) and $g(rcdeptda) deposit number auto set for new receipt
 ;  returns -1 for timeout or ^, 0 for no selection, or ien of receipt
 N %,%Y,C,D0,DA,DI,DIC,DIE,DIK,DG,DLAYGO,DQ,DR,DTOUT,DUOUT,RCREFLUP,X,Y,RCDE,RCLB,RC1,RC2,RCREQ,RCY
 S DIC="^RCY(344,",DIC(0)="QEAM",DIC("A")="Select RECEIPT: "
 S DIC("W")="D DICW^RCDPUREC"
 ;  set screen to select receipts linked to deposit and to screen out
 ;  selection of EDI Lockbox-type receipts unless an EFT is associated
 ;  with the deposit and the receipt is not associated with an ERA
 S RCDE=+$O(^RCY(344.3,"ARDEP",+$G(RCDEPTDA),0))
 I $G(RCDEPTDA) D
 .   S DIC("S")="N Z S Z=$G(^(0)) I $S('$$EDILBEV^RCDPEU($P(Z,U,4)):'RCDE,1:RCDE&'$P(Z,U,18)),($P(Z,U,6)=""""!($P(Z,U,6)=RCDEPTDA))"
 .   S DIC("A")="Select RECEIPT (for deposit "_$P(^RCY(344.1,RCDEPTDA,0),"^")_"): "
 ;  use special lookup on input
 I '$G(RCDEPTDA) S RCREFLUP=1
 ;  add new entries
 S RC1="TYPE NOT VALID FOR THIS RECEIPT",RC2=">>AN EFT REFERENCE IS REQUIRED"
 I $G(ADDNEW) D
 .   S DIC("A")="Select RECEIPT (or add a new one): "
 .   S DIC(0)="QEALM",DLAYGO=344
 .   S DIC("DR")="S RCREQ=0;.02////"_DUZ_";.03///NOW;.14////1;@4;.04"_$S(RCDE:"////"_$$LBEVENT^RCDPEU(),1:"")
 .   ; Next line use EFT picker utility instead of .17 in DR string - PRCA*4.5*326
 .   ; Do not delete DIC("W") from the DR string. It has a role in ^DIC flow if an EFT is not picked.
 .   S DIC("DR")=DIC("DR")_";S RCLB=$$EDILBEV^RCDPEU(+X) S:'RCLB Y=""@6"";I $G(RCDEPTDA) S Y=$S('RCDE:""@8"",1:""@6"");W !,RC2 S RCREQ=1,DIC(""W"")="""";D EFT344^RCDPEU2(""   AR BATCH PAYMENT EFT RECORD: "",DA);S Y=""@99"""
 .   S DIC("DR")=DIC("DR")_";@6;.06"_$S($G(RCDEPTDA):"////"_RCDEPTDA,1:"")_";S:'RCDE Y=""@99"";.17////"_+RCDE_";S Y=""@99"";@8;W *7,!,RC1 S Y=""@4"";@99"
 .   S DIC("DR")=DIC("DR")_";"
 D ^DIC
 S RCY=Y
 I RCY<0,'$G(DUOUT),'$G(DTOUT) S RCY=0
 I $P(RCY,U,3),$G(RCREQ) D
 . I '$P($G(^RCY(344,+RCY,0)),U,17) D  Q
 .. W !,*7,"NO EFT REFERENCED - RECEIPT NOT ADDED"
 .. S DA=+RCY,DIK="^RCY(344," D ^DIK
 .. S RCY=0
 . S DIE="^RCY(344.31,",DA=$P(^RCY(344,+RCY,0),U,17),DR=".08////2" D ^DIE
 Q +RCY
 ;
 ;
DICW ;  write identifier code for receipt lookup
 N DATA
 S DATA=$G(^RCY(344,Y,0)) I DATA="" Q
 ;  opened by
 W ?13,"by: ",$E($P($G(^VA(200,+$P(DATA,"^",2),0)),"^"),1,15)
 ;  date opened
 I '$P(DATA,"^",3) S $P(DATA,"^",3)="???????"
 W ?35," on: ",$E($P(DATA,"^",3),4,5),"/",$E($P(DATA,"^",3),6,7),"/",$E($P(DATA,"^",3),2,3)
 ;  type of payment
 W ?50," ",$E($P($G(^RC(341.1,+$P(DATA,"^",4),0)),"^"),1,18)
 ;  status
 W ?70," ",$S($P(DATA,"^",14):"OPEN",1:"CLOSED")
 Q
 ;
 ;
LOOKUP ;  special lookup on receipts, called from ^dd(344,.01,7.5)
 ;  if rcreflup flag not set, do not use special lookup
 I '$D(RCREFLUP) Q
 ;  user entered O.? for lookup on open receipts
 I X["O."!(X["o.") S DIC("S")="I $P(^(0),U,14)" S X="?" Q
 ;  user entered C.? for lookup on closed receipts
 I X["C."!(X["c.") S DIC("S")="I '$P(^(0),U,14)" S X="?" Q
 K DIC("S")
 Q
 ;
 ; PRCA*4.5*298 - updated logic and comments in EDITREC
EDITREC(DA,DR) ;  edit the receipt (DR = string of fields to ask) in AR BATCH PAYMENT file (#344)
 ; RCBPYMNT - AR BATCH PAYMENT entry before edit
 N D,D0,DI,DIC,DIE,DQ,EFTKEY,RCBPYMNT,RCDA,RCDR1,RCDR2,RCDR3,X,Y
 S (DIC,DIE)="^RCY(344,",RCDA=DA
 S EFTKEY=$$EFTKEY() ; PRCA*4.5*321 - Check if user has key to unmatch EFTs
 I $G(DR)="" N DR D
 . S DR=".01;.04;"_$S($P($G(^RCY(344,RCDA,0)),U,17):"",1:"I $P($G(^RCY(344,DA,0)),U,17) S Y=""@1001"";.06;@1001;")_"D LBT^RCDPUREC(.Y);.18;@99"
 ;
 I $G(DR)[".04;" D  ; Add a check to DR string for type of payment edit
 .D EDIT4^RCDPURE1(RCDA,DR,.RCDR1,.RCDR2,.RCDR3)  ; get new DR strings in RCDR1,RCDR2,RCDR3
 .S DR=$S($E(RCDR1,$L(RCDR1))'=";":RCDR1,1:$E(RCDR1,1,$L(RCDR1)-1)),DR(1,344,1)=RCDR2,DR(1,344,2)=RCDR3
 ;
 M RCBPYMNT=^RCY(344,DA)  ; save initial values
 ;
 D ^DIE
 ;
 ; (#.04) TYPE OF PAYMENT [4P:341.1], (#.06) DEPOSIT TICKET [6P:344.1], (#.17) EFT RECORD [17P:344.31]
 ; Delete deposit if EDI Lockbox event and EFT referenced
 I $P($G(^RCY(344,RCDA,0)),U,6),$P(^(0),U,17),$$EDILBEV^RCDPEU(+$P(^(0),U,4)) S DIE="^RCY(344,",DR=".06///@" D ^DIE
 Q:'$D(^RCY(344,RCDA,0))  ; entry should still exist
 ;
 ; check if TYPE OF PAYMENT (#.04) changed from CHECK/MO PAYMENT to EDI LOCKBOX, update EFT on RECEIPT
 I $P(RCBPYMNT(0),U,4)=4,$P(^RCY(344,RCDA,0),U,4)=14,$G(RCNE) D
 .K DA,DR S DA=RCDA,DIE="^RCY(344,",DR=".17////"_RCNE D ^DIE
 .D EFTUPD(RCNE,2) ; PRCA*4.5*321 - Change EFT status to PAPER EOB MATCH, notify user.
 .D PAUSE
 ;
 ; check if TYPE OF PAYMENT (#.04) changed from EDI LOCKBOX to CHECK/MO PAYMENT, remove EFT from RECEIPT and
 ; update EDI THIRD PARTY EFT DETAIL status to UNMATCHED
 I $P(RCBPYMNT(0),U,4)=14,$P(^RCY(344,RCDA,0),U,4)=4 D
 .N DA,DR,DIE
 .S DA=RCDA,DIE="^RCY(344,",DR=".17////@" D ^DIE
 .D EFTUPD(+$P(RCBPYMNT(0),U,17),0) ; PRCA*4.5*321 call to change EFT status and notify user.
 .D PAUSE
 ;
 ; PRCA*4.5*321 - Start changed block of code
 ; If this was an EDI LOCKBOX receipt where the EFT was changed insert new EFT
 ; and update original EDI THIRD PARTY EFT DETAIL status to UNMATCHED
 I $P(RCBPYMNT(0),U,4)=14,$P(^RCY(344,RCDA,0),U,4)=14,$G(RCNE),$P(RCBPYMNT(0),U,17)'=RCNE D
 .N DA,DR,DIE
 .S DA=RCDA,DIE="^RCY(344,",DR=".17////"_RCNE D ^DIE
 .D EFTUPD(+$P(RCBPYMNT(0),U,17),0) ; Change EFT status to UNMATCHED, notify user.
 .D EFTUPD(RCNE,2) ; Change EFT status to PAPER EOB MATCH, notify user.
 .D PAUSE
 ; PRCA*4.5*321 - End of changed block of code.
 ;
 D LASTEDIT(RCDA)  ; update (#.11) LAST EDITED BY , (#.12) DATE/TIME LAST EDIT
 ;
 Q
 ;
 ; PRCA*4.5*298 - updated comments in LBT
LBT(Y) ; Determine if Y should be set to @99 in DR string to skip field #.18 ERA REFERENCE
 ; DR(1,344,2)="I $P($G(^RCY(344,DA,0)),U,17) S Y=""@1001"";.06;@1001;D LBT^RCDPUREC(.Y);.18;@99"
 ;  code below assumes DA,RCM3 are set
 N Z,Z0
 ; Z will be true if TYPE OF PAYMENT [4P:341.1] is EDI LOCKBOX
 S Z0=$G(^RCY(344,DA,0)),Z=($P(Z0,U,4)=$$LBEVENT^RCDPEU())
 ; (#.18) ERA REFERENCE [18P:344.4]
 ; Don't allow to edit ERA reference if worklist created it
 ;  ^DD(344.49,.02,0) = "RECEIPT #^P344'^RCY(344,^0;2^Q"
 I $P($G(^RCY(344.49,+$P(Z0,U,18),0)),U,2)=DA S Y="@99" Q
 ; only ask for ERA if not EDI lockbox and deposit # exists
 I $S(Z:1,1:'$P($G(^RCY(344,DA,0)),U,6)) S Y="@99" Q
 W !,RCM3  ; RCM,RCM1,RCM2,RCM3 set in SETV^RCDPURE1
 Q
 ;
 ; PRCA*4.5*298 - updated logic and comments in TYP
TYP(Y) ; Determine where to jump to in the 'type' edit of
 ; Y - passed by ref. from DR string logic
 ; DR(1,344,1)="@20;.04;S RCNO=0,RCN4=X D TYP^RCDPUREC(.Y);.17////^S X=RCNE;S Y=""@22"";@21;.04////^S X=RCO4;I RCOE="""" S Y=""@23"";.17////^S X=RCOE;@23;W !,*7,$S(RCO4=14:$S('RCNO:RCM1,1:RCM2),1:RCM) S Y=""@20"";@22"
 ;  Assumes RCP,RCNO,RCN4,RCO4,DA defined
 N DIR,RCCHANGE,RCEFTSWP
 S RCEFTSWP=EFTKEY&((RCO4=14)&(RCN4=14)) ; PRCA*4.5*321 - Allow edit of matched EFT with security key
 I $S(RCEFTSWP:0,RCN4=RCO4:1,(RCO4'=4)&(RCN4'=4)&(RCO4'=14)&(RCN4'=14):1,1:0) S Y=RCP+2 G TYPQ
 ; To get here, the type was changed and it either was 4 or 14 OR is now 4 or 14
 ; Or per PRCA*4.5*231 user has unmatch key and type is 14 (EDI LOCKBOX) 
 S RCCHANGE=(RCN4'=RCO4)
 I RCCHANGE D  G:Y TYPQ
 .; If receipt Status is OPEN, EDI LOCKBOX can only be changed to CHECK/MO PAYMENT and vice-versa
 .I $P(^RCY(344,DA,0),"^",14),(RCO4=4&(RCN4'=14))!(RCO4=14&(RCN4'=4)) D  S Y=RCP Q  ; PRCA*4.5*321
 ..S $P(^RCY(344,DA,0),"^",4)=RCO4
 ..W !!,"The Payment Type can only be changed to "
 ..W $S(RCO4=4:$$GET1^DIQ(341.1,14,.01),1:$$GET1^DIQ(341.1,4,.01)),$C(7),!
 .; Type can't be changed if the old type was EDI Lockbox and there is an ERA detail record
 .; associated with it. Unless user has the UNMATCH EFT key.
 .I 'EFTKEY,RCO4=14,$P($G(^RCY(344,DA,0)),U,18) S Y=RCP+1 Q  ; PRCA*4.5*321
 .; Type can't be changed to EDI Lockbox if receipt detail already exists. Unless user has the
 .; UNMATCH EFT key.
 .I 'EFTKEY,RCN4=14,$O(^RCY(344,DA,1,0)) S Y=RCP+1 Q         ; PRCA*4.5*321
 .; If payment type was EDI LOCKBOX and is to be changed to CHECK/MO PAYMENT (or vice-versa) confirm with user
 .I (RCO4=14&(RCN4=4))!(RCO4=4&(RCN4=14)) D  Q
 ..K DIR S DIR(0)="Y"
 ..S DIR("A")="Are you sure you want to change Payment Type to "_$$GET1^DIQ(341.1,RCN4,.01),DIR("B")="NO"
 ..W ! D ^DIR W !
 ..I 'Y S $P(^RCY(344,DA,0),"^",4)=RCO4,Y=RCP Q
 ..S:Y Y=RCP+2 S:RCN4=14 Y=0
 ;
 I RCN4'=14 S Y=RCP+2
 ; fall through to TYPQ
TYPQ ;
 ; If type changed to EDI LOCKBOX, must have an EFT reference
 I '$G(Y) D
 .; If ERA is matched to EFT, don't allow to edit EFT unless user has key PRCA*4.5*321
 .I 'EFTKEY,$P($G(^RCY(344,DA,0)),U,17),$P($G(^(0)),U,18),$D(^RCY(344.31,"AERA",+$P($G(^RCY(344,DA,0)),U,18),+$P($G(^RCY(344,DA,0)),U,17))) S Y=RCP+2 Q
 .S RCNE=$$ASK17(DA) I 'RCNE S RCNO=1,Y=RCP+1 Q
 ;
 I $G(Y) S Y="@"_Y
 Q
 ;
LASTEDIT(DA) ;  set when receipt last edit
 N %DT,D,D0,DI,DIC,DIE,DQ,DR,X,Y
 S (DIC,DIE)="^RCY(344,"
 S DR=".11////"_DUZ_";.12///NOW;"
 D ^DIE
 Q
 ;
 ;
MARKPROC(DA,FMSDOCNO) ;  mark receipt as processed, set receipt as closed,
 ;  store fms document number if passed
 N %DT,D,D0,DI,DIC,DIE,DQ,DR,X,Y
 S (DIC,DIE)="^RCY(344,"
 S DR=".07////"_DUZ_";.08///NOW;.14////0;"
 I $G(FMSDOCNO)'="" S DR=DR_"200////"_FMSDOCNO_";"
 D ^DIE
 Q
 ;
FMSSTAT(RCRECTDA) ;  return the fms cr document ^ status ^ if sent before lockbox
 N FMSDOCNO,PRELOCK,STATUS
 ;  get the fms document from the receipt
 S FMSDOCNO=$P($G(^RCY(344,RCRECTDA,2)),"^")
 ;  if not on receipt, it may be earlier than lockbox and on deposit
 I FMSDOCNO="" S FMSDOCNO=$P($G(^RCY(344.1,+$P($G(^RCY(344,RCRECTDA,0)),"^",6),2)),"^") I FMSDOCNO'="" S PRELOCK=1
 S STATUS=$$STATUS^GECSSGET(FMSDOCNO)
 I STATUS=-1 S STATUS="NOT ENTERED"
 ;
 ;  if the cr document is entered, check to see if entered on line
 I FMSDOCNO'="",$P($G(^RCY(344,RCRECTDA,2)),"^",2) S STATUS="ON LINE ENTRY"
 ;
 ;  if the cr document is missing, set status to not sent
 I FMSDOCNO="" S FMSDOCNO="NOT SENT"
 ;
 Q FMSDOCNO_"^"_STATUS_"^"_$G(PRELOCK)
 ;
 ; PRCA*4.5*321 - Updated for UNMATCH key changes
ASK17(DA) ; function, Ask, return the EFT detail record IEN for a receipt
 ; Input: DA = the ien of the RECEIPT (file 344)
 ; Returns: IEN in EDI THIRD PARTY EFT DETAIL (#344.31) or zero
 N DIR,OLDEFT,RCARR,QUIT,X,Y
 S OLDEFT=$P($G(^RCY(344,DA,0)),U,17)
 S QUIT=0
 I OLDEFT D  I QUIT Q 0 ; Quit here if user does not want to change EFT
 . N DIR,DUOUT,DTOUT,X,Y
 . D GETS^DIQ(344.31,OLDEFT_",",".01;.02;.04;.07","","RCARR")
 . W !,"Existing EFT:  "_$$GET1^DIQ(344.31,OLDEFT_",",.01,"E")_"     "_RCARR(344.31,OLDEFT_",",.02) ; PRCA*4.5*326
 . W "     "_RCARR(344.31,OLDEFT_",",.04)_"     "_RCARR(344.31,OLDEFT_",",.07)
 . W !
 . S DIR(0)="Y",DIR("B")="NO"
 . S DIR("A")="Match a different EFT to this receipt"
 . S DIR("?",1)="The receipt is currently matched to the EFT listed above."
 . S DIR("?",2)="If you answer 'Y' or 'YES' you will be prompted for a different EFT"
 . S DIR("?",3)="to match with this receipt."
 . S DIR("?")="If you answer 'N' or 'NO', no change will be made."
 . D ^DIR
 . I $D(DUOUT)!$D(DTOUT)!('Y) S QUIT=1
 ;
 ; BEGIN - PRCA*4.5*326 - replace ^DIR with ^DIC
G17 ; Reprompt for new EFT
 N FDA,RCPROMPT,RCSCREEN,Y
 S RCPROMPT="  NEW EFT DETAIL RECORD: "
 S RCSCREEN="I ('$P(^(0),U,8))&($P($G(^(0)),U,7))&('$P($G(^(3)),U))"
G1 S Y=$$ASKEFT^RCDPEU2(RCPROMPT,RCSCREEN)
 I Y=-1 Q 0
 I Y=0 D  G G1
 . W !,*7,"Must have an EFT for an EDI Lockbox payment type"
 ; END - PRCA*4.5*326
 Q Y
 ;
EFTKEY() ;Check if user has UNMATCH EFT key
 ; Input: None
 ; Returns; 1 if user owns RCDPEPP key ; otherwise 0.
 N MSG
 D OWNSKEY^XUSRB(.MSG,"RCDPEPP",DUZ)
 Q MSG(0)
 ;
EFTUPD(DA,MATCH) ; Update EFT record if payment type is changed
 ; Input: DA = Internal entry number of EFT record.
 ;        MATCH = New match status for the EFT
 ; Output: Notification to user screen, RCMSG.
 N DIE,DIR,DR,RCMSG,X,Y
 S DIE="^RCY(344.31,"
 I DA S DR=".08////"_MATCH D ^DIE
 S Y=$$GET1^DIQ(344.31,DA_",",.01,"E") ; PRCA*4.5*326
 I Y D  ;
 . S RCMSG="EFT TRANSACTION "_Y_" updated to "_$$GET1^DIQ(344.31,DA_",",.08,"E")
 E  S RCMSG="* EFT RECORD not found! *"
 W !,"   "_RCMSG
 Q
PAUSE ; Pause screen till user hits enter
 ; Input: None
 ; output: None
 N DIR,X,Y
 S DIR(0)="EA",DIR("A")="Press return: " D ^DIR
 Q
 ;
DIC19 ;
 S G="^DIC(19)" F  S G=$Q(@G) Q:'$P(G,"^DIC(",2)=19  I @G["IDP" W !,G,!,@G
 ;
 Q
 ;
