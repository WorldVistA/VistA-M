IBARXEU0 ;AAS/ALB - RX EXEMPTION UTILITY ROUTINE ; 2-NOV-92
 ;;2.0;INTEGRATED BILLING;**139**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
RXEXMT(DFN,IBDT) ; -- Check income exemption status of patient
 ; -- Warning, this function may cause new entries to be created
 ;    when no data exists of new entry for current caledar year exists.
 ;
 ;  input = :  dfn  = patient file pointer
 ;             ibdt = date to check for
 ;  returns :
 ;              0 if not exempt
 ;              1 if exempt^text^reason code^reason^date of test
 ;
 ;*** START RT CLOCK
 ;S XRTN="ADD EXEMPTION",XRTL=$ZU(0) D T0^%ZOSV
 ;
 N X,Y,IBON,IBX,IBJOB,IBEXERR,IBWHER,DA,DR,DIC,DIE
 ;
 S IBON=$$ON I IBON<1 Q IBON
 ;
 S IBX="",IBJOB=14,IBEXERR=""
 I '$G(IBDT) S IBDT=DT
 I IBDT>DT S IBDT=DT ; no future dates
 ;
 ; -- date before legislation
 I IBDT<$$STDATE^IBARXEU S IBX="0^NON-EXEMPT^^Date is prior to legislation^" G RXEXMTQ
 ;
 S X=$G(^IBA(354,DFN,0))
 ;
 ; -- if current patient, current request, get data and quit
 I IBDT'<$P(X,"^",3),IBDT'>$$PLUS($P(X,"^",3)),$P(X,"^",4)'="" S IBX=$$IBX(DFN,IBDT) G RXEXMTQ
 ;
 ; -- if no patient add one
 I '+X D ADDP^IBAUTL6 S X=$G(^IBA(354,DFN,0)) G:$G(IBEXERR) RXEXMTQ D AEX(DFN,IBDT) S IBX=$$IBX(DFN,IBDT) G RXEXMTQ
 ;
 ; -- if current exemption older than 365 days add new one
 I IBDT'<$P(X,"^",3),IBDT>$$PLUS($P(X,"^",3)) D AEX(DFN,IBDT) S IBX=$$IBX(DFN,IBDT) G RXEXMTQ
 ;
 ; -- if ibdt less than current date need old exemption data
 I IBDT<$P(X,"^",3) D
 .;
 .;find status of prior year
 .S Y=$G(^IBA(354.1,+$O(^(+$O(^IBA(354.1,"AIVDT",1,DFN,-(IBDT+.0001))),0)),0))
 .; -- no data
 .I Y="" D AEX(DFN,IBDT)
 .;
 .; -- old data too old need to insert exemption
 .I IBDT>$$PLUS(+Y) D AEX(DFN,IBDT)
 .;
 .; -- if old exemption is current for this copay date
 .S IBX=$$IBXOLD(DFN,IBDT)
 .Q
 ;
 ;*** STOP RT CLOCK
RXEXMTQ ;I $D(XRT0),$D(XRTN) D T1^%ZOSV
 ;
 Q IBX
 ;
 ;
AEX(DFN,IBDT) ; -- add exemption
 ; set exemption effective date to means test dates
 ;
 N X
 S X=$$STATUS^IBARXEU1(DFN,IBDT)
 D ADDEX^IBAUTL6(+X,$P(X,"^",2))
 Q
 ;
IBX(DFN,IBDT) ; -- format output from current status
 N X,Y
 S X=$G(^IBA(354,DFN,0)),Y=$$LST(DFN,IBDT)
 Q +$P(X,"^",4)_"^"_$$TEXT(+$P(X,"^",4))_"^"_$$ACODE(Y)_"^"_$$REASON(Y)_"^"_+Y
 ;
IBXOLD(DFN,IBDT) ; -- format output from old exemption
 N X,Y
 S Y=$$LST(DFN,IBDT)
 S X=$G(^IBE(354.2,+$P(Y,"^",5),0)) ; exemption reason node
 Q +$P(X,"^",4)_"^"_$$TEXT(+$P(X,"^",4))_"^"_$$ACODE(Y)_"^"_$$REASON(Y)_"^"_+Y
 ;
 ;
ON() ; -- is copay exemption testing on
 ;    output 1 = exemption testing is active
 ;           0 = exemption testing is inactive (everybody non-exempt)
 ;          -1 = copay is off (everybody exempt)
 Q 1
 ;Q "0^NON-EXEMPT^0^Medication Copay Exemption Testing turned off^"_DT
 ;Q "-1^EXEMPT^0^Medication Copayment has been turned off^"_DT
 ;
PLUS(X1) ; -- computes plus 1 year (into future)
 ; if x1=2920930 + 1 year = +10000 = 2930930
 I $E(X1,4,7)="0229" Q X1+10072  ;makes the anniversary date March 1
 Q X1+10000
 ;
MINUS(X1) ; -- computes minus 1 year (into past)
 Q X1-10000
 ;
ACODE(Y) ; -- return lookup code of reason, input zeroth node of exemption
 Q $P($G(^IBE(354.2,+$P($G(Y),"^",5),0)),"^",5)
 ;
REASON(Y) ; -- return reason description, input zeroth node of exemption
 Q $P($G(^IBE(354.2,+$P($G(Y),"^",5),0)),"^",2)
 ;
TEXT(X) ; -- convert 0 or 1 to text
 Q $S(X=1:"EXEMPT",X=0:"NON-EXEMPT",1:"UNKNOWN")
 ;
LST(DFN,IBDT) ; -- returns last exemption entry before date x
 ;
 ; -- returns zeroth node of last test before date
 ;
 I '$G(IBDT) S IBDT=DT
 Q $G(^IBA(354.1,+$O(^(+$O(^IBA(354.1,"AIVDT",1,DFN,-(IBDT+.00001))),0)),0))
 ;
LSTAC(DFN) ; -- computes last reason code and date for a patient
 ; -- returns exemption reason ^ exemption date
 N X1
 S X1=$G(^IBA(354.1,+$O(^(+$O(^IBA(354.1,"AIVDT",1,DFN,-(DT+.00001))),0)),0))
 Q $P($G(^IBE(354.2,+$P(X1,"^",5),0)),"^",5)_"^"_+X1
