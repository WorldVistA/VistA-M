IBARXEU ;AAS/ALB - RX EXEMPTION UTILITY ROUTINE ;2-NOV-92
 ;;2.0;INTEGRATED BILLING;**20,222,293**;21-MAR-94;Build 1
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
RXST(DFN,IBDT) ; -- Check rx income exemption status of patient
 ;
 ;  input = :  dfn  = patient file pointer
 ;             ibdt = date to check for (optional) default is today
 ;
 ;  returns :  -1 if no data   ^text^reason code^reason text^date of test
 ;              0 if non exempt
 ;              1 if exempt
 ;
 N X,Y,Z,IBX,IBON
 ;
 S IBON=$$ON^IBARXEU0 I IBON<1 Q IBON
 ;
 S IBX=""
 I '$G(IBDT) S IBDT=DT
 I IBDT>DT S IBDT=DT ; no future dates
 ;
 ; -- date before legislations
 I IBDT<$$STDATE S IBX="0^NON-EXEMPT^^Date is Prior to Legislation^" G RXSTQ ; nobody exempt prior to legislation
 ;
 ; -- if no data on patient quit
 S X=$G(^IBA(354,DFN,0))
 I X=""!('$D(^IBA(354.1,"AP",DFN))) S IBX="-1^UNKNOWN^^Medication Copayment Exemption status never determined" G RXSTQ ; no data return -1
 ;
 ; -- use current status if ibdt not less than current test and
 ;    not greater than current test date +365
 I IBDT'<$P(X,U,3),IBDT'>$$PLUS^IBARXEU0($P(X,U,3)) S IBX=$$IBX^IBARXEU0(DFN,IBDT) G RXSTQ
 ;
 ; -- if ibdt not less than current date but greater than
 ;    current test +365 is into future
 I IBDT'<$P(X,U,3),IBDT>$$PLUS^IBARXEU0($P(X,U,3)) D
 .S Y=$$LST^IBARXEU0(DFN,IBDT)
 .;
 .; -- see if patient was SC>50, can't be updated so don't say previous
 .I $L($$ACODE^IBARXEU0(Y))<3 S IBX=+$P(X,U,4)_U_$$TEXT^IBARXEU0($P(X,U,4))_U_$$ACODE^IBARXEU0(Y)_U_$$REASON^IBARXEU0(X)_U_$P(X,U,3) Q
 .;
 .S IBX=+$P(X,U,4)_U_"Previously "_$$TEXT^IBARXEU0($P(X,U,4))_U_$$ACODE^IBARXEU0(Y)_U_"Requires new exemption. Previously "_$$REASON^IBARXEU0(X)_U_$P(X,U,3)
 ;
 ; -- if ibdt less than current date need old exemption data
 I IBDT<$P(X,U,3) D  G RXSTQ
 .;
 .; -- find status of prior test
 .S Y=$$LST^IBARXEU0(DFN,IBDT)
 .;
 .; -- no previous data
 .I Y="" D  Q
 ..S IBX="-1^UNKNOWN^^No data for date requested."
 ..Q
 .;
 .S Z=$G(^IBA(354,DFN,0)),Z=$P(Z,U,5)_U_$P(Z,U,3) ; get status & date
 .;
 .; -- if old exemption is current for copay date
 .I IBDT'>$$PLUS^IBARXEU0(+Y) D  Q
 ..S X=$G(^IBE(354.2,+$P(Y,U,5),0)) ; exemption reason node
 ..S IBX=+$P(X,U,4)_U_$$TEXT^IBARXEU0($P(X,U,4))_U_$$ACODE^IBARXEU0(Y)_U_$$REASON^IBARXEU0(X)_U_$P(X,U,3)
 ..Q
 .;
 .; -- if ibdt is greater than old exemption + 365
 .;    report previous
 .I IBDT>$$PLUS^IBARXEU0(+Y) D  Q
 ..S X=$G(^IBE(354.2,+$P(Y,U,5),0)) ;exemption reason node
 ..;
 ..; -- see if patient was SC>50, can't be updated so don't say previous
 ..I $L($$ACODE^IBARXEU0(Y))<3 S IBX=+$P(X,U,4)_U_$$TEXT^IBARXEU0($P(X,U,4))_U_$$ACODE^IBARXEU0(Y)_U_$$REASON^IBARXEU0(X)_U_$P(X,U,3) Q
 ..;
 ..S IBX=+$P(X,U,4)_U_"Previously "_$$TEXT^IBARXEU0($P(X,U,4))_U_$$ACODE^IBARXEU0(Y)_U_"Requires new exemption. Previously "_$$REASON^IBARXEU0(X)_U_$P(X,U,3)
 ..Q
 .Q
 ;
RXSTQ Q IBX
 ;
DISP(DFN,IBDT,NO,NULL) ; -- formats text to display 
 ; -- input =  dfn
 ;             ibdt = date to check for
 ;             no   = number of lines to print (1, 2, or 3)
 ;             null = if zero print unknown, if non-zero quit
 ;
 I '$G(IBDT) S IBDT=DT
 I '$D(NULL) S NULL=1
 I IBDT>DT S IBDT=DT ; no future dates
 I '$G(NO) S NO=3
 S X=$$RXST(DFN,IBDT)
 S IBON=$$ON^IBARXEU0 I IBON<1 S X=IBON
 I X<0&(NULL) G DISPQ
 W !,"Medication Copayment Exemption Status: ",$P(X,U,2) G:NO<2 DISPQ
 W !,$P(X,U,4) G:NO<3 DISPQ
 I $P(X,U,5) W !,"Last Rx Copay Exemption date: " S Y=$P(X,U,5) D DT^DIQ
DISPQ Q
 ;
STDATE() ; -- legislative start date for income exemption
 Q 2921030
 ;
 ;
ACTIVE(IBZ) ; -- SCREEN for active field of billing exemptions file
 ;    only one entry per effective date can be active
 ;
 N IBX,IBY,T
 S T=0
 S IBZ=$S(IBZ=1:IBZ,$E(IBZ)="A":1,1:0)
 I 'IBZ S T=1 G ACTIVEQ
 S IBX=$G(^IBA(354.1,DA,0))
 S IBY=$O(^IBA(354.1,"AIVDT",+$P(IBX,U,3),+$P(IBX,U,2),-$P(IBX,U),0))
 I 'IBY!(IBY=DA) S T=1
 W:$D(IBTALK) !!,"Another entry is already Active, You must inactivate it first",!!
ACTIVEQ Q T
