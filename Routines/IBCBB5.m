IBCBB5 ;ALB/BGA - CONT OF MEDICARE EDIT CHECKS ;08/12/98
 ;;2.0;INTEGRATED BILLING;**51,137,371**;21-MAR-94;Build 57
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 D F^IBCEF("N-ADMISSION DATE","IBZADMIT",,IBIFN)
 D F^IBCEF("N-DISCHARGE DATE","IBZDISCH",,IBIFN)
 ;
 ; Occurrence Code and Dates
 ;   occ codes can not be duplicates for same dates and must have a date
 K IBXSAVE,IBXDATA D F^IBCEF("N-OCCURRENCE CODES",,,IBIFN)
 ; Returns arrays IBXSAVE("OCC",n) AND IBXSAVE("OCCS",n) =
 ;       code^start date^state^end date
 ; IBOCS=occ codes ;; IBOCSP=occ span codes
 ;
 S IBI=0 F  S IBI=$O(IBXSAVE("OCCS",IBI)) Q:'IBI  D
 . N IBOCSDT,IBOCSDT1,Z
 . S IBOCSDT=$P(IBXSAVE("OCCS",IBI),U,2),IBOCSDT1=$P(IBXSAVE("OCCS",IBI),U,3),IBOCCS=$P(IBXSAVE("OCCS",IBI),U)
 . S IBOCSP(IBOCCS,$O(IBOCSP(IBOCCS,""),-1)+1)=IBXSAVE("OCCS",IBI)
 . ; Occurrence Code End dates must be > start date and are required for OCCURANCE SPANS
 . I 'IBOCSDT1 S IBER=IBER_"IB155;" Q
 . I IBOCSDT1<IBOCSDT S IBER=IBER_"IB150;" Q
 ;
 S IBI=0 F  S IBI=$O(IBXSAVE("OCC",IBI)) Q:'IBI  D
 . N Z
 . S IBOCCD=$P(IBXSAVE("OCC",IBI),U)
 . S IBOCCD(IBOCCD,$O(IBOCCD(IBOCCD,""),-1)+1)=IBXSAVE("OCC",IBI)
 . I IBOCCD=10 S ^TMP($J,"LMD")=1
 Q:IBQUIT
 ;
 ; For type of admit = 1 or 2, at least one occ code 1-6, 10, or 11 req
 I $P(IBNDU,U,8)=1!($P(IBNDU,U,8)=2) D
 . N OK
 . S OK=0
 . F Z="01","02","03","04","05","06",10,11 I $D(IBOCCD(Z))!($D(IBOCCD(+Z))) S OK=1 Q
 . I 'OK S IBQUIT=$$IBER^IBCBB3(.IBER,133)
 K IBXDATA D F^IBCEF("N-VALUE CODES",,,IBIFN)
 S IBX=0
 F  S IBX=$O(IBXDATA(IBX)) Q:'IBX  D  Q:IBQUIT
 . I '$D(IBVALCD($P(IBXDATA(IBX),U))) S IBVALCD($P(IBXDATA(IBX),U))=$P(IBXDATA(IBX),U,2)
 . ; value code 01 must have a value>0
 . I $P(IBXDATA(IBX),U)="01",IBER'["134;",$P(IBXDATA(IBX),U,2)'>0 S IBQUIT=$$IBER^IBCBB3(.IBER,134) Q
 . ; value code 02 must have a value=0
 . I $P(IBXDATA(IBX),U)="02",IBER'["135;",+$P(IBXDATA(IBX),U,2)'=0 S IBQUIT=$$IBER^IBCBB3(.IBER,135) Q
 . ; code^amount^dollar amt flag (1=amt,0=quantity)
 . I $P(IBXDATA(IBX),U,2)="",IBER'["157;" S IBQUIT=$$IBER^IBCBB3(.IBER,157) Q
 . I '$$CHK^IBCVC($P(IBXDATA(IBX),U,4),$P(IBXDATA(IBX),U,2)),IBER'["158;" S IBQUIT=$$IBER^IBCBB3(.IBER,158) Q
 ;
 Q:IBQUIT
 ; Must have acc hr if accident is indicated on inpatient bill
 I $$INPAT^IBCEF(IBIFN,1) D
 . I $D(IBOCCD("01"))!$D(IBOCCD("02"))!$D(IBOCCD("03"))!$D(IBOCCD("04"))!$D(IBOCCD("05")) D
 .. I '$D(IBVALCD(45)),'$P($G(^DGCR(399,IBIFN,"U")),U,10) S IBQUIT=$$IBER^IBCBB3(.IBER,156)
 Q:IBQUIT
 ;
 D ^IBCBB6
 Q
