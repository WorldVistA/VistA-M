RCCPCPS1 ;WISC/RFJ-build description for patient statement ;08 Aug 2001
 ;;4.5;Accounts Receivable;**34,48,104,170,176,192**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
TRANDESC(RCTRANDA,RCWIDTH) ;  build the description array for a transaction
 ;
 ;  initialize
 N DESCRIPT,RCBILLDA,RCCATEG,RCCATTXT,RCDATA0,RCDATA1,RCDATA3,RCLINE,TRANTYPE,X
 I '$G(RCWIDTH) S RCWIDTH=50 ; Default max. width is 50 characters
 K RCDESC
 S RCLINE=1,RCDESC(1)=""
 ;
 S RCBILLDA=+$P($G(^PRCA(433,RCTRANDA,0)),"^",2) I 'RCBILLDA Q
 S RCDATA0=^PRCA(430,RCBILLDA,0)
 S RCCATEG=+$P(RCDATA0,"^",2),RCCATTXT=$P($G(^PRCA(430.2,RCCATEG,0)),"^")
 S RCDATA1=^PRCA(433,RCTRANDA,1)
 S TRANTYPE=$P(RCDATA1,"^",2)
 ;
 ;  build the first line description
 ;  if transaction type is an increase or decrease, set description
 I TRANTYPE=1!(TRANTYPE=35) D
 .   ;  if c means test, set description to category for c means test
 .   I RCCATEG=18 S DESCRIPT=$S($P(RCDATA0,"^",16):$P(^PRCA(430.2,$P(RCDATA0,"^",16),0),"^"),1:RCCATTXT) Q
 .   ;  otherwise, set to category name
 .   S DESCRIPT=RCCATTXT
 ;
 ;  if the bill category is a rx-copay and it is an increase adjustment
 ;  then set the description to copay
 I RCCATEG=22!(RCCATEG=23),TRANTYPE=1 S DESCRIPT="COPAY"
 ;
 ;  if the bill category is adult day health care, remove health
 I RCCATEG=33 S DESCRIPT="ADULT DAY CARE"
 ;
 ;  if the bill category is respite or geriatric eval,
 ;  take the 2nd piece removing institutional
 I RCCATEG=35!(RCCATEG=36)!(RCCATEG=37)!(RCCATEG=38) S DESCRIPT=$P(RCCATTXT,"-")_$S(RCCATEG=35!(RCCATEG=37):" IN",1:" OUT")_"PATIENT"
 ;
 ;  if it is a comment transaction
 I TRANTYPE=45 S DESCRIPT="COMMENT: "_$P($G(^PRCA(433,RCTRANDA,5)),"^",2)
 ;
 ;  prepayment bill (1=increase, 35=decrease, otherwise refund)
 I RCCATEG=26 S DESCRIPT=$S(TRANTYPE=1:"OVERPAYMENT CREDIT",TRANTYPE=35:"OVERPAYMENT CREDIT DECREASE",1:"OVERPAYMENT REFUND")
 ;
 ;  if the first line description not set (like payments), set it
 ;  to the type of transaction
 I $G(DESCRIPT)="" S DESCRIPT=$P($G(^PRCA(430.3,+$P(RCDATA1,"^",2),0)),"^")
 ;
 ;  if the transaction date is different from the process date,
 ;  show it with the description
 I $P(RCDATA1,"^"),$P($P(RCDATA1,"^"),".")'=$P($P(RCDATA1,"^",9),".") S DESCRIPT=DESCRIPT_"  ("_$$DATE($P($P(RCDATA1,"^"),"."))_")"
 ;
 ;  set the first description line
 D SETDESC(DESCRIPT)
 ;
 ;  if it is a payment transaction, show amount paid interest, admin, other
 I TRANTYPE=2!(TRANTYPE=34) D
 .   S RCDATA3=$G(^PRCA(433,RCTRANDA,3))
 .   ;  if not interest, admin, or other, quit
 .   I '$P(RCDATA3,"^",2),'$P(RCDATA3,"^",3),'$P(RCDATA3,"^",4),'$P(RCDATA3,"^",5) Q
 .   ;
 .   S DESCRIPT="  (Int:"_$J(+$P(RCDATA3,"^",2),1,2)_"  Adm:"_$J(+$P(RCDATA3,"^",3),1,2)
 .   ;  calculate other
 .   S X=$P(RCDATA1,"^",5)-$P(RCDATA3,"^")-$P(RCDATA3,"^",2)-$P(RCDATA3,"^",3)
 .   S DESCRIPT=DESCRIPT_$S(X:" Other:"_$J(X,1,2)_")",1:")")
 .   D SETDESC(DESCRIPT)
 ;
 ;  if it is a admin cost or interest charge, total the amounts
 I TRANTYPE=13!(TRANTYPE=12) D  Q
 .   S X=$G(^PRCA(433,RCTRANDA,2)) I X="" Q
 .   S RCTOTAL("INT")=$G(RCTOTAL("INT"))+$P(X,"^",7)
 .   S RCTOTAL("ADM")=$G(RCTOTAL("ADM"))+$P(X,"^",8)
 .   S RCTOTAL("OTH")=$G(RCTOTAL("OTH"))+($P(RCDATA1,"^",5)-$P(X,"^",7)-$P(X,"^",8))
 ;
 ;  if not an increase adjustment, quit
 I TRANTYPE'=1 Q
 ;
 ;  increase to c means test, ltc or rx-copay, get data from ib
 I RCCATEG=18!(RCCATEG=22)!(RCCATEG=23)!((RCCATEG>32)&(RCCATEG<40)) D
 .   S X="IBRFN1" X ^%ZOSF("TEST") I '$T Q
 .   K ^TMP("IBRFN1",$J)
 .   D STMT^IBRFN1(RCTRANDA)
 .   D IBDATA
 Q
 ;
 ;
 ;  Returns RCDESC(1..n) array of Bill Description
BILLDESC(RCBILLDA,RCWIDTH) ;
 ;  initialize
 N DESCRIPT,RCCATEG,RCCATTXT,RCDATA0,RCLINE,X
 I '$G(RCWIDTH) S RCWIDTH=50 ; Default max. width is 50 characters
 K RCDESC
 S RCLINE=1,RCDESC(1)=""
 ;
 S RCDATA0=^PRCA(430,RCBILLDA,0)
 S RCCATEG=+$P(RCDATA0,"^",2),RCCATTXT=$P($G(^PRCA(430.2,RCCATEG,0)),"^")
 ;
 ;  if category=c means test, set the description and quit
 I RCCATEG=18 S DESCRIPT=$S($P(RCDATA0,"^",16):$P(^PRCA(430.2,$P(RCDATA0,"^",16),0),"^"),1:RCCATTXT) D SETDESC(DESCRIPT) Q
 ;
 ;  set the category description
 D SETDESC(RCCATTXT)
 ;
 ;  if category not champva subsitence and not tricare patient, quit
 I RCCATEG'=27,RCCATEG'=31 Q
 ;
 ;  build description for champva subsistence and tricare patient bills
 ;  get data from ib
 S X="IBRFN1" X ^%ZOSF("TEST") I '$T Q
 K ^TMP("IBRFN1",$J)
 D STMTB^IBRFN1($P(RCDATA0,"^"))
 D IBDATA
 Q
 ;
 ;
IBDATA ;  get data from IB for description
 N IBDATA,IBJ
 ;
 ;  show IB data
 S IBJ=0 F  S IBJ=$O(^TMP("IBRFN1",$J,IBJ)) Q:'IBJ  S IBDATA=^TMP("IBRFN1",$J,IBJ) D
 .   ;
 .   ;  if no drug or bill date returned from IB, then it is outpatient
 .   I $P(IBDATA,"^",3)="" D:$P(IBDATA,"^",2) SETDESC("VISIT DATE: "_$$DATE($P(IBDATA,"^",2))) Q
 .   ;
 .   ;  if no drug quantity returned from ib, then it is inpatient
 .   I '$P(IBDATA,"^",6) D  Q
 .   .   I $P(IBDATA,"^",2) D SETDESC("  ADMISSION DATE: "_$$DATE($P(IBDATA,"^",2)))
 .   .   I $P(IBDATA,"^",3) D SETDESC("  BEGINNING DATE OF BILLING CYCLE: "_$$DATE($P(IBDATA,"^",3)))
 .   .   I $P(IBDATA,"^",4) D SETDESC("  ENDING DATE OF BILLING CYCLE: "_$$DATE($P(IBDATA,"^",4)))
 .   .   I $P(IBDATA,"^",5) D SETDESC("  DISCHARGE DATE: "_$$DATE($P(IBDATA,"^",5)))
 .   ;
 .   ;  pharmacy
 .   D:$P(IBDATA,"^",2) SETDESC("RX:"_$P(IBDATA,"^",2))
 .   D:$P(IBDATA,"^",7) SETDESC("FD:"_$$DATE($P(IBDATA,"^",7)))
 .   ;
 .   ;  if not patient statement detail, quit
 .   I $$DET^RCFN01($P(RCDATA0,"^",9))'=2 Q
 .   ;
 .   ;  return pharmacy detail
 .   I $P(IBDATA,"^",3)'="" D SETDESC(" DRUG:"_$TR($P(IBDATA,"^",3),"|~"))
 .   I $P(IBDATA,"^",4) D SETDESC(" DAYS:"_$P(IBDATA,"^",4))
 .   I $P(IBDATA,"^",6) D SETDESC(" QTY:"_$P(IBDATA,"^",6))
 .   I $P(IBDATA,"^",5)'="" D SETDESC(" PHY:"_$P(IBDATA,"^",5))
 .   I $P(IBDATA,"^",8) D SETDESC(" CHG:$"_$J($P(IBDATA,"^",8),0,2))
 ;
 K ^TMP("IBRFN1",$J)
 Q
 ;
 ;
 ; Add line to the description, not longer than RCWIDTH
 ; Input: RCLINE,RCWIDTH
 ; Output: RCDESC
SETDESC(DESCRIPT) N LENGTH
 ;  calculate the length of the description
 S LENGTH=$L(RCDESC(RCLINE))+$L(DESCRIPT)
 I RCDESC(RCLINE)'="" S LENGTH=LENGTH+1
 ;
 ;  the description line cannot go over RCWIDTH characters
 I LENGTH<RCWIDTH S RCDESC(RCLINE)=RCDESC(RCLINE)_$S(RCDESC(RCLINE)="":"",1:" ")_DESCRIPT Q
 ;
 ; Description line to add is over RCWIDTH
 ; The given string will be splitted _only_ if the limit is more than 44 characters.
 I $L(DESCRIPT)>RCWIDTH D  Q
 .   I RCDESC(RCLINE)'="" S RCLINE=RCLINE+1
 .   S RCDESC(RCLINE)=$E(DESCRIPT,1,RCWIDTH)
 .   S RCLINE=RCLINE+1
 .   S RCDESC(RCLINE)=$E(DESCRIPT,RCWIDTH+1,2*RCWIDTH)
 ;
 ;  over RCWIDTH characters, start new line
 I RCDESC(RCLINE)'="" S RCLINE=RCLINE+1
 S RCDESC(RCLINE)=DESCRIPT
 Q
 ;
DATE(FMDT) ;  format date mm/dd/yyyy
 I 'FMDT Q ""
 Q $E(FMDT,4,5)_"/"_$E(FMDT,6,7)_"/"_(1700+$E(FMDT,1,3))
