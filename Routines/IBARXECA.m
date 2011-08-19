IBARXECA ;ALB/AAS -RX CO-PAY INCOME EXEMPTION CANCEL OLD BILLS ; 2-NOV-92
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% ; -- count variables
 ;      Patient    Totals       Represents
 ;      -------    ------       ----------
 ;  5   ibcnt      ibtcnt   = : total patient count checked
 ;  6   ibecnt     ibtecnt  = : total exempt patients
 ;  7   ibncnt     ibtncnt  = : total non-exempt patients
 ;  8   ibcecnt    ibtcecnt = : total count of exempt charges (rx's)
 ;  9   ibamt      ibtamt   = : total dollar amount checked
 ; 10   ibeamt     ibteamt  = : total exempt dollar amount
 ; 11   ibnamt     ibtnamt  = : total non-exempt dollar amount
 ; 12   ibceamt    ibtceamt = : total cancelled charges amount
 ; 15   ibnecnt    ibtnecnt = : total non-exempt count
 ; 16   ibbcnt     ibtbcnt  = : total bills checked
 ; 17   ibcbcnt    ibtcbcnt = : total number of cancelled bills
 ;
CANCEL(DFN,IBDT,IBEDT) ; -- cancel all charges for a patient for a date range
 ;  do not pass to ar as its done, call all at once later.
 ;
 D ARPARM^IBAUTL
 S IBBDT=IBDT-.00001
 F  S IBBDT=$O(^IB("APTDT",DFN,IBBDT)) Q:'IBBDT!((IBEDT+.9)<IBBDT)  S IBN=0 F  S IBN=$O(^IB("APTDT",DFN,IBBDT,IBN)) Q:'IBN  D BILL
 ;
 Q
 ;
BILL ; -- process cancelling one bill
 S X=$G(^IB(IBN,0)) Q:X=""
 Q:+$P(X,"^",4)'=52  ;quit if not pharmacy co-pay
 ; find parent
 S IBPARNT=$P(X,"^",9) Q:$D(^TMP($J,"IBARRY",DFN,IBPARNT))  ;don't keep checking  modifications to charge already checked
 ;
 S ^TMP($J,"IBARRY",DFN,IBPARNT)=""
 S IBPARDT=$P($G(^IB(IBPARNT,1)),"^",2) ; get date of parent charge
 I $S(IBPARDT="":1,IBPARDT<IBDT:1,IBPARDT>IBEDT:1,1:0) ; ignore charges started before or after date range
 ;
 ; -- get exemption status on date of charge
 ;    (NOT NECESSARY, conversion will use only current exemption
 ;S IBSTAT=$$RXEXMT^IBARXEU0(DFN,IBPARDT)
 ;
 ; -- get must recent ibaction
 S IBPARNT1=IBPARNT F  S IBPARNT1=$P($G(^IB(IBPARNT,0)),"^",9) Q:IBPARNT1=IBPARNT  S IBPARNT=IBPARNT1 ;gets parent of parents, makes sure old bug where parents get lost isn't a problem
 D LAST
 ;
 ; -- add charge amounts to corrct variable
 S IBND=$G(^IB(IBLAST,0)),IBBCNT=IBBCNT+1,IBAMT=IBAMT+$P(IBND,"^",7)
 S:IBSTAT IBCECNT=IBCECNT+1,IBEAMT=IBEAMT+$P(IBND,"^",7)
 S:'IBSTAT IBNECNT=IBNECNT+1,IBNAMT=IBNAMT+$P(IBND,"^",7)
 ;
 Q:'IBSTAT  ;quit if non-exempt
 Q:$P(^IBE(350.1,$P(^IB(IBLAST,0),"^",3),0),"^",5)=2  ;quit if already cancelled
 ;
 ; -- add cancellation charge for amount
 S IBCEAMT=IBCEAMT+$P(IBND,"^",7),IBCBCNT=IBCBCNT+1 ;counts of amount of actual cancellations
 S IBCRES=$O(^IBE(350.3,"B","RX COPAY INCOME EXEMPTION",0)) ; get cancellation reason
 ;
 D CANRX^IBARXEU3
 Q
 ;
END ;K VARIABLES
 Q
 ;
LAST ; -- find most recent (the last) entry for a parent action
 S IBLAST=""
 S IBLDT=$O(^IB("APDT",IBPARNT,"")) I +IBLDT F IBL=0:0 S IBL=$O(^IB("APDT",IBPARNT,IBLDT,IBL)) Q:'IBL  S IBLAST=IBL
 I IBLAST="" S IBLAST=IBPARNT
 Q
