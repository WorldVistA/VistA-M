IBCU3 ;ALB/AAS - BILLING UTILITY ROUTINE (CONTINUED) ; 4/4/03 8:49am
 ;;2.0;INTEGRATED BILLING;**52,80,91,106,51,137,211,245,348,399,400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;MAP TO DGCRU3
SC(DFN) ; returns 1 if service connection indicated, 0 otherwise (based on VAEL(3))
 N X,VAEL,VAERR S X=0
 I +$G(DFN) D ELIG^VADPT S X=+$G(VAEL(3))
 Q X
 ;
APPT(DATE,DFN,DISP) ;Check date to see if patient has any visit data
 ;input:   DATE - required, date to check for appointments
 ;         DFN  - required, patient to check for appointments on date
 ;         DISP - if true then error message will be printed before exit, if any
 ;returns: 1 - if appt visit found
 ;         2 - if unscheduled add/edit clinic stop entry found
 ;         3 - if only disposition found
 ;         "0^error message" if no valid visit data/disposition found
 ;
 N Y,X,X1,X2 S DATE=$P(DATE,".",1),Y="0^* Patient has no Visits for this date..."
 I 'DATE!'$D(^DPT(DFN,0)) S Y="0^Unable to check for appointments on this date!" G APPTE
 N IBVAL,IBCBK,IBVTYP
 S IBVAL("DFN")=DFN,IBVAL("BDT")=DATE,IBVAL("EDT")=DATE+.9
 S IBCBK="I '$P(Y0,U,6) S IBVTYP=+$P(Y0,U,8) I $S(IBVTYP=2:1,IBVTYP=1:$$APPTCT^IBEFUNC(Y0),IBVTYP=3:$$DISCT^IBEFUNC(Y,Y0),1:0) S IBVTYP(IBVTYP)="""" S:$D(IBVTYP(1)) SDSTOP=1"
 D SCAN^IBSDU("PATIENT/DATE",.IBVAL,"",IBCBK,1) K ^TMP("DIERR",$J)
 S IBVTYP=$O(IBVTYP(0))
 S:IBVTYP Y=IBVTYP
 ;
APPTE I +$G(DISP),'Y W !,?10,*7,$P(Y,U,2)
 Q Y
 ;
BDT(DFN,DATE) ; returns primary bill defined for an event date, "" if none
 N X,Y S X="" I '$O(^DGCR(399,"C",+$G(DFN),0))!'$G(DATE) G BDTE
 S Y="",DATE=9999999-DATE F  S Y=$O(^DGCR(399,"APDT",+DFN,Y)) Q:'Y  D
 . I $O(^DGCR(399,"APDT",+DFN,Y,0))=DATE,'$P($G(^DGCR(399,Y,"S")),U,16) S X=$P($G(^DGCR(399,Y,0)),U,17) Q
BDTE Q X
 ;
BILLED(PTF) ;returns bill "IFN^^rate group" if PTF record is already associated with an uncancelled final bill
 ;returns "bill IFN ^ bill date (stm to) ^ bill rate group" if inpatients interim with no final bill, 0 otherwise
 N IFN,Y,X S Y=0 I '$D(^DGCR(399,"APTF",+$G(PTF))) G BILLEDQ
 S IFN=0 F  S IFN=$O(^DGCR(399,"APTF",PTF,IFN)) Q:'IFN  D  I +Y,'$P(Y,U,2) Q
 . S X=$G(^DGCR(399,IFN,0)) I $P(X,U,13)=7 Q  ; bill cancelled
 . S Y=IFN_"^^"_$P(X,U,7) I $P(X,U,6)=2!($P(X,U,6)=3) S Y=IFN_"^"_$P($G(^DGCR(399,IFN,"U")),U,2)_"^"_$P(X,U,7)
BILLEDQ Q Y
 ;
FTN(FT) ;returns name of the form type passed in, "" if not defined
 N X S X=$P($G(^IBE(353,+$G(FT),0)),U,1)
 Q X
 ;
FT(IFN,IBRESET) ;return the correct form type for a bill (trigger code in 399 to set .19)
 ; if IBRESET is not a positive value ('IBRESET), returns the bills current form type (if defined)
 ; if IBRESET is a positive value (+IBRESET), interpret form type according to following rules (for triggers):
 ;    first use if bill is inst (UB) or prof (1500) (399,.27), then current (399,.19), then UB
 N X,Y,FTC,FTT
 S X="",IFN=+$G(IFN),Y=$G(^DGCR(399,IFN,0))
 S FTC=$P(Y,U,19) I FTC=1 S FTC=3
 I '$G(IBRESET),+FTC S X=FTC G FTQ
 S FTT=$S($P(Y,U,27)=1:3,$P(Y,U,27)=2:2,1:"")
 S X=$S(+FTT:FTT,+FTC:FTC,1:3)
FTQ Q X
 ;
FNT(FTN) ;returns the ifn of the form type name passed in, must be exact match, 0 if none found
 N X,Y S X=0 I $G(FTN)'="" S X=$O(^IBE(353,"B",FTN,0))
 Q X
 ;
BILLDEV(IFN,PRT) ;returns the default device for a bill's form type, if PRT is passed as true then returns the AR follow up device, otherwise the billing device
 N X,Y S X=0 I $D(^DGCR(399,+$G(IFN),0)) S PRT=$S(+$G(PRT):3,1:2),Y=$$FT(IFN),X=$P($G(^IBE(353,+Y,0)),U,PRT)
 Q X
 ;
RXDUP(RX,DATE,IFN,DISP,DFN,RTG) ;returns bill ifn if rx # exists on another bill
 ;input:  rx # - required, rx # to check for
 ;        date - required, date of refill
 ;ifn, dfn, rtg are optional - if not passed then not used to specify rx
 ;(if ifn not passed then returns true if on any bill same or dfn and rtgetc.)
 ;if ifn passed the dfn and rtg do not need to be
 N X,LN,RIFN,BIFN,RLN,BLN S (RIFN,X)=0,DATE=$G(DATE),RX=$G(RX),IFN=$G(IFN) I RX=""!('DATE) G RXDUPE
 S LN=$G(^DGCR(399,+IFN,0)),DFN=$S(+$G(DFN):DFN,1:+$P(LN,U,2)),RTG=$S(+$G(RTG):RTG,1:+$P(LN,U,7))
 F  S RIFN=$O(^IBA(362.4,"B",RX,RIFN)) Q:'RIFN  S RLN=$G(^IBA(362.4,+RIFN,0)) I +DATE=+$P(RLN,U,3) D  Q:+X
 . S BIFN=+$P(RLN,U,2),BLN=$G(^DGCR(399,BIFN,0)) Q:(BLN="")!(BIFN=+$G(IFN))
 . I $P(BLN,U,13)=7 Q  ; bill cancelled
 . I +DFN,$P(BLN,U,2)'=DFN Q  ; different patient
 . I +RTG,+RTG'=$P(BLN,U,7) Q  ; different rate group
 . S X=BIFN_"^A "_$P($G(^DGCR(399.3,+$P(BLN,U,7),0)),U,1)_" bill ("_$P(BLN,U,1)_") exists for Rx # "_RX_" and refill date "_$$DAT1^IBOUTL(DATE)_"."
RXDUPE I +$G(DISP),+X W !,?10,$P(X,U,2)
 Q X
 ;
BCOB(IBIFN,IBCOB) ; returns an array of all bills related COB to the bill passed in
 ; includes prior bills defined on this bill then checks the Primary, Secondary and Tertiary Bills and adds
 ; all the prior bills defined on them
 ; ARR(BILL SEQUENCE (1,2,3), INSURANCE CO, BILL #)=""
 ;
 N IBM1,IBI,IBIFN1,IBM,IBM11,IBSEQ,IBSEQN,IBJ K IBCOB
 S IBM1=$G(^DGCR(399,IBIFN,"M1"))
 F IBI=IBIFN,+$P(IBM1,U,5),+$P(IBM1,U,6),+$P(IBM1,U,7) I +IBI S IBIFN1=+IBI D
 . ;
 . S IBM=$G(^DGCR(399,IBIFN1,"M")),IBM11=$G(^DGCR(399,IBIFN1,"M1")) I IBIFN=IBIFN1,'$P(IBM,U,2),'$P(IBM,U,3) Q
 . S IBSEQ=$P($G(^DGCR(399,IBIFN1,0)),U,21),IBSEQN=$S(IBSEQ="P":1,IBSEQ="S":2,IBSEQ="T":3,1:"") Q:'IBSEQN
 . ;
 . F IBJ=1:1:3 I +$P(IBM,U,IBJ) S IBCOB(IBJ,+$P(IBM,U,IBJ),+$P(IBM11,U,(IBJ+4)))=""
 . I +$P(IBM,U,IBSEQN) S IBCOB(IBSEQN,$P(IBM,U,IBSEQN),+IBIFN1)=""
 ;
 S IBI=0 F  S IBI=$O(IBCOB(IBI)) Q:'IBI  S IBJ=0 F  S IBJ=$O(IBCOB(IBI,IBJ)) Q:'IBJ  I +$O(IBCOB(IBI,IBJ,0)) K IBCOB(IBI,IBJ,0)
 Q
 ;
BINS(IBIFN) ; return list of billable insurance carriers on a bill (COB)
 ; output:  sequence:carrier:policy ^ sequence:carrier:policy ^ sequence:carrier:policy
 N IBM0,IBI,IBS,IBC,IBP,IBX S IBI=0,IBX="",IBM0=$G(^DGCR(399,+$G(IBIFN),"M"))
 F IBS="P","S","T" S IBI=IBI+1,IBC=+$P(IBM0,U,IBI) I +IBC D
 . S IBP=+$P(IBM0,U,(11+IBI)) I $P($G(^DIC(36,+IBC,0)),U,2)'="N" S IBX=IBX_IBS_":"_IBC_":"_IBP_U
 Q IBX
 ;
BOTHER(IBIFN,IBDT) ; return Bedsection of Type of Care if date is Other Type of care, based on "OT" multiple
 ; Other care is not inpatient or outpatient, SNF and Sub-Acute became distinct with RC v2.0
 ; as with all other bedsection movements, the last date is not included since that is the date they left
 N IBX,IBY,IBFND S IBFND=0,IBDT=$G(IBDT)\1
 I +$G(IBIFN),+IBDT S IBX=0 F  S IBX=$O(^DGCR(399,IBIFN,"OT",IBX)) Q:'IBX  D
 . S IBY=$G(^DGCR(399,IBIFN,"OT",IBX,0)) Q:'IBY
 . I IBDT'<$P(IBY,U,2),IBDT<$P(IBY,U,3) S IBFND=+IBY
 . I IBDT=($P(IBY,U,2)\1),IBDT=($P(IBY,U,3)\1) S IBFND=+IBY ; 1 day SNF stay
 Q IBFND
