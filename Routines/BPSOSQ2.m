BPSOSQ2 ;BHAM ISC/FCS/DRS/DLF - form transmission packets ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; Construct packets for transmission
 Q
 ;
PACKETS ; EP - Tasked by BPSOSQA
 ;
 ; Initialize
 N ERROR,RXILIST,STATUS
 ;
 ; First handle insurer alseep transactions
 D STATUS31^BPSOSQF
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
 N IEN59
 S IEN59=""
 I '$$LOCK59(30) Q
 ;
 ; Loop though claims at 30%, bundle with other 30% claims, and process
 F  S IEN59=$$NEXT59(IEN59,30) Q:IEN59=""  D
 . ; Intialize the list
 . K RXILIST
 . S RXILIST(IEN59)=""
 . ;
 . ; Update the status to 40 (Building the packet)
 . D SETSTAT^BPSOSU(IEN59,40)
 . ;
 . ; If reversal, only one claim per packet
 . I $G(^BPST(IEN59,4)) G POINTX
 . ;
 . ; If prior auth are entered, only one claim per packet
 . G:$$CHKPA() POINTX
 . ;
 . ; Code below is for bundling claims.  The VA is not doing this
 . ; so we are skipping it.  However, the code is left here in
 . ; case we do bundling in the future.  If so, the code will need to be
 . ; rewritten to look at the corect fields.
 . G POINTX
 . ;
 . N RA0,RA1 S RA0=^BPST(IEN59,0),RA1=^(1)
 . N IEN59 S IEN59="" ; preserve the top-level index!
 . F  S IEN59=$$NEXT59(IEN59,30) Q:'IEN59  D
 .. N RB0,RB1 S RB0=^BPST(IEN59,0),RB1=^(1)
 .. ; Only bundle when you have the same:
 .. ; Patient, Visit, Division, Division Source, Insurer, Pharmacy
 .. I $P(RA0,U,6,7)'=$P(RB0,U,6,7) Q
 .. I $P(RA1,U,4,7)'=$P(RB1,U,4,7) Q
 .. I $P(RB0,U,2)'=30 Q  ; might have been canceled, or maybe 31'd
 .. D SETSTAT^BPSOSU(IEN59,40)
 .. S RXILIST(IEN59)=""
POINTX . ; Reversals and prior auth claims branch to here to bypass multi-claim packeting
 . ;
 . ; BPSOSQG will build the claim data, create the packet, and send to HL7
 . S ERROR=$$PACKET^BPSOSQG
 . ;
 . ; If an error is returned, log the error to each transaction
 . I ERROR S IEN59="" F  S IEN59=$O(RXILIST(IEN59)) Q:IEN59=""  D
 .. D ERROR^BPSOSU($T(+0),IEN59,$P(ERROR,U),$P(ERROR,U,2,$L(ERROR,U)))
 D UNLOCK59(30)
 Q
 ;
NEXT59(IEN59,STATUS) ;EP - BPSOSQF
 N GRPLAN,PAYSH,PAYSHNM,RETRY,BPASLEEP,BPAIEN,PROBER,BPSIEN77
N59A ;
 ; Get next transaction for the given status
 S IEN59=$O(^BPST("AD",STATUS,IEN59))
 I IEN59="" Q IEN59  ; end of list, return ""
 ;
 ;
 ; Get the BPS REQUEST
 S BPSIEN77=+$P($G(^BPST(IEN59,0)),U,12)
 ;
 ; Get the GROUP INSURANCE PLAN
 S GRPLAN=$$GETPLN59^BPSUTIL2(IEN59)
 ;
 ; If the GROUP INSURANCE PLAN isn't asleep or if the IGNORE ASLEEP flag
 ; is set then return this transaction
 I '$$ISASLEEP^BPSOSQF(+$G(GRPLAN)) Q IEN59
 ;
 ; Insurer is asleep -
 S BPASLEEP=+$G(^BPST(IEN59,8))
 S BPAIEN=$O(^BPS(9002313.15,"B",+$G(GRPLAN),0))
 ; Get Retry Time
 S RETRY=$$GET1^DIQ(9002313.15,BPAIEN_",",.05,"I")
 ; If time to retry AND this is the transaction for the Prober claim
 ; return this transaction for processing
 I RETRY'>$$NOW,BPSIEN77>0,BPSIEN77=$$PROBER^BPSOSQF(+$G(GRPLAN)) Q IEN59
 ;
 ; If necessary, update the .59's record with BPS ASLEEP PAYER
 I BPASLEEP'=BPAIEN D
 . S DA=IEN59,DIE=9002313.59,DR="801////^S X=BPAIEN" D ^DIE
 . D SETSTAT^BPSOSU(IEN59,31) ; force screen update, too
 . D LOG^BPSOSL(IEN59,$T(+0)_"-Insurer asleep - Waiting for Prober Request "_$$PROBER^BPSOSQF(+$G(GRPLAN))_" to complete")
 ;
 ; If we are checking status 30, convert to insurer asleep
 I STATUS=30 D SETSTAT^BPSOSU(IEN59,31)
 ;
 ; Still asleep, go to next transaction
 G N59A
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
CHKPA() ;
 N PATYP,PANUM,PACLM
 S PACLM=0
 ;
 S PATYP=$P($G(^BPST(IEN59,1)),U,15)    ;prior auth type code
 S PANUM=$P($G(^BPST(IEN59,1)),U,9)     ;prior auth number
 I ($G(PATYP)'="")!($G(PANUM)'="") S PACLM=1
 ;
 Q PACLM
 ;
NOW() N %,%H,%I,X D NOW^%DTC Q %
