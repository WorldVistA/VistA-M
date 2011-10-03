IBCU8 ;ALB/ARH - THIRD PARTY BILLING UTILITIES (AUTOMATED BILLER) ;02 JUL 93
 ;;2.0;INTEGRATED BILLING;**137**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BCDT(DATE,TYPE) ;returns end date of bill cycle for beginning DATE and TYPE
 ;result is the billing date range, inclusive
 N X,Y,IBBC S X="" S DATE=$E($G(DATE),1,7) I DATE'?7N G BCDTE
 S IBBC=$G(^IBE(356.6,+$G(TYPE),0))
 ; I '$P(IBBC,U,4) G BCDTE
 S IBBC=$P(IBBC,U,5),X=DATE,Y=IBBC-1
 I IBBC="" S Y=$E(DATE,4,5),X=$E(DATE,1,3)+(Y\12)_$S(Y>11:"01",Y>8:Y+1,1:"0"_(Y+1))_"01",Y=-1
 S X=$$FMADD^XLFDT(X,Y) ;S Y=$$FYCY(DATE) F I=2,4 I X>$P(Y,U,I) S X=$P(Y,U,I)
BCDTE Q X
 ;
MBC(DATE,TYPE) ;returns maximum date range possible for bill cycle of DATE and TYPE
 ;result is the billing date range, inclusive
 N X,Y,I,IBBC S X="" S DATE=$E($G(DATE),1,7) I DATE'?7N G MBCE
 S IBBC=$G(^IBE(356.6,+$G(TYPE),0))
 ; I '$P(IBBC,U,4) G MBCE
 S IBBC=$P(IBBC,U,5)
 I IBBC'="" S Y=IBBC-1,X=$$FMADD^XLFDT(DATE,-Y)_"^"_$$FMADD^XLFDT(DATE,Y) G MBCE
 S Y=$E(DATE,4,5),X=$E(DATE,1,3)+(Y\12)_$S(Y>11:"01",Y>8:Y+1,1:"0"_(Y+1))_"01",Y=-1
 S X=$E(DATE,1,5)_"01^"_$$FMADD^XLFDT(X,Y)
MBCE ;check dates against bill range rules
 I +X S Y=$$STRGCHK(+X,$P(X,U,2)) I 'Y D  ;reset dates for CY and FY
 . I '$P(Y,U,3) S X="" Q
 . ;S Y=$$FYCY(DATE)
 . ;F I=1,3 I $P(Y,U,I)>$P(X,U,1) S $P(X,U,1)=$P(Y,U,I)
 . ;F I=2,4 I $P(Y,U,I)<$P(X,U,2) S $P(X,U,2)=$P(Y,U,I)
 Q X
 ;
FYCY(DATE) ;returns calandar and fiscal years for particular date
 N X,Y,Y2 S X="" S DATE=$G(DATE)\1 I DATE'?7N G FYCYE
 S (Y,Y2)=$E(DATE,1,3) I $E(DATE,4,5)>9 S Y2=Y+1
 S X=Y_"0101^"_Y_"1231^"_(Y2-1)_"1001^"_Y2_"0930"
FYCYE Q X
 ;
STRGCHK(DT1,DT2) ;genaric edit checks for STATEMENT FROM and TO dates, returns true if dates passes
 N X S X=1 S DT1=$G(DT1)\1,DT2=$G(DT2)\1 I DT1'?7N!(DT2'?7N) G STRGCHKE
 I DT1>(DT+.2359) S X="0^Can not bill for future treatment" G STRGCHKE
 I DT1>DT2 S X="0^End date can not preceed start date" G STRGCHKE
 ;I $E(DT1,2,3)'=$E(DT2,2,3) S X="0^Must be in the same calandar year^"_$E(DT1,1,3)_"1231" G STRGCHKE
 ;I $E(DT1,4,5)<10,$E(DT2,4,5)>9 S X="0^Must be in the same fiscal year^"_$E(DT1,1,3)_"0930"
STRGCHKE Q X
 ;
CMPLT(IBTRN) ;returns true if event is ready to be billed  NOT FINISHED
 N X
 N X,IBTRND S X=1 I '$G(IBTRN) G CMPLTE
 S IBTRND=$G(^IBT(356,+IBTRN,0))
 I +$P(IBTRND,U,31)>2 S X="0^Release of information not obtained" G CMPLTE
CMPLTE Q X
 ;
BILLED(IBTRN) ;returns bill IFN if Claims Tracking event is already associated with an uncancelled bill
 ;for inpatients interim with no final bill, returns last bill^last bill date, 0 otherwise
 ;based on most recent STATEMENT TO date
 N X,Y,IBIFN S X=0 I +$G(IBTRN) S IBIFN="" F  S IBIFN=$O(^IBT(356.399,"ACB",IBTRN,IBIFN)) Q:'IBIFN  D  I +X,$P(X,U,2)="" Q
 . S Y=$G(^DGCR(399,+IBIFN,0)) I $P(Y,U,13)'=7 S X=IBIFN I $P(Y,U,4)<3,($P(Y,U,6)=2!($P(Y,U,6)=3)) S X=IBIFN_U_$P($G(^DGCR(399,+IBIFN,"U")),U,2)
 Q X
