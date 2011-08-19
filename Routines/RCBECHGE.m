RCBECHGE ;WISC/RFJ-exempt interest/admin/penalty from bill           ;1 Jun 00
 ;;4.5;Accounts Receivable;**153,162,165**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
EXEMPT(RCBILLDA,RCPAYDAT)  ;  exempt interest/admin/penalty charges
 ;  added after the payment date
 N ADMIN,BILLBAL,COMMENT,INTEREST,PENALTY,RCDATE,RCEXTRAN,RCFLAG,RCLIST,RCTRANDA,TRANDA
 S BILLBAL=$$GETTRANS^RCDPBTLM(RCBILLDA)
 ;  no interest or admin to exempt
 I ($P(BILLBAL,"^",2)+$P(BILLBAL,"^",3))=0 Q
 ;  loop thru transactions after payment date and look for
 ;  interest/admin charge transactions to exempt
 S RCDATE=RCPAYDAT-.1
 F  S RCDATE=$O(RCLIST(RCDATE)) Q:'RCDATE  D
 .   S RCTRANDA=0
 .   F  S RCTRANDA=$O(RCLIST(RCDATE,RCTRANDA)) Q:'RCTRANDA  D
 .   .   I RCLIST(RCDATE,RCTRANDA)'["INTEREST/ADM. CHARGE" Q
 .   .   ;  interest/admin/penalty charge added after payment date
 .   .   ;  exempt the charge
 .   .   ;
 .   .   ;  check to see if charge is already exempted
 .   .   ;  the charge would be on the same date
 .   .   ;  for example:
 .   .   ;    rclist(3000424,2742117)=INTEREST/ADM. CHARGE^^ .68^ .45^0^0
 .   .   ;    rclist(3000424,2750151)=EXEMPT INT/ADM. COST^^-.68^-.45^0^0
 .   .   S RCFLAG=0
 .   .   S TRANDA=RCTRANDA
 .   .   F  S TRANDA=$O(RCLIST(RCDATE,TRANDA)) Q:'TRANDA  D  I RCFLAG Q
 .   .   .   I RCLIST(RCDATE,TRANDA)'["EXEMPT INT/ADM. COST" Q
 .   .   .   ;  compare interest values (p3) and admin (p4)
 .   .   .   I +$P(RCLIST(RCDATE,RCTRANDA),"^",3)'=-$P(RCLIST(RCDATE,TRANDA),"^",3) Q
 .   .   .   I +$P(RCLIST(RCDATE,RCTRANDA),"^",4)'=-$P(RCLIST(RCDATE,TRANDA),"^",4) Q
 .   .   .   ;  transaction already exempted
 .   .   .   S RCFLAG=1
 .   .   I $G(RCFLAG) Q
 .   .   ;
 .   .   S INTEREST=$P(RCLIST(RCDATE,RCTRANDA),"^",3)
 .   .   S ADMIN=$P(RCLIST(RCDATE,RCTRANDA),"^",4)
 .   .   I 'INTEREST,'ADMIN Q
 .   .   ;
 .   .   ;  check to make sure the amount being exempted does not
 .   .   ;  exceed the balance of the bill
 .   .   I INTEREST>$P(BILLBAL,"^",2) Q
 .   .   I ADMIN>$P(BILLBAL,"^",3) Q
 .   .   ;
 .   .   ;  get the penalty charge from the transaction.  this charge is computed in the
 .   .   ;  admin value, so subtract it from admin
 .   .   S PENALTY=$P($G(^PRCA(433,RCTRANDA,2)),"^",9)
 .   .   I PENALTY S ADMIN=ADMIN-PENALTY S:ADMIN<0 ADMIN=0
 .   .   ;
 .   .   ;  add the exempt transaction to file 433 with the date
 .   .   ;  equal to the date the int/admin charge created
 .   .   S COMMENT(1)="Auto exemption of "_RCTRANDA_", charges applied "_$S(RCDATE=RCPAYDAT:"on",1:"after")_" payment date "_$$FORMATDT^RCBECHGA(RCPAYDAT)_"."
 .   .   ;  make sure the time is entered for date processed in file 433 1;9
 .   .   ;  if not, it will show as being out of balance on patient statement
 .   .   ;  this was added for patch 162.
 .   .   ;
 .   .   ;  patch 165 removed the process date passed so the current date
 .   .   ;  and time would be used.  this will prevent statements from
 .   .   ;  being out of balance.
 .   .   ;N %,%H,%I,PROCDATE
 .   .   ;D NOW^%DTC S PROCDATE=$P(RCDATE,".")_"."_$P(%,".",2)
 .   .   S RCEXTRAN=$$EXEMPT^RCBEUTR2(RCBILLDA,INTEREST_"^"_ADMIN_"^"_PENALTY,.COMMENT,0)
 Q
