IBINUT1 ;YMG/EDE -  MEGABUS Act (Indian Self-Identification) Utilities ;NOV 23 2021
 ;;2.0;INTEGRATED BILLING;**716**;21-MAR-94;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
INDCHK(IBTO,IBDFN) ; check if bill is covered by Indian Attestation exemption
 ;
 ; IBTO - "Bill To" date (350/.15)
 ; IBDFN - patient's DFN
 ;
 ; returns 1 if bill is covered by Indian Attestation exemption, 0 otherwise
 ;
 N IBINDATA
 S IBINDATA=$$INDGET(IBDFN)
 I $P(IBINDATA,U)'="Y" Q 0 ; self-identification flag is not set
 Q $$INDCHKDT(+IBTO,+$P(IBINDATA,U,2))
 ;
INDCHKDT(IBTO,IBINSTDT) ; check if bill timeframe is covered by Indian Attestation exemption
 ;
 ; IBTO - "Bill To" date (350/.15)
 ; IBINSTDT - indian self-identification start date (2/.572)
 ;
 ; returns 1 if bill timeframe is covered by Indian Attestation exemption, 0 otherwise
 ;
 N RES
 S RES=0
 I $G(IBTO)>0,$G(IBINSTDT)>0,IBTO'<3220105,IBTO'<IBINSTDT S RES=1
 Q RES
 ;
INDGET(DFN) ; get Indian Attestation data
 ;
 ; DFN - patient's DFN
 ;
 ; returns indian self-identification flag (2/.571) ^ indian self-identification start date (2/.572)
 ;
 N RES,VADEMO
 S RES="^^"
 I +$G(DFN)>0 D DEMUPD^VADPT S $P(RES,U)=$G(VADEMO(15,1)),$P(RES,U,2)=$G(VADEMO(15,2))
 Q RES
