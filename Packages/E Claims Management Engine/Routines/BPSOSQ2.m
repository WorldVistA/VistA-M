BPSOSQ2 ;BHAM ISC/FCS/DRS/DLF - form transmission packets ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,10**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; Construct packets for transmission
 Q
 ;
PACKETS ; EP - Tasked by BPSOSQA
 ;
 ; First handle insurer alseep transactions
 I $D(^BPST("AD",31)) D STATUS31^BPSOSQF
 ;
 ; Handle claims that need the packet to be built
 I $D(^BPST("AD",30)) D STATUS30
 ;
 ; If there are still any claims with status 30 (perhaps due to failed
 ;   LOCK59), queue up BPSOSQ2 to run again
 I $O(^BPST("AD",30,0)) H 60 D TASK^BPSOSQA
 Q
 ;
 ; Walk through claims at 30%, bundle, and create the claim
STATUS30 ;
 N IEN59,ERROR,TRANLIST
 S IEN59=""
 I '$$LOCK59(30) Q
 ;
 ; Loop though claims at 30%, bundle with other 30% claims, and process
 F  S IEN59=$$NEXT59(IEN59) Q:IEN59=""  D
 . ; Intialize the list
 . K TRANLIST
 . S TRANLIST(IEN59)=""
 . ;
 . ; Update the status to 40 (Building the packet)
 . D SETSTAT^BPSOSU(IEN59,40)
 . ;
 . ; If the VA implements bundling in the future, then init BUNDLE variable to be 1 here
 . N BUNDLE
 . S BUNDLE=0
 . ;
 . ; If reversal, only one claim per transmission
 . I $G(^BPST(IEN59,4)) S BUNDLE=0
 . ;
 . ; Bundling only valid for billing requests, not eligibility or reversals
 . I $P($G(^BPST(IEN59,0)),U,15)'="C" S BUNDLE=0
 . ;
 . ; If prior auth are entered, only one claim per transmission
 . I $$CHKPA() S BUNDLE=0
 . ;
 . I $G(BUNDLE) D BUNDLE
 . ;
 . ; BPSOSQG will build the claim data, create the packet, and send to HL7
 . S ERROR=$$PACKET^BPSOSQG
 . ;
 . ; If an error is returned, log the error to each transaction
 . I ERROR S IEN59="" F  S IEN59=$O(TRANLIST(IEN59)) Q:IEN59=""  D
 .. D ERROR^BPSOSU($T(+0),IEN59,$P(ERROR,U),$P(ERROR,U,2,$L(ERROR,U)))
 D UNLOCK59(30)
 Q
 ;
NEXT59(IEN59) ;EP - BPSOSQF
 N GRPLAN,BPSIEN15
N59A ;
 ; Get next transaction at 30%
 S IEN59=$O(^BPST("AD",30,IEN59))
 I IEN59="" Q IEN59  ; end of list, return ""
 ;
 ; Get the GROUP INSURANCE PLAN
 S GRPLAN=+$$GETPLN59^BPSUTIL2(IEN59)
 ;
 ; If the GROUP INSURANCE PLAN isn't asleep or if the IGNORE ASLEEP flag
 ;   is set, then return this transaction
 I '$$ISASLEEP^BPSOSQF(GRPLAN) Q IEN59
 ;
 ; If this is the prober and it is time to retry, then return the transaction
 I $$PROBER^BPSOSQF(GRPLAN)=IEN59,$$RETRY^BPSOSQF(GRPLAN) Q IEN59
 ;
 ; For anything else, we need to turn on insurer asleep
 S BPSIEN15=$O(^BPS(9002313.15,"B",+$G(GRPLAN),0))
 D SETSLEEP^BPSOSQ4(IEN59,BPSIEN15,$T(+0)_"-Insurer asleep - Waiting for Prober Transaction "_$$PROBER^BPSOSQF(+$G(GRPLAN))_" to complete")
 ;
 ; Get next transaction
 G N59A
 ;
BUNDLE ; This code is for bundling claims.  The VA is not doing bundling, but this 
 ; code is being left in place in case we do bundling in the future.  If so, the
 ; code will need to be rewritten to look at the correct fields.
 ;
 Q    ;  no bundling for now
 ;
 ; Code below is original IHS code, which is based on NCPCP version 3x.
 ; Going forward, the Transmission Header, Patient, and Insurance segments
 ; would need to be the same for all bundled claims.  So, we would need:
 ;   Same Pharmacy Plan (which we get the BIN, PCN, Software Cert ID)
 ;   Same Pharmacy NPI (same division for all Rx's)
 ;   Same DOS for all Rx's
 ;   Same Patient
 ;   Same Insurance/Cardholder
 ;   Make sure the transaction is a billing request (not reversal/eligibility)
 N RA0,RA1 S RA0=^BPST(IEN59,0),RA1=^(1)
 N IEN59 S IEN59="" ; preserve the top-level index!
 F  S IEN59=$$NEXT59(IEN59,30) Q:'IEN59  D
 . N RB0,RB1 S RB0=^BPST(IEN59,0),RB1=^(1)
 . ; Only bundle when you have the same:
 . ; Patient, Visit, Division, Division Source, Insurer, Pharmacy
 . I $P(RA0,U,6,7)'=$P(RB0,U,6,7) Q
 . I $P(RA1,U,4,7)'=$P(RB1,U,4,7) Q
 . I $P(RB0,U,2)'=30 Q  ; might have been canceled, or maybe 31'd
 . D SETSTAT^BPSOSU(IEN59,40)
 . S TRANLIST(IEN59)=""
 . Q
 ;
BUNDLEX ;
 Q
 ;
 ;
LOCK59(STATUS) ;EP - BPSOSQF
 L +^BPST("AD",STATUS):60
 Q $T
 ;
UNLOCK59(STATUS) ;EP - BPSOSQF
 L -^BPST("AD",STATUS)
 Q
 ;
 ; IHS code, slightly modified for VA.  We will need to look
 ;  at this if we start bundling claims.
 ; Since the prior auth type and number are in the claim segment,
 ;  which is at the transmission level, this check may not longer 
 ;  be valid.  This code was originally for NCPCP version 3x and
 ;  may no longer be valid for NCPCP version D0.
 ; If this is valid, it would seem that the same logic would
 ;  need to be added to the BUNDLE procedure above so we don't add a 
 ;  BPS Transaction to the bundle if it has a prior auth type or number.
CHKPA() ;
 N PATYP,PANUM,PACLM
 S PACLM=0
 ;
 S PATYP=$P($G(^BPST(IEN59,1)),U,15)    ;prior auth type code
 S PANUM=$P($G(^BPST(IEN59,1)),U,9)     ;prior auth number
 I ($G(PATYP)'="")!($G(PANUM)'="") S PACLM=1
 ;
 Q PACLM
