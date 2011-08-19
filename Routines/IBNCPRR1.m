IBNCPRR1 ;ALB/OEC - Prescription Report for 3rd Party Billing (Extrinsic Functions) ;01/11/06
 ;;2.0;INTEGRATED BILLING;**347**;21-MAR-94;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;This routine contains extrinsic function used by IBNCPRR
RXINS(IBRX,IBFL) ; Determine insurance by the RX
 Q 0
 ;
ECMENO(IBRX) ;
 Q $E(IBRX,$L(IBRX)-6,$L(IBRX))
 ;
BILLINS(IBIFN) ; Insurance from the Bill#
 I 'IBIFN Q 0
 Q +$P($G(^DGCR(399,+IBIFN,"M")),U)
 ;
DAT(X) ;Convert FM date to displayable (mm/dd/yy) format.
 N DATE,YR
 I $G(X) S YR=$E(X,2,3)
 I $G(X) S DATE=$S(X:$E(X,4,5)_"/"_$E(X,6,7)_"/"_YR,1:"")
 Q $G(DATE)
 ;
DATTIM(X) ;Convert FM date to displayable (mm/dd/yy HH:MM) format.
 N DATE,YR,IBT,IBM,IBH,IBAP
 I $G(X) S YR=$E(X,2,3)
 I $G(X) S DATE=$S(X:$E(X,4,5)_"/"_$E(X,6,7)_"/"_YR,1:"")
 S IBT=$P(X,".",2) S:$L(IBT)<4 IBT=IBT_$E("0000",1,4-$L(IBT))
 S IBH=$E(IBT,1,2),IBM=$E(IBT,3,4)
 S IBAP="a" I IBH>12 S IBH=IBH-12,IBAP="p" S:$L(IBH)<2 IBH="0"_IBH
 I IBT S:'IBH IBH=12 S DATE=DATE_" "_IBH_":"_IBM_IBAP
 Q $G(DATE)
 ;
SSN4(DFN) ;last 4 SSN
 N X
 S X=$P($G(^DPT(DFN,0)),U,9)
 Q $E(X,$L(X)-3,$L(X))
 ;
COPAY(IBRX,IBFL) ;
 N IBACT,IBCOP
 S IBACT=$S('IBFL:$P($$IBND^IBRXUTL($$FILE^IBRXUTL(IBRX,2),IBRX),U,2),1:$P($$IBNDFL^IBRXUTL($$FILE^IBRXUTL(IBRX,2),IBRX,IBFL),U))
 S IBCOP=$P($G(^IB(+IBACT,0)),U,7)
 Q $J(IBCOP,5,2)
 ;
 ; Next refill date (in not exist - DT)
NXTREFDT(IBRX,IBFL) ;
 N IBDT
 S IBDT=$P($$SUBFILE^IBRXUTL(IBRX,IBFL+1,52,.01),".")
 S:'IBDT IBDT=DT
 Q IBDT
 ;
