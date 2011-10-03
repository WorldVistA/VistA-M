IBCRBG2 ;ALB/ARH - RATES: BILL SOURCE EVENTS (INPT CONT) ; 01-OCT-03
 ;;2.0;INTEGRATED BILLING;**245,175,332,364,399,422**;21-MAR-94;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
INPTRSET(IBIFN,CS) ; reset Inpatient data due to bedsection Tort 03 and Other Type of Care RC v2.0
 ; (based on INPTPTF since that deals with timeframe and end of bill)
 N IBRC S IBRC=1 I +$G(CS),$E($G(^IBE(363.1,+CS,0)),1,2)'="RC" S IBRC=0
 ;
 D INPTBS(IBIFN,IBRC)
 D INPTOTH(IBIFN,IBRC)
 Q
 ;
INPTBS(IBIFN,RC) ; with output from INPTPTF^IBCRBG, reset bedsections due to changes with Tort 03 and RC
 ; - Some Specialties are changed to PRRTP bedsection (beginning with Tort 03)
 ; - Some Specialties are changed to ICU bedsection for RC only (beginning with RC v2.0)
 ; - Nursing Home Care and Observation bedsections are not billable with RC DRG (per diem) so remove DRG
 ; (based on INPTPTF since that deals with timeframe and end of bill)
 ;
 N IBDT,IBLN,IBSPCLTY,IBNLN,IBNBS,IBNDRG,IBCGTY
 ;
 S IBDT=0 F  S IBDT=$O(^TMP($J,"IBCRC-INDT",IBDT)) Q:'IBDT  D
 . S IBLN=$G(^TMP($J,"IBCRC-INDT",IBDT)) Q:'IBLN
 . S IBSPCLTY=$P(IBLN,U,6) Q:'IBSPCLTY
 . ;
 . S IBNLN=IBLN
 . S IBNBS=$$BSUPD(IBSPCLTY,IBDT,+$G(RC)) I +IBNBS S $P(IBNLN,U,2)=+IBNBS
 . S IBNDRG=$$NODRG(IBSPCLTY) I +IBNDRG S $P(IBNLN,U,4)=""
 . I 'IBNBS,'IBNDRG Q
 . S ^TMP($J,"IBCRC-INDT",IBDT)=IBNLN
 Q
 ; 
INPTOTH(IBIFN,RC) ; with output from INPTPTF^IBCRBG, reset Other type of care and Tort 03 changes
 ; - If type of care is Other then bedsection is replaced and DRG deleted (began with RC v2.0)
 ; (based on INPTPTF since that deals with timeframe and end of bill)
 ;
 N IBOT,IBOTLN,IBBS,IBDT1,IBDT2,IBDT,IBLN,IBNLN Q:'$G(RC)
 I +$G(IBIFN) S IBOT=0 F  S IBOT=$O(^DGCR(399,IBIFN,"OT",IBOT)) Q:'IBOT  D
 . S IBOTLN=$G(^DGCR(399,IBIFN,"OT",IBOT,0)) Q:'IBOTLN
 . S IBDT1=+$P(IBOTLN,U,2) Q:'IBDT1  S IBDT2=+$P(IBOTLN,U,3) Q:'IBDT2
 . I (IBDT1\1)=(IBDT2\1) S IBDT2=IBDT2+.3 ; allow for 1 day SNF stay
 . S IBBS=+IBOTLN Q:'IBOTLN
 . ;
 . S IBDT=IBDT1-.1 F  S IBDT=$O(^TMP($J,"IBCRC-INDT",IBDT)) Q:('IBDT)!(IBDT'<IBDT2)  D
 .. S IBLN=$G(^TMP($J,"IBCRC-INDT",IBDT)) Q:'IBLN
 .. I IBDT<$$RC20 Q
 .. ;
 .. S IBNLN=IBLN
 .. S $P(IBNLN,U,2)=+IBBS,$P(IBNLN,U,4)=""
 .. S ^TMP($J,"IBCRC-INDT",IBDT)=IBNLN
 Q
 ;
 ;
BSUPD(SPCLTY,DATE,RC) ; return updated bedsection name for specialty passed in (42.4 ifn)
 ; beginning with TORT 2003 some specialties were moved to new PRRTP bedsection
 ; beginning with RC v2.0 some specialties were moved to a new ICU bedsection, only applies to RC charges
 N IBX,IBY,IBZ S (IBZ,IBX)="",SPCLTY=","_+$G(SPCLTY)_",",DATE=$S(+$G(DATE):(DATE\1),1:DT)
 I DATE'<$$TORT03,",25,26,27,28,29,38,39,"[SPCLTY S IBX="PRRTP"
 I +$G(RC),DATE'<$$RC20,",12,13,16,17,63,"[SPCLTY S IBX="ICU"
 I IBX'="" S IBY=$O(^DGCR(399.1,"B",IBX,0)) I +IBY S IBZ=IBY_U_IBX
 Q IBZ
 ;
TORT03() ; return effective date of TORT 2003, date when PRRTP bedsection specialties changed
 Q 3040107
 ;
RC20() ; return effective date of RC v2.0, date when ICU bedsection specialties changed
 Q 3031219
 ;
NODRG(SPCLTY) ; return specialty ifn followed by bedsection name if the specialty should not be charged a DRG charge
 N IBX,IBS S IBX=0,IBS=","_+$G(SPCLTY)_","
 I ",80,81,96,42,43,44,45,46,64,66,67,68,69,95,100,101,102,"[IBS S IBX=+SPCLTY_"^Nursing Home Care"
 I ",18,23,24,36,41,65,94,108,"[IBS S IBX=+SPCLTY_"^Observation"
 Q IBX
