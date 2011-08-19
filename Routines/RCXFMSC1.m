RCXFMSC1 ;WISC/RFJ-fms cash receipt (cr) build lines ;1 Oct 97
 ;;4.5;Accounts Receivable;**90,96,106,113,135,98,173,220**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
FMSLINES(RECEIPDA,RCTR) ;  receipda is the ien for the receipt in file 344
 ;  return total(fund,revsrce,vendorid,fmstrantype) = dollar amount
 ; RCTR = 1 if extracting for a TR document, null or 0 if for CR
 ;
 N %,ACCRUAL,AMOUNT,BILLDA,CATEGORY,FMSTYPE,FUND,RECEIPT,REVSRCE
 N TRAN0,TRAN3,TRANDA,VENDORID,RECEFT,RCEDILB,Z
 ;
 S RCEDILB=$$EDILB^RCDPEU(RECEIPDA),RCTR=$G(RCTR)
 S RECEFT=$S(RCEDILB=1:1,1:"") ; EFT deposit CR doc
 S RECEIPT=$P($G(^RCY(344,RECEIPDA,0)),"^")
 I RECEIPT="" Q
 ;
 S TRANDA=0 F  S TRANDA=$O(^PRCA(433,"AF",RECEIPT,TRANDA)) Q:'TRANDA  D
 .   S TRAN0=$G(^PRCA(433,TRANDA,0)),TRAN3=$G(^PRCA(433,TRANDA,3))
 .   S CATEGORY=$P($G(^PRCA(430,+$P(TRAN0,"^",2),0)),"^",2)
 .   S BILLDA=+$P(TRAN0,"^",2)
 .   ;
 .   ;  do not send champva
 .   I CATEGORY=29 S FUND="0160a1" D SETTMP Q
 .   ;
 .   S ACCRUAL=$$ACCK^PRCAACC(BILLDA)
 .   ;
 .   ;  if its not an accrual, send a detail document
 .   I 'ACCRUAL D  Q
 .   .   S FMSTYPE=$$GETTYPE(BILLDA,RCTR)
 .   .   I FMSTYPE="" S FMSTYPE="XX" ; make it reject if missing
 .   .   ;  send a detail document only if there is principal
 .   .   I $P(TRAN3,"^") S DETAIL(FMSTYPE,BILLDA)=$G(DETAIL(FMSTYPE,BILLDA))+$P(TRAN3,"^")
 .   .   ;  set tmp global which is used by the 215 report
 .   .   S FUND=$$GETFUNDB^RCXFMSUF(BILLDA,,RECEFT) D SETTMP
 .   .   ;
 .   .   ;  look for interest and admin charges
 .   .   ;  use vendorid x for totals
 .   .   S VENDORID="MISCN"
 .   .   ;  get the revenue source code for the bill
 .   .   S REVSRCE=$$CALCRSC^RCXFMSUR(BILLDA,RECEFT)
 .   .   D INTADMIN
 .   ;
 .   ;  get the fund for the bill
 .   S FUND=$$GETFUNDB^RCXFMSUF(BILLDA,,RECEFT)
 .   ;
 .   ;  get the vendor id $p(2) for the bill
 .   S VENDORID=$S(FUND=528709:"EXCFVALUE",FUND=4032:"EXCFVALUE",1:"MCCFVALUE")
 .   ;
 .   ;  get the revenue source code for the bill
 .   S REVSRCE=$$CALCRSC^RCXFMSUR(BILLDA,RECEFT)
 .   ;
 .   ;  get the principle collected, $p(tran3,"^"), if prepayment
 .   ;  set it to 1;5 with no interest, admin, etc.
 .   I CATEGORY=26 S TRAN3=$P($G(^PRCA(433,TRANDA,1)),"^",5)
 .   ;
 .   ;  total principal
 .   D TOTAL($P(TRAN3,"^"))
 .   ;
 .   ;  set tmp for detail
 .   D SETTMP
 .   ;
 .   ;  check for interest collected
 .   D INTADMIN
 Q
 ;
 ;
INTADMIN ;  check for interest and admin charges
 S AMOUNT=$P(TRAN3,"^",2)
 I AMOUNT S FUND=$$GETFUNDO^RCXFMSUF("I") D TOTAL(AMOUNT)
 ;  check for admin collected
 S AMOUNT=$P(TRAN3,"^",3)
 I AMOUNT S FUND=$$GETFUNDO^RCXFMSUF("A") D TOTAL(AMOUNT)
 ;  check for marshall fee collected
 S AMOUNT=$P(TRAN3,"^",4)
 I AMOUNT S FUND=$$GETFUNDO^RCXFMSUF("M") D TOTAL(AMOUNT)
 ;  check for court cost collected
 S AMOUNT=$P(TRAN3,"^",5)
 I AMOUNT S FUND=$$GETFUNDO^RCXFMSUF("C") D TOTAL(AMOUNT)
 Q
 ;
 ;
TOTAL(AMOUNT) ;  accumulate totals for summary document
 I 'AMOUNT Q
 ;  check key elements and if null set to X's to reject
 I FUND="" S FUND="XXXXXX"
 I REVSRCE="" S REVSRCE="XXXX"
 I VENDORID="" S VENDORID="XXXXX"
 ;
 S TOTAL(FUND,REVSRCE,VENDORID)=$G(TOTAL(FUND,REVSRCE,VENDORID))+AMOUNT
 Q
 ;
 ;
SETTMP ;  set the tmp global for detailed data by bill
 ;  the tmp global is used by the 215 report (rcy215a)
 I FUND="" S FUND="XXXXXX"
 ;
 S %=$G(^TMP($J,"RCFMSCR",FUND,BILLDA))
 S $P(%,"^",1)=$P(%,"^",1)+$P(TRAN3,"^",1)  ; principal
 S $P(%,"^",2)=$P(%,"^",2)+$P(TRAN3,"^",2)  ; interest
 S $P(%,"^",3)=$P(%,"^",3)+$P(TRAN3,"^",3)  ; admin
 S $P(%,"^",4)=$P(%,"^",4)+$P(TRAN3,"^",4)  ; marshal fee
 S $P(%,"^",5)=$P(%,"^",5)+$P(TRAN3,"^",5)  ; court cost
 S ^TMP($J,"RCFMSCR",FUND,BILLDA)=%
 Q
 ;
 ;
GETTYPE(BILLDA,RCTR) ;  return a bills fms transaction type (which goes on the CRA code
 ;  sheet) from the field 259 refund/reimbursement in file 430.
 ; If RCTR = 1, return TR code, otherwise return CR code
 N REFUND
 S RCTR=$S($G(RCTR):7,1:3) ; CR code is in piece 3 of data, TR is in pc 7
 S REFUND=$$RECTYP^PRCAFUT(BILLDA)
 I REFUND<0 S REFUND=""
 I $L(REFUND)=1 S REFUND="0"_REFUND
 ;  this call gets the transaction type from file 347.4
 S REFUND=$$DTYPE^PRCAFBD1(REFUND)
 I REFUND<0 S REFUND=""
 Q $S($P(REFUND,"^",RCTR)'="":$P(REFUND,"^",RCTR),1:REFUND)
 ;
 ;
LINE(BILLDA) ;
 ;returns FMS line number
 N X
 S X=$P($G(^PRCA(430,BILLDA,11)),"^",4)
 I X="" S X="001"
 Q X
