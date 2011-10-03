RCBMILLD ;WISC/RFJ-millennium bill (calculations internal set tmp) ; 27 Jun 2001 11:10 AM
 ;;4.5;Accounts Receivable;**170**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
SETTEMP(TYPE,PRINCPAL,AMTOMCCF,AMTOHSIF,PAIDMCCF,PAIDHSIF) ;  build the temp global
 ;  called internally by the routine rcbmillc
 ;
 ;  type = type of transaction
 ;  princpal = principal amount of transaction
 ;  amtomccf = expected amount calculated going to mccf
 ;  amtohsif = expected amount calculated going to hsif
 ;  paidmccf = amount already paid to mccf for the payment
 ;  paidhsif = amount already paid to hsif for the payment
 ;
 ;  if not a payment, set running balance of what is owed to mccf and hsif
 I TYPE'="P" D
 .   S RCTOTAL("OWED TO MCCF")=RCTOTAL("OWED TO MCCF")+AMTOMCCF("BEFORE EFF DATE")+AMTOMCCF("AFTER EFF DATE")
 .   S RCTOTAL("OWED TO HSIF")=RCTOTAL("OWED TO HSIF")+AMTOHSIF
 ;
 ;  if a payment, add amount paid to mccf and hsif
 I TYPE="P" D
 .   S RCTOTAL("PAID TO MCCF")=RCTOTAL("PAID TO MCCF")+AMTOMCCF("BEFORE EFF DATE")+AMTOMCCF("AFTER EFF DATE")
 .   S RCTOTAL("PAID TO HSIF")=RCTOTAL("PAID TO HSIF")+AMTOHSIF
 ;
 ;  build total owed to hsif for bill
 S RCBALANC("HSIF")=RCBALANC("HSIF")+AMTOHSIF
 ;
 ;  build total owed to mccf for bill
 S RCBALANC("MCCF BEFORE EFF DATE")=RCBALANC("MCCF BEFORE EFF DATE")+AMTOMCCF("BEFORE EFF DATE")
 S RCBALANC("MCCF AFTER EFF DATE")=RCBALANC("MCCF AFTER EFF DATE")+AMTOMCCF("AFTER EFF DATE")
 ;
 ;  build a tmp array of increase and decrease adjustment transactions
 ;  set tmp = transaction type 'D'ecrease or 'I"ncrease
 ;            principal amount of transaction
 ;            amount owed to mccf
 ;            amount owed to hsif
 ;            for payment, amount already paid to mccf
 ;            for payment, amount already paid to hsif
 S ^TMP($J,"RCBMILLDATA",RCBILLDA,RCTRANDA)=TYPE_"^"_PRINCPAL_"^"_(AMTOMCCF("BEFORE EFF DATE")+AMTOMCCF("AFTER EFF DATE"))_"^"_AMTOHSIF_"^"_$G(PAIDMCCF)_"^"_$G(PAIDHSIF)
 Q
