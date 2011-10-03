RCBMILLC ;WISC/RFJ-millennium bill (calculations top routine) ;27 Jun 2001 11:10 AM
 ;;4.5;Accounts Receivable;**170,174**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
BILLFUND(RCBILLDA,RCDATEND) ;  for a bill up to a given date,
 ;  calculate the amount that should be paid to MCCF and HSIF
 ;  returns:
 ;    tmp("rcbmilldata",$j,rcbillda,rctranda) = transaction type (P I D)
 ;                    piece 2 = principal amt of transaction
 ;                    piece 3 = amount owed to mccf
 ;                    piece 4 = amount owed to hsif
 ;                    piece 5 = for payment, amount already paid to mccf
 ;                    piece 6 = for payment, amount already paid to hsif
 ;
 ;  returns amt owed to mccf for bill
 ;          amt owed to hsif for bill
 ;          amt paid to mccf for bill
 ;          amt paid to hsif for bill
 ;
 N AMTPAID,AMTOHSIF,AMTOMCCF,CHARGES,PRINCPAL,RCBALANC,RCCHARGE,RCDATA1,RCEFFDAT,RCTOHSIF,RCTOMCCF,RCTOTAL,RCTRANDA,RCVALUE
 K ^TMP($J,"RCBMILLDATA",RCBILLDA)
 ;
 I '$G(RCDATEND) N RCDATEND S RCDATEND=9999999
 ;
 ;  this is the effective date for splitting the dollars
 ;  should be in the form 3020204 for feb 4, 2002
 S RCEFFDAT=3020204
 ;
 ;  this is the standard charge amount.  the total increase or
 ;  decrease adjustment must be evenly divisable by this amount
 ;  for splitting into separate funds
 S RCCHARGE=7
 ;
 ;  this is the amount of RCCHARGE that goes to mccf and hsif
 S RCTOMCCF=2
 S RCTOHSIF=RCCHARGE-RCTOMCCF
 ;
 ;  initialize the amounts owed to mccf and hsif for a bill
 ;  these variables are returned with the quit at the end
 S RCTOTAL("OWED TO MCCF")=0
 S RCTOTAL("OWED TO HSIF")=0
 S RCTOTAL("PAID TO MCCF")=0
 S RCTOTAL("PAID TO HSIF")=0
 ;
 ;  initialize running balance, used internally to track amounts
 S RCBALANC("MCCF AFTER EFF DATE")=0
 ;
 ;  if it is an old bill that has an orignal amt, set it up
 S RCBALANC("MCCF BEFORE EFF DATE")=0
 S RCBALANC("HSIF")=0
 I $P($G(^PRCA(430,RCBILLDA,0)),"^",3) D
 .   S RCVALUE=$P(^PRCA(430,RCBILLDA,0),"^",3)
 .   S AMTOMCCF("BEFORE EFF DATE")=RCVALUE
 .   S AMTOMCCF("AFTER EFF DATE")=0
 .   S RCTRANDA=0
 .   D SETTEMP^RCBMILLD("I*",RCVALUE,.AMTOMCCF,0)
 ;
 S RCTRANDA=0 F  S RCTRANDA=$O(^PRCA(433,"C",RCBILLDA,RCTRANDA)) Q:'RCTRANDA  D
 .   ;
 .   ;  make sure the transaction is before the ending date
 .   S RCDATA1=$G(^PRCA(433,RCTRANDA,1))
 .   I $P(RCDATA1,"^",9)>RCDATEND Q
 .   ;
 .   ;  get the principal of the transaction, this call
 .   ;  also verifies this is a valid "complete" transaction
 .   S RCVALUE=$$TRANBAL^RCRJRCOT(RCTRANDA)
 .   ;  if no principal, quit
 .   I '$P(RCVALUE,"^") Q
 .   ;
 .   ;
 .   ;  * * *  I N C R E A S E  * * *
 .   I $P(RCDATA1,"^",2)=1 D  Q
 .   .   ;  the date of the transaction must be after the effective
 .   .   ;  date or all of the principal goes to mccf
 .   .   I $P(RCDATA1,"^",9)<RCEFFDAT D  Q
 .   .   .   S AMTOMCCF("BEFORE EFF DATE")=$P(RCVALUE,"^")
 .   .   .   S AMTOMCCF("AFTER EFF DATE")=0
 .   .   .   D SETTEMP^RCBMILLD("I*",$P(RCVALUE,"^"),.AMTOMCCF,0)
 .   .   ;
 .   .   ;  the principal amount has to be evenly divisable by [the standard
 .   .   ;  charge: in rccharge].  if not all principal goes to mccf
 .   .   I $P(RCVALUE,"^")#RCCHARGE'=0 D  Q
 .   .   .   S AMTOMCCF("BEFORE EFF DATE")=$P(RCVALUE,"^")
 .   .   .   S AMTOMCCF("AFTER EFF DATE")=0
 .   .   .   D SETTEMP^RCBMILLD("I*",$P(RCVALUE,"^"),.AMTOMCCF,0)
 .   .   ;
 .   .   ;  after the effective date
 .   .   S AMTOMCCF("BEFORE EFF DATE")=0
 .   .   ;
 .   .   ;  the amount to MCCF is the number of times [the standard charge:
 .   .   ;  in rccharge] goes into the principal, multiplied by the amount
 .   .   ;  that goes to mccf: in rctomccf
 .   .   S AMTOMCCF("AFTER EFF DATE")=($P(RCVALUE,"^")/RCCHARGE)*RCTOMCCF
 .   .   ;
 .   .   ;  the amount to MCCF is the difference
 .   .   S AMTOHSIF=$P(RCVALUE,"^")-AMTOMCCF("AFTER EFF DATE")
 .   .   ;
 .   .   D SETTEMP^RCBMILLD("I",$P(RCVALUE,"^"),.AMTOMCCF,AMTOHSIF)
 .   ;
 .   ;
 .   ;  * * *  D E C R E A S E  * * *
 .   I $P(RCDATA1,"^",2)=35 D  Q
 .   .   ;  the date of the transaction must be after the effective
 .   .   ;  date or all of the principal comes from mccf
 .   .   I $P(RCDATA1,"^",9)<RCEFFDAT D  Q
 .   .   .   S AMTOMCCF("BEFORE EFF DATE")=-$P(RCVALUE,"^")
 .   .   .   S AMTOMCCF("AFTER EFF DATE")=0
 .   .   .   D SETTEMP^RCBMILLD("D*",-$P(RCVALUE,"^"),.AMTOMCCF,0)
 .   .   ;
 .   .   ;  calculate the number of copayment charges that make up
 .   .   ;  the principal.  this number is used to calculate the
 .   .   ;  dollars to hsif
 .   .   S CHARGES=$P(RCVALUE,"^")\RCCHARGE
 .   .   ;
 .   .   ;  calculate the amount that should go to hsif
 .   .   S AMTOHSIF=+$J(CHARGES*RCTOHSIF,0,2)
 .   .   ;
 .   .   ;  remainder goes to mccf
 .   .   S AMTOMCCF=$P(RCVALUE,"^")-AMTOHSIF
 .   .   ;
 .   .   ;  if the amount coming from hsif exceeds the amount owed to hsif,
 .   .   ;  move it to mccf
 .   .   I AMTOHSIF>RCBALANC("HSIF") S AMTOHSIF=RCBALANC("HSIF"),AMTOMCCF=$P(RCVALUE,"^")-AMTOHSIF
 .   .   ;
 .   .   ;  if the amount to mccf exceeds amount owed to mccf,
 .   .   ;  move more to hsif
 .   .   I AMTOMCCF>(RCBALANC("MCCF AFTER EFF DATE")+RCBALANC("MCCF BEFORE EFF DATE")) D
 .   .   .   S AMTOMCCF=RCBALANC("MCCF AFTER EFF DATE")+RCBALANC("MCCF BEFORE EFF DATE")
 .   .   .   S AMTOHSIF=$P(RCVALUE,"^")-AMTOMCCF
 .   .   ;
 .   .   ;  split the amount before and after effective date,
 .   .   ;  default is allocate all to after effective date
 .   .   S AMTOMCCF("AFTER EFF DATE")=AMTOMCCF
 .   .   S AMTOMCCF("BEFORE EFF DATE")=0
 .   .   ;
 .   .   ;  if the amount to mccf after the effective date exceeds the amount owed to mccf after the
 .   .   ;  effective date, place more in mccf before the effective date
 .   .   I AMTOMCCF("AFTER EFF DATE")>RCBALANC("MCCF AFTER EFF DATE") D
 .   .   .   S AMTOMCCF("BEFORE EFF DATE")=AMTOMCCF("AFTER EFF DATE")-RCBALANC("MCCF AFTER EFF DATE")
 .   .   .   S AMTOMCCF("AFTER EFF DATE")=RCBALANC("MCCF AFTER EFF DATE")
 .   .   ;
 .   .   ;  make amounts negative for decrease
 .   .   S AMTOMCCF("BEFORE EFF DATE")=-AMTOMCCF("BEFORE EFF DATE")
 .   .   S AMTOMCCF("AFTER EFF DATE")=-AMTOMCCF("AFTER EFF DATE")
 .   .   ;
 .   .   D SETTEMP^RCBMILLD("D",-$P(RCVALUE,"^"),.AMTOMCCF,-AMTOHSIF)
 .   ;
 .   ;
 .   ;  * * *  P A Y M E N T S  * * *
 .   ;  if it is a payment transaction, get the amount
 .   ;  already paid to the funds
 .   I $P(RCDATA1,"^",2)=2!($P(RCDATA1,"^",2)=34) D  Q
 .   .   ;  calculate the amount of this payment that should go to MCCF
 .   .   ;  for transactions created prior to the effective date
 .   .   S AMTOMCCF("BEFORE EFF DATE")=RCBALANC("MCCF BEFORE EFF DATE")
 .   .   I AMTOMCCF("BEFORE EFF DATE")>$P(RCVALUE,"^") S AMTOMCCF("BEFORE EFF DATE")=$P(RCVALUE,"^")
 .   .   ;
 .   .   ;  recalculate principal remaining after the mandatory amount
 .   .   ;  is given to MCCF
 .   .   S PRINCPAL=$P(RCVALUE,"^")-AMTOMCCF("BEFORE EFF DATE")
 .   .   ;
 .   .   ;  calculate the number of copayment charges that make up
 .   .   ;  the principal remaining.  this number is used to calculate the
 .   .   ;  dollars to hsif.  calculate the remainder after the standard
 .   .   ;  charge is allocated to mccf and hsif.
 .   .   S CHARGES=PRINCPAL\RCCHARGE
 .   .   S PRINCPAL=PRINCPAL#RCCHARGE
 .   .   ;
 .   .   ;  calculate the amount that should go to mccf
 .   .   ;    it is the number of standard charges times the
 .   .   ;    amount of each standard charge allocated to mccf
 .   .   S AMTOMCCF("AFTER EFF DATE")=+$J(CHARGES*RCTOMCCF,0,2)
 .   .   ;
 .   .   ;  if the remainder is less than the standard charge
 .   .   ;  allocated to mccf, add it also
 .   .   I PRINCPAL<RCTOMCCF S AMTOMCCF("AFTER EFF DATE")=AMTOMCCF("AFTER EFF DATE")+PRINCPAL
 .   .   ;
 .   .   ;  if the remainder is more than the standard charge
 .   .   ;  allocated to mccf, add one more standard charge to
 .   .   ;  mccf and give the rest to hsif
 .   .   I PRINCPAL>RCTOMCCF S AMTOMCCF("AFTER EFF DATE")=AMTOMCCF("AFTER EFF DATE")+RCTOMCCF
 .   .   ;
 .   .   ;  if the amount to mccf exceeds the amount owed to mccf,
 .   .   ;  place more in hsif
 .   .   I AMTOMCCF("AFTER EFF DATE")>RCBALANC("MCCF AFTER EFF DATE") D
 .   .   .   S AMTOMCCF("AFTER EFF DATE")=RCBALANC("MCCF AFTER EFF DATE")
 .   .   ;
 .   .   ;  balance of payment goes to hsif
 .   .   S AMTOHSIF=$P(RCVALUE,"^")-AMTOMCCF("BEFORE EFF DATE")-AMTOMCCF("AFTER EFF DATE")
 .   .   ;
 .   .   ;  get the amount paid to the funds
 .   .   S AMTPAID=$G(^PRCA(433,RCTRANDA,9))
 .   .   ;
 .   .   ;  make amounts negative for payment
 .   .   S AMTOMCCF("BEFORE EFF DATE")=-AMTOMCCF("BEFORE EFF DATE")
 .   .   S AMTOMCCF("AFTER EFF DATE")=-AMTOMCCF("AFTER EFF DATE")
 .   .   ;
 .   .   D SETTEMP^RCBMILLD("P",-$P(RCVALUE,"^"),.AMTOMCCF,-AMTOHSIF,$P(AMTPAID,"^"),$P(AMTPAID,"^",2))
 .   ;
 .   ;
 .   ;  * * *  R E E S T A B L I S H  * * *
 .   ;  if it is a restablish transaction, add the amount to mccf
 .   I $P(RCDATA1,"^",2)=43 D  Q
 .   .   S AMTOMCCF("BEFORE EFF DATE")=$P(RCVALUE,"^")
 .   .   S AMTOMCCF("AFTER EFF DATE")=0
 .   .   D SETTEMP^RCBMILLD("R",$P(RCVALUE,"^"),.AMTOMCCF,0)
 ;
 Q RCTOTAL("OWED TO MCCF")_"^"_RCTOTAL("OWED TO HSIF")_"^"_RCTOTAL("PAID TO MCCF")_"^"_RCTOTAL("PAID TO HSIF")
