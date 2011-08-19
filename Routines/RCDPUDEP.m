RCDPUDEP ;WISC/RFJ-deposit utilities ;29/MAY/2008
 ;;4.5;Accounts Receivable;**114,173,257**;Mar 20, 1995;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 I $G(DIC(0))["L",$$AUTODEP(X) D EN^DDIOL(" ** Deposit #'s starting with "_$E(X,1,3)_" can only be used by automatic deposits",,"!") S X="" Q
 ; Do not allow for 7-, 8-, or 9-digit electronic ticket to be added.
 I $G(DIC(0))["L",'$D(^RCY(344.1,"B",X)),$L(X)>6,$L(X)<10 D EN^DDIOL(" ** Deposit # of "_$L(X)_" digits not allowed. "_$S($L(X)=9:"9 digits limited to automatic deposits.",1:""),,"!") S X="" Q
 K DIC("S")
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
