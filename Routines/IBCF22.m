IBCF22 ;ALB/ARH - HCFA 1500 19-90 DATA (gather other data) ;12-JUN-93
 ;;2.0;INTEGRATED BILLING;**52,80,122,51,210**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; requires DFN, IBIFN, IB(0)
 F IBI="C","U","U1","U2","UF2" S IB(IBI)=$G(^DGCR(399,IBIFN,IBI))
 S IBFLD(12)="PUBLIC LAW 99-272/SECTION 1729 TITLE 38"
 S IBFLD(13)="PUBLIC LAW 99-272"
DATES S IBFLD(14)=$$DATE($$EVENT(IBIFN))
 I $G(IBFLD(15))="",IBIFN'=$P(IB(0),U,17) S IBFLD(15)=$$DATE($P($G(^DGCR(399,+$P(IB(0),U,17),0)),U,3))
 S IBFLD("16A")=$$DATE($P(IB("U"),U,16)),IBFLD("16B")=$$DATE($P(IB("U"),U,17))
 S:$$NEEDMRA^IBEFUNC(IBIFN) IBFLD(17)="Dept. Of Veterans Affairs"
 I $P(IB(0),U,5)<3 S IBFLD("18A")=$$DATE($P(IB("U"),U,1)),IBFLD("18B")=$$DATE($P(IB("U"),U,2))
 I $P(IB(0),U,5)>2 S VAINDT=$P(IB(0),U,3) D INP^VADPT I +VAIN(1) D
 . S IBFLD("18A")=$$DATE(VAIN(7)),IBFLD("18B")=$$DATE(+$G(^DGPM(+$P($G(^DGPM(+VAIN(1),0)),U,17),0)))
 K VAINDT,VAIN
 S IBFLD(19)="THE UNDERSIGNED CERTIFIES TREATMENT IS NOT FOR A SERVICE-CONNECTED CONDITION"
 S IBFLD(20)=0
 ;
DX ;S X=14 F IBI="21A","21B","21C","21D" S IBFLD(IBI)=$P($G(^ICD9(+$P(IB("C"),U,X),0)),U,1),X=X+1
 ;F IBI="21A","21B","21C","21D" S IBFLD(IBI)=""
 ;N IBINDXX D SET^IBCSC4D(IBIFN,"",.IBINDXX) S X=0,Y="21@" D
 ;. F  S X=$O(IBINDXX(X)) Q:'X  S Y=$O(IBFLD(Y)) Q:+Y'=21  S IBFLD(Y)=$P($G(^ICD9(+IBINDXX(X),0)),U,1)
 ;
 N IBDXX,IBPOX
 D SET^IBCSC4D(IBIFN,.IBDXX,.IBPOX)
 S X=0 F IBI=1:1:4 S IBFLD(21,IBI)="" I IBI'>$P(IBPOX,U,2) D
 . S X=$O(IBPOX(X)) Q:X=""
 . S IBFLD(21,IBI)=$P($$ICD9^IBACSV(+IBPOX(X)),U)
 . S IBDXI(+$G(IBDXX(+IBPOX(X))))=IBI
 ;
 S IBFLD(23)=$P(IB("U"),U,13)
 ;
 D ^IBCF23 ; block 24
 ;
 S IBFLD(25)=$P($G(^IBE(350.9,1,1)),U,5)
 S IBFLD(26)=$$BN1^PRCAFN(IBIFN)
 S IBFLD(28)=+IB("U1")
 S IBFLD(29)=+$P(IB("U1"),U,2)
 S IBFLD(30)=IBFLD(28)-IBFLD(29)
LAST3 S IBFLD(31)=$G(^DGCR(399,IBIFN,"UF2")) ;assuming there are 3 available lines
 S X=+$P($G(^IBE(350.9,1,0)),U,2),Y=$G(^DIC(4,X,0)),IBI=1 I Y'="" D
 . S IBFLD(32,1)=$P(Y,U,1),IBX=+$P(Y,U,2),Y=$G(^DIC(4,X,1))
 . S IBFLD(32,2)=$P(Y,U,1) I $P(Y,U,2)'="" S IBFLD(32,2)=IBFLD(32,2)_", "_$P(Y,U,2)
 . S IBFLD(32,3)=$P(Y,U,3),IBFLD(32,"X")=$$STATE^IBCF2(IBX)_" "_$P(Y,U,4)
 S X=$G(^IBE(350.9,1,2))
 S IBFLD(33,1)=$P(X,U,1),IBFLD(33,2)=$P(X,U,2)
 S IBFLD(33,3)=$P(X,U,3),IBFLD(33,"X")=$$STATE^IBCF2($P(X,U,4))_" "_$P(X,U,5)
 S IBFLD(33,4)=$P(X,U,6)
 ;
END Q
 ;
EVENT(IBIFN,IBXSAVE,IBERR,IBD) ; The event date for box 14 on the
 ;   HCFA 1500
 ; IBIFN = bill ien
 ; IBXSAVE = the array returned by the output formatter for data element
 ;          N-OCCURRENCE CODES
 ; Returns IBERR=1 if passed by reference meaning more than one condition
 ;         has been found
 ; IBD("LMP"), IBD("ACC"), IBD("ONS"), IBD("EVT") returned with
 ;           Last menstrual period date, accident date, date of onset,
 ;           event date if IBD passed by reference
 ; Function returns the appropriate date
 ;
 N Z,Z0,IBX,IBF,A
 ;
 ; Default if no applicable occurrence codes found is event date on bill
 S IBX=$P($G(^DGCR(399,IBIFN,0)),U,3),IBF=0 S IBD("EVT")=IBX
 ;
 I '$D(IBXSAVE("OCC")) D F^IBCEF("N-OCCURRENCE CODES",,,IBIFN)
 S Z=0 F  S Z=$O(IBXSAVE("OCC",Z)) Q:'Z  S Z0(+IBXSAVE("OCC",Z))=$P(IBXSAVE("OCC",Z),U,2)
 I $O(Z0(5.99),-1) D
 . S A=$O(Z0(5.99),-1),IBF=IBF+1 ;Accident codes 1-5
 . S IBD("ACC")=Z0(A) S:IBF'>1 IBX=Z0(A)
 I $D(Z0(10)) S IBF=IBF+1,IBD("LMP")=IBX S:IBF'>1 IBX=Z0(10) ;Last Menstrual period
 I $D(Z0(11)) S (IBD("ONS"),IBX)=Z0(11),IBF=IBF+1 ;Onset of Illness
 ;
 S IBERR=(IBF>1)
 Q IBX
 ;
DATE(X) ; format date(X) as MM DD YYYY
 Q $$DATE^IBCF2(X,1)
 ;
