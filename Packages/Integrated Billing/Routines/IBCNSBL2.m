IBCNSBL2 ;ALB/CPM - 'BILL NEXT PAYOR' BULLETIN ; 08-AUG-96
 ;;2.0;INTEGRATED BILLING;**52,80,153,240**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EOB(IBIFN,IBORIG,IBPYMT,IBTXT) ; determine if there may be another payer for this claim that should be billed
 ; in general the EOB of the current bill is required to be sent with the next TP bill in the series
 ; if there is another Third Party Payer then returns true, if any other payer (including patient) then set array
 ;
 ;   Input:    IBIFN  --  Pointer to AR (file #430), or Claim (file #399)
 ;            IBORIG  --  Original amount of the claim
 ;            IBPYMT  --  Total Amount paid on the claim
 ;
 ;  Output:    IBTXT  -- Array, pass by reference, if needed
 ;                       If a another payer (third party or patient) for the claim can be found, 
 ;                       this array will contain the text that explains who the next payer is
 ;
 ; Returns:     0     -- no need to forward EOB (no next Third Party payer found or payment=>amount due)
 ;           'true^Next payer' --  if the EOB of the bill needs to be forwarded for inclusion in the next bill,
 ;                                 generally there must be another payer for the bill that is
 ;                                 third party, non-patient, and payment was not the amount due
 ;
 N X,IB,IBPOL,IBCS,IBARCAT,IBSEC,IBRETURN,IBSEQ,IBINS S IBRETURN=0
 I '$G(IBIFN) G EOBQ
 I $G(^PRCA(430,IBIFN,0))="" G EOBQ
 I '$G(IBORIG) G EOBQ
 I $G(IBPYMT)="" G EOBQ
 ;
 S IB=$G(^DGCR(399,IBIFN,0)) I IB="" G EOBQ
 ;
 ; - quit if there is no remaining balance on the bill
 I IBPYMT'<IBORIG G EOBQ
 ;
 S IBARCAT=$P($G(^DGCR(399.3,+$P(IB,"^",7),0)),"^",6) I 'IBARCAT G EOBQ
 ;
 ; - for Champva third party claims, bill the Champva Center next
 I IBARCAT=28 D  G EOBQ
 . S IBTXT(14)="You should prepare a claim to be sent to the CHAMPVA Center.",IBRETURN="1^CHAMPVA Center"
 ;
 ; - for Tricare third party claims, next bill Tricare or the patient
 I IBARCAT=32 D  G EOBQ
 . ;
 . ; - third party bill went to Tricare Supplemental carrier, bill patient next
 . S IBSEQ=$P($G(^DGCR(399,IBIFN,0)),U,21),IBSEQ=$S(IBSEQ="P":"I1",IBSEQ="S":"I2",IBSEQ="T":"I3",1:-1)
 . S IBPOL=$G(^DGCR(399,IBIFN,IBSEQ))
 . S IBCS=$D(^IBE(355.1,"D","CS",+$P($G(^IBA(355.3,+$P(IBPOL,"^",18),0)),"^",9)))>0
 . I IBCS D  Q
 .. S IBTXT(14)="This claim was sent to the TRICARE Supplemental insurance carrier."
 .. S IBTXT(15)="You should send a copayment charge to the patient."
 . ;
 . ; - otherwise third party bill went to patients Reimb. Ins carrier, bill the tricare FI next
 . S IBRETURN="1^TRICARE Fiscal Intermediary"
 . S IBTXT(14)="You should prepare a claim to send to the TRICARE Fiscal Intermediary."
 ;
 ; - for Tricare claims, bill the patient or Tricare supplemental policy
 I IBARCAT=30 D  G EOBQ
 . ;
 . ; - if the patient has a Tricare supplemental policy, bill it
 . I $$CHPSUP(+$P(IB,"^",2)) D  Q
 .. S IBRETURN="1^TRICARE Supplemental policy"
 .. S IBTXT(14)="The patient has a TRICARE Supplemental policy."
 .. S IBTXT(15)="You should prepare a claim to be sent to that carrier."
 . ;
 . ; - otherwise, bill the patient
 . S IBTXT(14)="You should send a copayment charge to the patient."
 ;
 ; - all other bills:  if there is a next payer in the series then a bill needs to be created for that payer
 S IBSEQ=$P($G(^DGCR(399,IBIFN,0)),U,21),IBSEQ=$S(IBSEQ="P":2,IBSEQ="S":3,1:"")
 I +IBSEQ S IBINS=$P($G(^DGCR(399,IBIFN,"M")),U,IBSEQ) I +IBINS D
 . S IBRETURN=+IBINS_U_$P($G(^DIC(36,+IBINS,0)),U,1)
 . S IBTXT(14)="There is a "_$S(IBSEQ=2:"secondary",1:"tertiary")_" payor associated with this claim."
 . S IBTXT(15)="You may need to prepare a claim to be sent to "_$P(IBRETURN,U,2)_"."
 ;
EOBQ Q IBRETURN
 ;
BULL(IBIFN,IBORIG,IBPYMT) ; Generate bulletin detailing next payer for a claim, if any
 ;
 ;   Input:    IBIFN  --  Pointer to AR (file #430), or Claim (file #399)
 ;            IBORIG  --  Original amount of the claim
 ;            IBPYMT  --  Total Amount paid on the claim
 ;
 ;  Output:   Bulletin:   Mail Group MEANS TEST BILLING MAIL GROUP: IB MEANS TEST (350.9,.11)
 ;                        If a secondary payor for the claim can be found, a bulletin will be sent
 ;                        to the billing unit to alert them to forward the claim to that payor.
 ;
 N X,IB,IBX,IBTXT,IBP,IBGRP
 ;
 S IBX=$$EOB($G(IBIFN),$G(IBORIG),$G(IBPYMT),.IBTXT) I '$D(IBTXT) G BULLQ
 ;
 S IB=$G(^DGCR(399,IBIFN,0)) I IB="" G BULLQ
 S IBP=$$PT^IBEFUNC(+$P(IB,"^",2))
 ;
 ; - create remainder of bulletin
 N XMDUZ,XMTEXT,XMY,XMSUB
 S XMSUB="Notification of Subsequent Payor"
 S XMDUZ="INTEGRATED BILLING PACKAGE",XMTEXT="IBTXT("
 K XMY S XMY(DUZ)=""
 ;
 S IBTXT(1)="A payment has been made on the following claim, which has been identified"
 S IBTXT(2)="as potentially having a subsequent payor:"
 S IBTXT(3)=" "
 S IBTXT(4)="  Bill Number: "_$P($G(^PRCA(430,IBIFN,0)),"^")
 S IBTXT(5)="      Patient: "_$E($P(IBP,"^"),1,30)_"   Pt. Id: "_$P(IBP,"^",2)
 S IBTXT(6)="    Bill Type: "_$P($G(^DGCR(399.3,+$P(IB,"^",7),0)),"^")
 S IBTXT(7)="  Orig Amount: $"_$J(IBORIG,0,2)
 S IBTXT(8)="  Amount Paid: $"_$J(IBPYMT,0,2)
 S IBTXT(9)=" "
 ;
 S IBX=$G(^DGCR(399,IBIFN,0))
 S IBTXT(10)="Bill Sequence: "_$$EXSET^IBEFUNC($P(IBX,U,21),399,.21)
 S IBTXT(11)="   Bill Payer: "_$E($P($G(^DIC(36,+$G(^DGCR(399,IBIFN,"MP")),0)),U,1),1,20)
 ;
 S IBX=$G(^DGCR(399,IBIFN,"M"))
 I IBX S IBTXT(10)=IBTXT(10)_$J("",(40-$L(IBTXT(10))))_"  Primary Carrier: "_$E($P($G(^DIC(36,+IBX,0)),U,1),1,20)
 I +$P(IBX,U,2) S IBTXT(11)=IBTXT(11)_$J("",(40-$L(IBTXT(11))))_"Secondary Carrier: "_$E($P($G(^DIC(36,+$P(IBX,U,2),0)),U,1),1,20)
 I +$P(IBX,U,3) S IBTXT(12)=$J("",40)_" Tertiary Carrier: "_$E($P($G(^DIC(36,+$P(IBX,U,3),0)),U,1),1,20)
 S IBTXT(13)=" "
 ;
 ; - send to the Means Test billing mailgroup (for now)
 S IBGRP=$P($G(^XMB(3.8,+$P($G(^IBE(350.9,1,0)),"^",11),0)),"^")
 I IBGRP]"" S XMY("G."_IBGRP_"@"_^XMB("NETNAME"))=""
 ;
 D ^XMD
 ;
BULLQ Q
 ;
 ;
CHPSUP(DFN) ; Does the patient have a TRICARE Supplemental policy?
 ;  Input:   DFN  --  Pointer to the patient in file #2
 ; Output:   0 - Has no TRICARE Supplemental policy
 ;           1 - Yes, patient has such a policy.
 ;
 N X,IBINS,IBCS
 D ALL^IBCNS1(DFN,"IBINS",1,DT)
 S (IBCS,X)=0 F  S X=$O(IBINS(X)) Q:'X  D  Q:IBCS
 .I $D(^IBE(355.1,"D","CS",+$P($G(IBINS(X,355.3)),"^",9))) S IBCS=1
 Q IBCS
