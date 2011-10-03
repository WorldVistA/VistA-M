IBCF21 ;ALB/ARH - HCFA 1500 19-90 DATA (gather insurance, cc) ;12-JUN-93
 ;;2.0;INTEGRATED BILLING;**8,80,51**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; requires IBIFN
INS S IBFLD("11AD")=""
 F IBI=1,2,3 S IB("I"_IBI)=$G(^DGCR(399,IBIFN,("I"_IBI)))
 F IBI="I1","I2","I3" I IB(IBI)'="" S IBX=+$P(IB(IBI),U,16),IBY="IBR"_IBI,@IBY=IBX I IBX'=1,IBX'=2 D  S @IBY=IBX ;pt's rel to insured
 . I $P(IB(IBI),U,6)="v" D:'$D(VAEL) ELIG^VADPT I +VAEL(4) S IBX=1 Q  ;vet is the patient
 . I $P(IB(IBI),U,6)="s" D:'$D(VAEL) ELIG^VADPT I +VAEL(4) S IBX=2 Q  ;vet is pt, so vets spouse is pt's spouse
 . I 'IBX S IBX=9 ; else relationship of insured to patient unknown
 K VAEL
 ;
 S IBCOB=$P($G(^DGCR(399,IBIFN,0)),U,21),IBPRIM="I1",IBRIP=$G(IBRI1),IBSECD="I2",IBRIS=$G(IBRI2)
 I IBCOB="S" S IBPRIM="I2",IBRIP=$G(IBRI2),IBSECD="I1",IBRIS=$G(IBRI1)
 I IBCOB="T" S IBPRIM="I3",IBRIP=$G(IBRI3),IBSECD="I1",IBRIS=$G(IBRI1)
 ;
INS1 G INS2:IB(IBPRIM)=""!('$D(^DIC(36,+IB(IBPRIM),0)))
 F IBI=$P(IB(IBPRIM),U,2),$P(IB(IBPRIM),U,3) I IBI'="" S IBFLD("1A")=IBI Q  ;policy number
 S IBFLD(4)=$S(IBRIP=1:"SAME",1:$P(IB(IBPRIM),U,17)) ; insureds name
 S IBFLD(6)=$S('$P(IB(IBPRIM),U,16):IBRIP,1:+$P(IB(IBPRIM),U,16)) ; patient relationship to insured
 I IBRIP=1!(IBRIP=2) S IBFLD(7)="SAME" ; insured's address
 ;
 I $P(IB(IBPRIM),U,2)'="" S IBFLD(11)=$P(IB(IBPRIM),U,3) ; group number
 I IBRIP=1 S IBFLD("11AD")=IBFLD("3D"),IBFLD("11AX")=IBFLD("3X")
 I +IBRIP=1,IBFLD("8E")="E" S VAOA("A")=5 D OAD^VADPT S IBFLD("11B")=VAOA(9) K VAOA ;employer
 I +IBRIP=2 D
 . I IBFLD("3X")'="" S X="MFM",IBFLD("11AX")=$E(X,$F(X,IBFLD("3X")))
 . I IBSPE="E" S VAOA("A")=6 D OAD^VADPT S IBFLD("11B")=VAOA(9) K VAOA ;spouses employer
 S IBFLD("11C")=$P(IB(IBPRIM),U,15)
 ;
INS2 G COND:IB(IBSECD)=""!('$D(^DIC(36,+IB(IBSECD),0))) ; secondary insurance
 S IBFLD("11D")=1
 S IBFLD(9)=$P(IB(IBSECD),U,17) I IBFLD(9)'="",IBFLD(9)=$P(IB(IBPRIM),U,17) S IBFLD(9)="SAME" ;secondary insureds nam
 F IBI=$P(IB(IBSECD),U,2),$P(IB(IBSECD),U,3) I IBI'="" S IBFLD("9A")=IBI Q  ;policy number
 I +IBRIS=1 D
 . S IBFLD("9BD")=IBFLD("3D"),IBFLD("9BX")=IBFLD("3X")
 . I IBFLD("8E")="E" S VAOA("A")=5 D OAD^VADPT S IBFLD("9C")=VAOA(9) K VAOA ;employer
 I +IBRIS=2 D
 . I IBFLD("3X")'="" S X="MFM",IBFLD("9BX")=$E(X,$F(X,IBFLD("3X")))
 . I IBSPE="E" S VAOA("A")=6 D OAD^VADPT S IBFLD("9C")=VAOA(9) K VAOA ;spouses employer
 I IBFLD("9A")=$P(IB(IBSECD),U,3) S IBFLD("9D")=$P(IB(IBSECD),U,15) ;group name
 I IBFLD("9D")="" S IBFLD("9D")=$P($G(^DIC(36,+IB(IBSECD),0)),U) ;company name
 ;
COND ;condition related to employment, auto accident (place), other accident
 S IBI=0 F  S IBI=$O(^DGCR(399,IBIFN,"CC",IBI)) Q:'IBI  S X=$G(^(IBI,0)) I +X D
 . S Y=$G(^DGCR(399.1,+X,0)) Q:Y=""  I $P(Y,U,2)="02" S IBFLD("10A")=1
 S IBI=0 F  S IBI=$O(^DGCR(399,IBIFN,"OC",IBI)) Q:'IBI  S X=$G(^(IBI,0)) I +X D
 . S Y=$G(^DGCR(399.1,+X,0)) Q:Y=""
 . I $P(Y,U,9)=1 S IBFLD("10A")=1
 . I $P(Y,U,9)=2 S IBFLD("10B")=1 S X=$$STATE^IBCF2($P(X,U,3)) I X'="" S IBFLD("10BS")=X
 . I $P(Y,U,9)=3 S IBFLD("10C")=1
 . I $P(Y,U,1)="ONSET OF SYMPTOMS/ILLNESS" S IBFLD(15)=$$DATE^IBCF2($P(X,U,2),1) ; see DATES+1^IBCF22
 ;
 K IBRI1,IBRI2,IBRI3,IBCOB,IBPRIM,IBSECD,IBRIP,IBRIS
 D ^IBCF22
 Q
