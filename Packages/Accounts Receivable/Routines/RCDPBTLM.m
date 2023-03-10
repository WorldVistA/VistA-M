RCDPBTLM ;WISC/RFJ - bill transactions List Manager top routine ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,148,153,168,169,198,247,271,276,315,372**;Mar 20, 1995;Build 9
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to $$REC^IBRFN supported by DBIA 2031
 ;
 ;  called from menu option (19)
 ;
 N RCBILLDA,RCDPFXIT
 ;
 F  D  Q:'RCBILLDA
 .   W !! S RCBILLDA=$$SELBILL
 .   I RCBILLDA<1 S RCBILLDA=0 Q
 .   D EN^VALM("RCDP TRANSACTIONS LIST")
 .   ;  fast exit
 .   I $G(RCDPFXIT) S RCBILLDA=0
 Q
 ;
 ;
INIT ;  initialization for list manager list
 ;  requires rcbillda
 ;  PRCA*3.5*315 - Replaced "^" with VA Standard Variable U throughout
 N ADMIN,DATE,RCLINE,RCLIST,RCTOTAL,RCTRAN,RCTRANDA
 K ^TMP("RCDPBTLM",$J),^TMP("VALM VIDEO",$J)
 ;
 ;  fast exit
 I $G(RCDPFXIT) S VALMQUIT=1 Q
 ;
 ;  set the List Manager line number
 S RCLINE=0
 ;  set the List Manager transaction number
 S RCTRAN=0
 ;
 ;  get transactions and balance for bill
 S RCTOTAL=$$GETTRANS(RCBILLDA)
 ;
 S DATE="" F  S DATE=$O(RCLIST(DATE)) Q:'DATE  D
 .   S RCTRANDA="" F  S RCTRANDA=$O(RCLIST(DATE,RCTRANDA)) Q:RCTRANDA=""  D
 .   .   S RCLINE=RCLINE+1
 .   .   ;
 .   .   ;  create an index array for transaction lookup in list
 .   .   I RCTRANDA D
 .   .   .   S RCTRAN=RCTRAN+1
 .   .   .   S ^TMP("RCDPBTLM",$J,"IDX",RCTRAN,RCTRAN)=RCTRANDA
 .   .   .   D SET^RCDPAPLI(RCTRAN,RCLINE,1,80,0,IORVON,IORVOFF)
 .   .   ;
 .   .   D SET^RCDPAPLI($S(RCTRANDA:RCTRANDA,1:" "),RCLINE,5,80) ; PRCA*4.5*315 Incr left margin
 .   .   D SET^RCDPAPLI($E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3),RCLINE,17,25)
 .   .   D SET^RCDPAPLI($TR($P(RCLIST(DATE,RCTRANDA),U),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz"),RCLINE,27,51)
 .   .   D SET^RCDPAPLI($J($P(RCLIST(DATE,RCTRANDA),U,2),9,2),RCLINE,53,62)
 .   .   D SET^RCDPAPLI($J($P(RCLIST(DATE,RCTRANDA),U,3),9,2),RCLINE,62,71)
 .   .   ;  add marshal fee and court cost to create admin dollars
 .   .   S ADMIN=$P(RCLIST(DATE,RCTRANDA),U,4)+$P(RCLIST(DATE,RCTRANDA),U,5)+$P(RCLIST(DATE,RCTRANDA),U,6)
 .   .   D SET^RCDPAPLI($J(ADMIN,9,2),RCLINE,71,80)
 ;
 ;  show totals
 S RCLINE=RCLINE+1
 D SET^RCDPAPLI("                                                    --------- -------- --------",RCLINE,1,80)
 S RCLINE=RCLINE+1
 D SET^RCDPAPLI("   TOTAL BALANCE FOR BILL",RCLINE,1,80)
 D SET^RCDPAPLI($J($P(RCTOTAL,U,1),9,2),RCLINE,53,62)
 D SET^RCDPAPLI($J($P(RCTOTAL,U,2),9,2),RCLINE,62,71)
 D SET^RCDPAPLI($J($P(RCTOTAL,U,3)+$P(RCTOTAL,U,4)+$P(RCTOTAL,U,5),9,2),RCLINE,71,80)
 ;
 ;  compare totals to what is stored in the file
 N RCDATA7,RCFOUT
 S RCDATA7=$G(^PRCA(430,RCBILLDA,7))
 ;  for a write-off bill, the balance should equal all zeros, for
 ;  these bills, node 7 is the write-off amount, so for the out of
 ;  balance check to work, node 7 needs to be adjusted to all zeros
 I $P(^PRCA(430,RCBILLDA,0),U,8)=23 S RCDATA7="0^0^0^0^0"
 I +$P(RCDATA7,U,1)'=+$P(RCTOTAL,U,1) S RCFOUT=1
 I +$P(RCDATA7,U,2)'=+$P(RCTOTAL,U,2) S RCFOUT=1
 I ($P(RCDATA7,U,3)+$P(RCDATA7,U,4)+$P(RCDATA7,U,5))'=+$P(RCTOTAL,U,3) S RCFOUT=1
 I $G(RCFOUT) D
 .   S RCLINE=RCLINE+1
 .   D SET^RCDPAPLI(" ",RCLINE,1,80)
 .   S RCLINE=RCLINE+1
 .   D SET^RCDPAPLI("  STORED BALANCE FOR BILL (** INCORRECT **)",RCLINE,1,80)
 .   D SET^RCDPAPLI($J($P(RCDATA7,U,1),9,2),RCLINE,53,62)
 .   D SET^RCDPAPLI($J($P(RCDATA7,U,2),9,2),RCLINE,62,71)
 .   D SET^RCDPAPLI($J($P(RCDATA7,U,3)+$P(RCDATA7,U,4)+$P(RCDATA7,U,5),9,2),RCLINE,71,80)
 ;
 ;  set valmcnt to number of lines in the list
 S VALMCNT=RCLINE
 D HDR
 Q
 ;
 ;
HDR ;  header code for list manager display
 ;  requires rcbillda
 N %,DATA,RCDEBTDA,RCDPDATA
 ;
 D DIQ430^RCDPBPLM(RCBILLDA,".01;8;")
 ;
 S RCDEBTDA=$P(^PRCA(430,RCBILLDA,0),U,9)
 S DATA=$$ACCNTHDR^RCDPAPLM(RCDEBTDA)
 ;
 S %="",$P(%," ",80)=""
 ; PRCA*4.5*276 - get EEOB indicator for 1st/3rd party payment and attach to bill when applicable
 S PRCOUT=$$COMP3^PRCAAPR(RCBILLDA)
 I PRCOUT'="%" S PRCOUT=$$IBEEOBCK^PRCAAPR1(RCBILLDA)
 S VALMHDR(1)=$E("Bill #: "_$G(PRCOUT)_$G(RCDPDATA(430,RCBILLDA,.01,"E"))_%,1,25)_"Account: "_$P(DATA,U)_$P(DATA,U,2)
 S VALMHDR(2)=$E("Status: "_$G(RCDPDATA(430,RCBILLDA,8,"E"))_%,1,25)_$E("   Addr: "_$P(DATA,U,4)_", "_$P(DATA,U,7)_", "_$P(DATA,U,8)_"  "_$P(DATA,U,9)_%,1,55)
 ; PRCA*4.5*276 - show caption for user
 S VALMSG="|% EEOB | Enter ?? for more actions |" ; PRCA*4.5*276
 Q
 S VALMHDR(3)="  "_IORVON_$E("Bill Balance: "_$J($P(RCTOTAL,U)+$P(RCTOTAL,U,2)+$P(RCTOTAL,U,3)+$P(RCTOTAL,U,4)+$P(RCTOTAL,U,5),0,2)_%,1,23)_IORVOFF_"  Phone: "_$P(DATA,U,10)
 Q
 ;
 ;
EXIT ;  exit list manager option and clean up
 K ^TMP("RCDPBTLM",$J),^TMP("RCDPBTLMX",$J)
 Q
 ;
 ;
SELBILL() ;  select a bill
 ;  returns -1 for timeout or ^, 0 for no selection, or ien of bill
 N %,%Y,C,DIC,DTOUT,DUOUT,RCBEFLUP,X,Y
 N DPTNOFZY,DPTNOFZK S (DPTNOFZY,DPTNOFZK)=1
 N RCY,DIR,DIRUT
 ; allow user to get the record using bill# or ECME#
 S DIR("A")="Select (B)ILL or (E)CME#: "
 S DIR(0)="SA^B:BILL NUMBER;E:ECME#"
 S DIR("B")="B"
 D ^DIR K DIR I $D(DIRUT) Q 0
 S RCY=Y
 I RCY="E" Q $$SELECME
 S DIC="^PRCA(430,",DIC(0)="QEAM",DIC("A")="Select BILL: "
 S DIC("W")="D DICW^RCBEUBI1"
 ;  special lookup on input
 S RCBEFLUP=1
 D ^DIC
 I Y<0,'$G(DUOUT),'$G(DTOUT) S Y=0
 Q +Y
 ;
 ;
GETTRANS(BILLDA) ;  original amount goes first for bill
 ;  returns list of transactions in
 ;  rclist(date,tranda)=trantype ^ principle ^ interest ^ admin
 ;  returns principle balance ^ interest balance ^ admin balance
 ;        ^ marshall fee balance ^ court cost balance
 N %,ADMBAL,AMTDISP,CCBAL,DATA0,DATA1,DATE,INTBAL,MFBAL,PRINBAL,RCDPDATA,RCUSER,TRANDA,VALUE
 ;
 D DIQ430^RCDPBPLM(BILLDA,"3;60;")
 ;
 K RCLIST
 S (ADMBAL,CCBAL,INTBAL,MFBAL,PRINBAL)=0
 S PRINBAL=RCDPDATA(430,BILLDA,3,"I")
 ;  loop transaction and add to list
 S TRANDA=0 F  S TRANDA=$O(^PRCA(433,"C",BILLDA,TRANDA)) Q:'TRANDA  D
 .   S DATA0=$G(^PRCA(433,TRANDA,0))  ;PRCA*4.5*315 Needed for User ID
 .   S RCUSER=$P(DATA0,U,9)  ;PRCA*4.5*315
 .   S RCUSER=$$GET1^DIQ(200,RCUSER_",",1)  ;PRCA*4.5*315 
 .   S DATA1=$G(^PRCA(433,TRANDA,1))
 .   S DATE=$P(DATA1,U,9) I 'DATE Q
 .   S VALUE=$$TRANVALU(TRANDA)  ;PRCA*4.5*315 (was I VALUE="" Q)
 .   S RCLIST($P(DATE,"."),TRANDA)=$P($G(^PRCA(430.3,+$P(DATA1,U,2),0)),U)_VALUE
 .   S $P(RCLIST($P(DATE,"."),TRANDA),U,7)=RCUSER  ;PRCA*4.5*315
 .   ;
 .   ;  calculate bill's balance
 .   S PRINBAL=PRINBAL+$P(VALUE,U,2)
 .   S INTBAL=INTBAL+$P(VALUE,U,3)
 .   S ADMBAL=ADMBAL+$P(VALUE,U,4)
 .   S MFBAL=MFBAL+$P(VALUE,U,5)
 .   S CCBAL=CCBAL+$P(VALUE,U,6)
 ;
 S DATE=$G(RCDPDATA(430,BILLDA,60,"I"))
 ;  check to make sure activation date is not greater than first transaction
 S %=$O(RCLIST(0)) I DATE>% S DATE=%
 S RCLIST(+$P(DATE,"."),0)="original amount^"_RCDPDATA(430,BILLDA,3,"I")
 ;
 Q PRINBAL_U_INTBAL_U_ADMBAL_U_MFBAL_U_CCBAL
 ;
 ;
TRANVALU(TRANDA) ;  return the transaction value as displayed (with + or - sign)
 N TYPE,VALUE
 S VALUE=$$TRANBAL^RCRJRCOT(TRANDA)
 ;  no dollars on transaction
 I '$P(VALUE,U),'$P(VALUE,U,2),'$P(VALUE,U,3),'$P(VALUE,U,4),'$P(VALUE,U,5) Q ""
 ;  check type for payments, etc, make values (-) to subtract
 S TYPE=$P($G(^PRCA(433,TRANDA,1)),U,2)
 I TYPE=2!(TYPE=8)!(TYPE=9)!(TYPE=10)!(TYPE=11)!(TYPE=14)!(TYPE=29)!(TYPE=34)!(TYPE=35)!(TYPE=41) D
 .   S $P(VALUE,U,1)=-$P(VALUE,U,1)
 .   S $P(VALUE,U,2)=-$P(VALUE,U,2)
 .   S $P(VALUE,U,3)=-$P(VALUE,U,3)
 .   S $P(VALUE,U,4)=-$P(VALUE,U,4)
 .   S $P(VALUE,U,5)=-$P(VALUE,U,5)
 ;
 ;  the following transaction types should not change the bills balance
 ;  return the amount displayed in the description and 0 for value
 ;    refer to RC 3, refer to DOJ 4, reestablish 5, returned 6 and 32
 ;    repayment plan 25, amended 33, suspended 47, unsuspended 46
 K AMTDISP
 I TYPE=3!(TYPE=4)!(TYPE=5)!(TYPE=6)!(TYPE=25)!(TYPE=32)!(TYPE=33)!(TYPE=46)!(TYPE=47) D
 .   S AMTDISP=" ($"_$J($P(VALUE,U)+$P(VALUE,U,2)+$P(VALUE,U,3)+$P(VALUE,U,4)+$P(VALUE,U,5),0,2)_")"
 .   S VALUE=""
 Q $G(AMTDISP)_U_VALUE
 ;
SELECME() ;
 ; function takes the user input of the ECME # to return a valid ien of file 430
 ; if an invalid ECME is evaluated then the process keeps asking the user for ECME #
 ; until a valid ECME# is entered or until the user enters a U or null value
 ; output - returns the IEN of the record entry in the ACCOUNT RECEIVABLE file (#430) or "??"
 N RCECME,RCBILL,DIR,DIRUT,Y
 S DIR(0)="FO^1:12^I X'?1.12N W !!,""Cannot contain alpha characters"" K X"
 S DIR("A")="Select ECME#"
RET D ^DIR I $D(DIRUT) Q 0
 S RCECME=$S(+Y>0:Y,1:0)
 S RCBILL=$$REC^IBRFN(RCECME)    ; IA 2031
 I RCBILL<0 W !!,"??" G RET
 E  W !!,$P($G(^PRCA(430,+RCBILL,0)),U)," "
 Q RCBILL
 ;RCDPBTLM
