IBAMTD2 ;ALB/CPM - MOVEMENT BULLETIN PROCESSING ; 03-MAY-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
APM() ; Analyze patient movement to see if Means Test charges were effected.
 ;  Input:     DFN  --  Pointer to patient in file #2
 ;           DGPMP  --  Oth node in file #405 prior to change
 ;           DGPMA  --  Oth node in file #405 after the change
 ;  Output:      0  --  No effect on Means Test charges (no bulletin)
 ;               1  --  Means Test charges were effected (send bulletin)
 ;
 N IBADM,IBCHG,IBMVTA,IBMVTP,IBMTYP,IBPM,IBY
 S IBMTYP=$P(DGPMA,"^",2) S:'IBMTYP IBMTYP=$P(DGPMP,"^",2)
 I IBMTYP=4!(IBMTYP=5) S IBY=0 G APMQ
 S IBY=$$CHG(DFN) G:'IBY APMQ
 ;
 ; - process admissions
 I IBMTYP=1 D:DGPMA]"" SET,CHK G APMQ
 ;
 ; - process specialty transfers
 I IBMTYP=6 D  G APMQ
 .Q:IBJOB=6!(DGPMA="")  D SET,CHK
 ;
 ; - process discharges and transfers
 I IBMTYP=2!(IBMTYP=3) D:DGPMA]""  G APMQ
 .I $P(+DGPMA,".")=$P(+DGPMP,".") S IBY=0 Q
 .S IBVAL(2)=+DGPMP_"^"_+DGPMA
 ;
APMQ Q IBY
 ;
 ;
CHG(DFN) ; Were any Means Test Charges Billed for this Admission?
 ;  Input:     DFN  --  Pointer to patient in file #2
 ;  Output:      1  --  Charges have been billed for the admission
 ;               0  --  Charges have not been billed for the admission
 ;
 N IBD,IBN,IBND,IBCHG,IBNL,IBLAST,IBQ,IBX,PM
 S (IBX,IBQ)="",PM=$P(DGPMP,"^",14) S:'PM PM=+$P(DGPMA,"^",14)
 F  S IBX=$O(^IB("AFDT",DFN,IBX)) Q:'IBX!IBQ  S IBD=0 F  S IBD=$O(^IB("AFDT",DFN,IBX,IBD)) Q:'IBD  S IBND=$G(^IB(IBD,0)) I $P(IBND,"^",8)["ADMISSION",$P(IBND,"^",4)[("405:"_PM) S IBQ=1 Q
 I $G(IBD) S IBN=IBD F  S IBN=$O(^IB("AF",IBD,IBN)) Q:'IBN  S IBLAST=$$LAST^IBECEAU(+$P($G(^IB(IBN,0)),"^",9)),IBNL=$G(^IB(+IBLAST,0)) I $P($G(^IBE(350.1,+$P(IBNL,"^",3),0)),"^",5)'=2,"^1^2^3^4^8^"[("^"_$P(IBNL,"^",5)_"^") S IBCHG=1 Q
 Q +$G(IBCHG)
 ;
SET ; Set Before/Afters for the mvmt date and treating specialty
 N X S IBMVTP=+DGPMP,IBMVTA=+DGPMA
 I IBMTYP=6 S IBFTSP=$P(DGPMP,"^",9),IBFTSA=$P(DGPMA,"^",9)
 I IBMTYP=1 S X=+$O(^UTILITY("DGPM",$J,6,0)),IBFTSP=$P($G(^(X,"P")),"^",9),IBFTSA=$P($G(^("A")),"^",9)
 S IBFTSPBS=$$SECT^IBAUTL5(IBFTSP),IBFTSABS=$$SECT^IBAUTL5(IBFTSA)
 Q
 ;
CHK ; Check for changes in the movement date or treating specialty.
 I $P(IBMVTP,".")=$P(IBMVTA,"."),(IBFTSP=IBFTSA!(IBFTSPBS=IBFTSABS)) S IBY=0 Q
 I IBFTSPBS'=IBFTSABS S IBVAL(1)=IBFTSP_"^"_IBFTSPBS_"^"_IBFTSA_"^"_IBFTSABS
 I $P(IBMVTP,".")'=$P(IBMVTA,".") S IBVAL(2)=IBMVTP_"^"_IBMVTA
 Q
