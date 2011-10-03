RCDPURET ;WISC/RFJ-receipt utilities (transactions) ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,141,169,173,196,221**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
SELTRAN(DA) ;  select a transaction for a receipt
 ;  returns -1 for timeout or ^, 0 for no selection, or ien of trans
 N %,DIC,DTOUT,DUOUT,RCDATA,X,Y
 S DIC="^RCY(344,"_DA_",1,",DIC(0)="QEAM",DIC("A")="Select Receipt TRANSACTION #: "
 S DIC("W")="S RCDATA=@(DIC_Y_"",0)"") W:$P(RCDATA,U,3) ?8,""  "",$P(@(U_$P($P(RCDATA,U,3),"";"",2)_+$P(RCDATA,U,3)_"",0)""),U) W ?40,""  $ "",$J($P(RCDATA,U,4),0,2)"
 D ^DIC
 I Y<0,'$G(DTOUT),'$G(DUOUT) S Y=0
 Q +Y
 ;
 ;
ADDTRAN(RECTDA) ;  add transaction for receipt (in da)
 N %DT,%T,D0,DA,DD,DI,DIC,DIE,DINUM,DLAYGO,DO,DQ,DR,X,Y
 I '$D(^RCY(344,RECTDA,1,0)) S ^(0)="^344.01A^"
 ;
 ;  find next transaction number
 S X=$O(^RCY(344,RECTDA,1,9999999),-1)
 F X=X+1:1 Q:'$D(^RCY(344,RECTDA,1,X,0))
 S DINUM=X
 ;
 S DA(1)=RECTDA
 S DIC="^RCY(344,"_RECTDA_",1,",DIC(0)="L",DLAYGO=344.01
 S DIC("DR")=".12////"_DUZ_";.06///TODAY;"
 D FILE^DICN
 Q +Y
 ;
 ;
EDITTRAN(RECTDA,TRANDA) ;  edit a receipt transaction
 ;  returns 1 for success, or 0 (error message)
 I '$D(^RCY(344,RECTDA,1,TRANDA,0)) Q 0
 ;
 N %,%DT,%T,%Y,C,D,D0,D1,DA,DATA,DDH,DI,DIC,DICR,DIE,DIG,DIH,DIPGM,DIU,DIV,DIW,DG,DQ,DR,DZ,RCAMOUNT,RCTYPE,RESULT,X,Y
 N RCXAMONT,RCXSUSP,RCXADJ,RCERA,RCADJ,RCXERA
 ;
 ;  build dr string based on type of payment on receipt
 S RCTYPE=$P($G(^RC(341.1,+$P(^RCY(344,RECTDA,0),"^",4),0)),"^",2)
 S RCADJ=0,RCERA=+$O(^RCY(344.4,"AREC",RECTDA,0))
 S DR=""
 I RCERA,$D(^RCY(344.49,+RCERA,0)),$P(^RCY(344,RECTDA,1,TRANDA,0),"^",28) D  ; Worklist has a dec adj associated with it
 . N Z
 . S Z=$$EXTERNAL^DILFD(344.01,.09,,$P($G(^RCY(344,RECTDA,1,TRANDA,0)),U,9))
 . S RCADJ=1,RCXERA="W !,""NOTE: This payment has an EEOB Worklist dec adj associated with it."",!,""BILL NUMBER: "_Z_" (uneditable)""",DR="X RCXERA;"
 E  D
 . ;  patient name or bill number
 . S DR=".09;"
 S DR=DR_"S Y=$S('$P(^RCY(344,DA(1),1,DA,0),U,9):""@1"",1:""@2"");"
 ;  ask comment if no acct (unapplied)
 S RCXSUSP="W !?5,""NOTE: This payment will be posted to the station's suspense fund."""
 S DR=DR_"@1;X RCXSUSP;1.02;S Y=""@3"";"
 ;  payment amount
 S RCXAMONT="W !,""  Amount Owed: $"",$J($$PAYDEF^RCDPURET($P(^RCY(344,DA(1),1,DA,0),U,9)),0,2)"
 S DR=DR_"@2;X RCXAMONT;@3;.04;"
 ;  date of payment
 S DR=DR_".06;"
 ;  type of payment = district counsel (3), check (4),
 ;                    dept of justice  (5), irs (11),
 ;                    lockbox (12)
 I RCTYPE=3!(RCTYPE=4)!(RCTYPE=5)!(RCTYPE=11)!(RCTYPE=12)!(RCTYPE=13) D
 .   S DR=DR_".07d;"     ; check number
 .   S DR=DR_".08d;"     ; bank number
 .   S DR=DR_".1d;"      ; date of check
 ;  type of payment = credit card (7)
 I RCTYPE=7 D
 .   S DR=DR_".11d;"     ; credit card number
 .   S DR=DR_".02d;"     ; confirmation number
 ;
 S (DIC,DIE)="^RCY(344,"_RECTDA_",1,"
 S DA=TRANDA,DA(1)=RECTDA
 ;  edited by
 S DR=DR_".14////"_DUZ
 D ^DIE
 D LASTEDIT^RCDPUREC(RECTDA)
 ;
 ;  check for missing fields
 S DATA=^RCY(344,RECTDA,1,TRANDA,0)
 S RESULT=1
 I RESULT,'$P(DATA,"^",4) S RESULT="Payment Amount is ZERO."
 I RESULT,'$P(DATA,"^",6) S RESULT="Date of Payment NOT entered."
 I RESULT,RCTYPE=13,$$TRACE($P(DATA,"^",3))="" S RESULT="TOP TRACE NUMBER NOT ENTERED"
 I RESULT,RCTYPE=7,$P(DATA,"^",11)="" W !,"WARNING: Credit Card Number NOT entered."
 I RESULT,$P(DATA,"^",6)<$P(DATA,"^",10) W !,"WARNING: Date of check is greater than the date of payment."
 ;
 ;  if field is missing, delete the transaction
 I 'RESULT D DELETRAN(RECTDA,TRANDA)
 ;
 ;  if transaction okay, print receipt
 I RESULT D RECEIPT^RCDPRECT(RECTDA,TRANDA)
 ;
 Q RESULT
 ;
 ;
EDITACCT(RECTDA,TRANDA) ;  edit the account on a receipt
 N C,D,D0,D1,DA,DDH,DI,DIC,DICR,DIE,DIG,DIH,DIPGM,DISYS,DIU,DIV,DIW,DQ,DR,DZ,X
 S DR=".09;"
 S (DIC,DIE)="^RCY(344,"_RECTDA_",1,"
 S DA=TRANDA,DA(1)=RECTDA
 D ^DIE
 D LASTEDIT^RCDPUREC(RECTDA)
 Q
 ;
 ;
DELEACCT(RECTDA,TRANDA) ;  delete the account on a receipt
 N D,D0,D1,DA,DI,DIC,DICR,DIE,DIG,DIH,DIU,DIV,DIW,DQ,DR,X
 S DR=".09///@;.03///@;"
 S (DIC,DIE)="^RCY(344,"_RECTDA_",1,"
 S DA=TRANDA,DA(1)=RECTDA
 D ^DIE
 D LASTEDIT^RCDPUREC(RECTDA)
 Q
 ;
 ;
EDITFMS(RECTDA,TRANDA,DEFAULT) ;  edit fms document number for clearing suspense
 N C,D,D0,D1,DA,DDH,DI,DIC,DICR,DIE,DIG,DIH,DIPGM,DISYS,DIU,DIV,DIW,DQ,DR,DZ,X
 S DR=".26;"
 I $G(DEFAULT)'="" S DR=".26////"_DEFAULT_";"
 S (DIC,DIE)="^RCY(344,"_RECTDA_",1,"
 S DA=TRANDA,DA(1)=RECTDA
 D ^DIE
 Q
 ;
 ;
MOVETRAN(RCOLDREC,RCOLDTRA,RCNEWREC) ;  move a transactions data
 N %DT,%T,D0,D1,DA,DG,DIC,DICR,DIK,DIU,RCNEWTRA,RESULT,X,Y
 ;
 ;  add new transaction to 2nd receipt
 W !,"Adding a NEW payment transaction to receipt "_$P(^RCY(344,RCNEWREC,0),"^")_": "
 S RCNEWTRA=$$ADDTRAN(RCNEWREC)
 I 'RCNEWTRA Q "Unable to ADD a new payment transaction."
 ;
 W "# ",RCNEWTRA
 ;
 ;  move data to selected receipt and re-index entry
 S ^RCY(344,RCNEWREC,1,RCNEWTRA,0)=RCNEWTRA_"^"_$P(^RCY(344,RCOLDREC,1,RCOLDTRA,0),"^",2,99)
 S DIK="^RCY(344,"_RCNEWREC_",1,",DA(1)=RCNEWREC,DA=RCNEWTRA
 D IX^DIK
 ;
 S RESULT=$$EDITTRAN(RCNEWREC,RCNEWTRA)
 Q RESULT
 ;
 ;
CANCTRAN(RECTDA,RECTRAN) ;  cancel a transaction
 N D,D0,DA,DI,DIC,DIE,DQ,DR,RCDATA,X,Y
 S (DIC,DIE)="^RCY(344,"_RECTDA_",1,"
 S RCDATA="Cancelled by: "_$P(^VA(200,DUZ,0),"^")_"    Amount: $ "_$J($P(^RCY(344,RECTDA,1,RECTRAN,0),"^",4),0,2)
 S DR="1.01////^S X=RCDATA;.04////^S X=0;.05////^S X=0;1.02;"
 S DA=RECTRAN,DA(1)=RECTDA
 D ^DIE
 D LASTEDIT^RCDPUREC(RECTDA)
 Q
 ;
 ;
DELETRAN(RECTDA,TRANDA) ;  delete a transaction
 N %,D0,D1,DA,DIC,DICR,DIG,DIH,DIK,DIU,DIV,DIW,X,Y
 S DIK="^RCY(344,"_RECTDA_",1,",DA(1)=RECTDA,DA=TRANDA
 D ^DIK
 D LASTEDIT^RCDPUREC(RECTDA)
 Q
 ;
 ;
SETUNAPP(RECTDA,TRANDA,UNAPPNUM) ;  store the unapplied deposit number
 N D,D0,DA,DI,DIC,DIE,DQ,DR,X,Y
 S (DIC,DIE)="^RCY(344,"_RECTDA_",1,"
 S DR=".25////"_UNAPPNUM_";"
 S DA=TRANDA,DA(1)=RECTDA
 D ^DIE
 Q
 ;
 ;
PAYDEF(DEBTOR) ;  get default for payment amount (used in input templates for payments)
 N X
 I 'DEBTOR Q 0
 I DEBTOR[";DPT(" S X=$$BAL^PRCAFN(DEBTOR)
 I DEBTOR[";PRCA(430,",",112,107,102,"[(","_$P($G(^PRCA(430.3,+$P($G(^PRCA(430,+DEBTOR,0)),"^",8),0)),"^",3)_",") S X=$G(^PRCA(430,+DEBTOR,7)),X=$P(X,"^")+$P(X,"^",2)+$P(X,"^",3)+$P(X,"^",4)+$P(X,"^",5)
 Q +$G(X)
 ;
 ;
PENDPAY(DEBTOR) ;  return pending payments for a debtor
 ;  returns ^tmp($j,"rcdpurec","pp",rectda,tranda)=data in 344.01
 ;  and the total pending payment dollars
 N DATA,RECTDA,TOTAL,TRANDA
 K ^TMP($J,"RCDPUREC","PP")
 ;  look at open receipts
 S RECTDA=0 F  S RECTDA=$O(^RCY(344,"ASTAT",1,RECTDA)) Q:'RECTDA  D
 .   S TRANDA=0 F  S TRANDA=$O(^RCY(344,"AACCT",DEBTOR,RECTDA,TRANDA)) Q:'TRANDA  D
 .   .   S DATA=$G(^RCY(344,RECTDA,1,TRANDA,0)) I DATA="" Q
 .   .   ;  total paid = total processed
 .   .   I +$P(DATA,"^",4)=+$P(DATA,"^",5) Q
 .   .   S ^TMP($J,"RCDPUREC","PP",RECTDA,TRANDA)=DATA
 .   .   S TOTAL=$G(TOTAL)+$P(DATA,"^",4)
 Q +$G(TOTAL)
TRACE(DEBTOR) ;ENTER TOP TRACE NUMBER FOR TOP RECEIPTS
 N TRACE,DIC,DIE,DR,DA
 S TRACE="" G TRACEQ:'DEBTOR
 S DA=$S(DEBTOR["DPT(":$O(^RCD(340,"B",DEBTOR,0)),1:$P($G(^PRCA(430,+DEBTOR,0)),U,9))
 G TRACEQ:'DA
 S (DIC,DIE)="^RCD(340,",DR=6.07 D ^DIE
 S TRACE=$P($G(^RCD(340,DA,6)),"^",7)
TRACEQ Q TRACE
