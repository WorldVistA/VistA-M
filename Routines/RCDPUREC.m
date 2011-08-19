RCDPUREC ;WISC/RFJ-receipt utilities ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,148,169,173,208,222**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
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
BLDRCPT(TRANDATE,RCDEPTDA,PAYTYPDA) ; Build a receipt with/without deposit
 ;
 N TYPE,RECEIPT
 ;  build unique receipt number for date
 S TYPE=$E($G(^RC(341.1,PAYTYPDA,0))) I TYPE="" S TYPE="Z"
 I TYPE="C",$G(RCDEPTDA)["ERACHK" S RCDEPTDA=+RCDEPTDA,TYPE="E" ; ERA plus paper check EDI Lockbox receipt
 ;  lockbox receipt in the form of L980901A0, do not include century
 F  D  Q:RECEIPT'=""
 . S RECEIPT=$$NEXT(TYPE_$E(TRANDATE,2,7))  ;get last two digits from 00 to ZZ
 . L +^RCY(344,"B",RECEIPT):2 I '$T S RECEIPT=""
 ;
 ;  add it
 N %,%DT,D0,DA,DD,DI,DIC,DIE,DLAYGO,DO,DQ,DR,X,Y
 S DIC="^RCY(344,",DIC(0)="L",DLAYGO=344
 ;  .02 = opened by                  .03 = date opened = transmission dt
 ;  .04 = type of payment            .06 = deposit ticket
 ;  .14 = status (set to 1:open)
 S DIC("DR")=".02////"_DUZ_";.03///"_TRANDATE_";.04////"_PAYTYPDA_$S(RCDEPTDA:";.06////"_RCDEPTDA,1:"")_";.14////1;"
 S X=RECEIPT
 D FILE^DICN
 L -^RCY(344,"B",RECEIPT)
 I Y>0 Q +Y
 Q 0
 ;
 ;
NEXT(RECEIPT) ;  get next 2 digits in sequence 00 to ZZ for receipt
 ;
 ;  start with 00
 I '$D(^RCY(344,"B",RECEIPT_"00")) Q RECEIPT_"00"
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
 .   S DIC("DR")=DIC("DR")_";S RCLB=$$EDILBEV^RCDPEU(+X) S:'RCLB Y=""@6"";I $G(RCDEPTDA) S Y=$S('RCDE:""@8"",1:""@6"");W !,RC2 S RCREQ=1;.17;S Y=""@99"""
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
 ;
EDITREC(DA,DR) ;  edit the receipt (dr = string of fields to ask)
 N D,D0,DI,DIC,DIE,DQ,X,Y,RCDR1,RCDR2,RCDR3,DIPA,RCDA
 S (DIC,DIE)="^RCY(344,",RCDA=DA
 I $G(DR)="" N DR D
 . S DR=".01;.04;"_$S($P($G(^RCY(344,RCDA,0)),U,17):"",1:"I $P($G(^RCY(344,DA,0)),U,17) S Y=""@1001"";.06;@1001;")_"D LBT^RCDPUREC(.Y);.18;@99"
 ;
 I $G(DR)[".04;" D  ; Add a check to DR string for type of payment edit
 . D EDIT4^RCDPURE1(RCDA,DR,.RCDR1,.RCDR2,.RCDR3)
 . S DR=$S($E(RCDR1,$L(RCDR1))'=";":RCDR1,1:$E(RCDR1,1,$L(RCDR1)-1)),DR(1,344,1)=RCDR2,DR(1,344,2)=RCDR3
 ;
 D ^DIE
 I $P($G(^RCY(344,RCDA,0)),U,6),$P(^(0),U,17),$$EDILBEV^RCDPEU(+$P(^(0),U,4)) S DIE="^RCY(344,",DR=".06///@" D ^DIE ; Delete deposit if EDI LB event and EFT referenced 
 I $D(^RCY(344,RCDA,0)) D LASTEDIT(RCDA)
 Q
 ;
LBT(Y) ; Determine if Y should be set to @99 ; DR string too long
 ;  Assume DA,RCM3 is set
 N Z,Z0
 S Z0=$G(^RCY(344,DA,0)),Z=($P(Z0,U,4)=$$LBEVENT^RCDPEU())
 ; Don't allow to edit ERA reference if worklist created it
 I $P($G(^RCY(344.49,+$P(Z0,U,18),0)),U,2)=DA S Y="@99" Q
 ; only ask for ERA if not EDI lockbox and deposit # exists
 I $S(Z:1,1:'$P($G(^RCY(344,DA,0)),U,6)) S Y="@99" Q
 W !,RCM3
 Q
 ;
TYP(Y) ; Determine where to jump to in the 'type' edit of the template
 ; DR string too long
 ;  Assumes RCP,RCNO,RCN4,RCO4,DA defined
 N RCCHANGE
 I $S(RCN4=RCO4&(RCN4'=14):1,RCN4'=14&(RCO4'=14):1,1:0) S Y=RCP+2 G TYPQ
 ; To get here, the type was changed and it either was 14 or is now 14
 S RCCHANGE=(RCN4'=RCO4)
 I RCCHANGE D  G:Y TYPQ
 . ; Type can't be changed if the old type was EDI Lockbox and there is
 . ;    an ERA detail record associated with it
 . I RCO4=14,$P($G(^RCY(344,DA,0)),U,18) S Y=RCP+1 Q
 . ; Type can't be changed to EDI Lockbox if rcpt detail already exists
 . I RCN4=14,$O(^RCY(344,DA,1,0)) S Y=RCP+1 Q
 . ; If type changed to EDI LOCKBOX, must have an EFT reference
 I RCN4'=14 S Y=RCP+2 G TYPQ
TYPQ I '$G(Y) D
 . ; If ERA is matched to EFT, don't allow to edit EFT
 . I $P($G(^RCY(344,DA,0)),U,17),$P($G(^(0)),U,18),$D(^RCY(344.31,"AERA",+$P($G(^RCY(344,DA,0)),U,18),+$P($G(^RCY(344,DA,0)),U,17))) S Y=RCP+2 Q
 . S RCNE=$$ASK17^RCDPUREC(DA) I 'RCNE S RCNO=1,Y=RCP+1
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
ASK17(DA) ; Ask,return the EFT detail record for a receipt
 ; DA = the ien of the RECEIPT (file 344)
 N DIR,X,Y
 S DIR(0)="PAO^RCY(344.31,:AEMQ",DIR("?",1)="Select the EFT that contained the deposited money that this receipt details",DIR("?",2)="An EFT detail record can only be associated with one receipt"
 S DIR("?")="This is required if the type of payment is EDI LOCKBOX"
 S DIR("A")="  EFT DETAIL RECORD: ",DIR("S")="I $S('$O(^RCY(344,""AEFT"",+Y,0)):1,1:$O(^(0))=DA)"
 S:$P($G(^RCY(344,DA,0)),U,17) DIR("B")=$P(^(0),U,17)
 D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT)!Y=""!(Y<0) Q 0
 Q +Y
 ;
