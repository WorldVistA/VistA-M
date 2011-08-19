RCBEADJI ;LL/ELZ-API FOR IB IN SETTLEMENT ;25-APR-2002
 ;;4.5;Accounts Receivable;**180**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
DECREASE(RCBN,RCTEST,RCAMT) ;  create a decrease adjustment for a bill
 ;  this will decreace the full balance and return info.
 ;
 ;  input:  RCBN = bill number
 ;          RCTEST = optional flag to indicate test mode only
 ;          RCAMT = optional specific amount to adjust
 ;
 ; output:  -(error number) ^ error message
 ;              OR
 ;          decrease adjust DA ^ decrease amt ^ int amout ^ admin amt
 ;          ^ marshal amt ^ court amt
 ;
 ;
 N RCBILLDA,RCBETYPE,RCTRANDA,STATUS,RCCAT,RCCATEG,RCRESP
 S RCBETYPE="DECREASE",RCTEST=+$G(RCTEST)
 ;
 ; get bill ien
 S RCBILLDA=$O(^PRCA(430,"D",RCBN,0))
 I RCBILLDA<1 S RCRESP="-3^Bill Number Not Found" G DECQ
 ;
 ;  bill must be active
 S STATUS=$P($G(^PRCA(430,RCBILLDA,0)),"^",8)
 I STATUS'=16,STATUS'=42 S RCRESP="-4^Bill Not Active" G DECQ
 ;
 ;  determine if bill can be adjusted based on category
 D RCCAT^RCRCUTL(.RCCAT)  ;returns rccat(category) array
 S RCCATEG=+$P(^PRCA(430,RCBILLDA,0),"^",2)
 I +$G(RCCAT(RCCATEG))=1,$$REFST^RCRCUTL(RCBILLDA) S RCRESP="-5^Bill is Referred" G DECQ
 I RCCATEG=26 S RCRESP="-6^No Pre-Payment Bills" G DECQ
 ;
 ;
 ;  adjust the bill
 S RCRESP=$$ADJBILL(RCBETYPE,RCBILLDA,$G(RCAMT))
 ;
DECQ Q RCRESP
 ;
 ;
ADJBILL(RCBETYPE,RCBILLDA,RCAMT) ;  adjust a bill
 N RCAMOUNT,RCBALANC,RCDATA7,RCONTADJ,RCTRANDA,I,X,Y,RCINT,RCCOM,RCERR
 ;  lock the bill
 L +^PRCA(430,RCBILLDA):5 I '$T Q "-7^Bill is Locked"
 ;
 ;
 ;  check the balance of the bill
 S RCBALANC=$$OUTOFBAL^RCBDBBAL(RCBILLDA)
 ;
 ;  out of balance
 I RCBALANC'="" D UNLOCK Q "-8^Bill is Out of Balance"
 ;
 ;  if the principal balance is zero, do not allow it to be adjusted
 ;  close/cancel it
 I '$G(^PRCA(430,RCBILLDA,7)) S RCINT=$$INTADMIN(RCBILLDA,RCTEST) D UNLOCK Q "-9^No Principal to Decrease^"_RCINT
 ;
 ;  adjustment amount
 S RCAMOUNT=$$AMOUNT(RCBILLDA)
 S RCAMOUNT=$S(RCAMT&(RCAMT'>RCAMOUNT):RCAMT,1:RCAMOUNT)
 I RCAMOUNT<.01 D UNLOCK Q "-10^No Amount Returned"
 ;
 ;  make negative
 S RCAMOUNT=-RCAMOUNT
 ;
 ;  if it is a contract adjustment
 I "^9^28^29^30^32^"[("^"_$P($G(^PRCA(430,RCBILLDA,0)),"^",2)_"^") S RCONTADJ=1
 ;
 ;
 S RCDATA7=$G(^PRCA(430,RCBILLDA,7))
 ;
 ;  add adjustment
 I 'RCTEST S RCTRANDA=$$INCDEC^RCBEUTR1(RCBILLDA,RCAMOUNT,"","","",$G(RCONTADJ))
 I 'RCTEST,'RCTRANDA D UNLOCK Q "-11^Adjustment NOT Processed"
 ;
 ; mark flag for settlement
 I 'RCTEST S $P(^PRCA(433,RCTRANDA,9),"^",3)=1
 ;
 ;  enter a comment
 S RCCOM(1,0)="Hartford/USAA Litigation Settlement."
 I 'RCTEST D WP^DIE(433,RCTRANDA_",",41,"","RCCOM","RCERR")
 I $D(RCERR) D UNLOCK Q "-12^Comment Error"
 ;
 ;  exempt interest and admin charges
 S RCINT=$S(RCTEST:$$INTADMIN(RCBILLDA,RCTEST),$$AMOUNT(RCBILLDA):"0^0^0^0",1:$$INTADMIN(RCBILLDA,RCTEST))
 ;
 ;
 D UNLOCK
 Q $G(RCTRANDA)_"^"_(-$G(RCAMOUNT))_"^"_$G(RCINT)
 ;
 ;
UNLOCK ;  unlock bill and transaction
 L -^PRCA(430,RCBILLDA)
 I $G(RCTRANDA) L -^PRCA(433,RCTRANDA)
 Q
 ;
 ;
INTADMIN(RCBILLDA,RCTEST) ;  adjust the interest and admin
 ;
 ;   Return is the amounts adjusted:
 ;         interest ^ admin ^ marshal ^ court
 ;
 ;   OR if error: - (error number) ^ error message
 ;
 N RCAMOUNT,RCTRANDA,Y,X
 ;
 ;  check to see if there is interest and admin charges
 S RCAMOUNT=$G(^PRCA(430,RCBILLDA,7))
 I '$P(RCAMOUNT,"^",2),'$P(RCAMOUNT,"^",3),'$P(RCAMOUNT,"^",4),'$P(RCAMOUNT,"^",5) Q "0^0^0^0"
 ;
 ;  only if there is no principal
 I 'RCTEST,RCAMOUNT Q "-13^balance still there"
 ;
 ;
 I 'RCTEST S RCTRANDA=$$EXEMPT^RCBEUTR2(RCBILLDA,$P(RCAMOUNT,"^",2)_"^"_$P(RCAMOUNT,"^",3)_"^^"_$P(RCAMOUNT,"^",4)_"^"_$P(RCAMOUNT,"^",5))
 I 'RCTEST,'RCTRANDA  Q "-14^Error processing exemption"
 ;
 ; flag transaction for settlement
 I 'RCTEST S $P(^PRCA(433,RCTRANDA,9),"^",3)=1
 ;
 Q $P(RCAMOUNT,"^",2)_"^"_$P(RCAMOUNT,"^",3)_"^^"_$P(RCAMOUNT,"^",4)_"^"_$P(RCAMOUNT,"^",5)
 ;
 ;
 ;
 ;
ADJNUM(RCBILLDA) ;  get next adjustment number for a bill
 N ADJUST,DATA1,RCTRANDA
 S RCTRANDA=0
 F  S RCTRANDA=$O(^PRCA(433,"C",RCBILLDA,RCTRANDA)) Q:'RCTRANDA  S DATA1=$G(^PRCA(433,RCTRANDA,1)) I $P(DATA1,"^",4),$P(DATA1,"^",2)=1!($P(DATA1,"^",2)=35) S ADJUST=$P(DATA1,"^",4)+1
 Q ADJUST
 ;
 ;
AMOUNT(RCBILLDA) ;  adjustment amount for a bill
 ;
 Q +$P($G(^PRCA(430,RCBILLDA,7)),"^")
 ;
TEST ; This entry point is only to be used for testing and NEVER in a
 ; production system.  This will make all the referred bills in the
 ; 430 file that are referred appear to no longer be referred.
 N IBA,IBB,DIE,DA,DR
 S IBA=0 F  S IBA=$O(^PRCA(430,"AD",IBA)) Q:IBA<1  S IBB=0 F  S IBB=$O(^PRCA(430,"AD",IBA,IBB)) Q:IBB<1  S DIE="^PRCA(430,",DA=IBB,DR="64///@" D ^DIE W "."
 Q
