BPSOSQF ;BHAM ISC/FCS/DRS/FLS - Insurer asleep - status 31 ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ; Check for insurer asleep claims
 ;
STATUS31 ;EP - BPSOSQ2
 ; Situation:  you have 1 or 2 or maybe 200 claims in status 31,
 ; because we've determined that the insurer is asleep.
 ; change at most one claim per insurer to status 30, to let it
 ; go through and try again.  But if the insurer is awake for sure,
 ; let all of the claims for that insurer go on through.
 ;
 ; Initialization
 N RETRY,PROBER,IEN59,PAYERSH,X
 S IEN59=""
 K ^TMP("BPSOSQF",$J) ; build ^TMP("BPSOSQF",$J,PAYERSH,IEN59)=""
 ;
 ; Make sure we can get the lock
 I '$$LOCK59^BPSOSQ2(31) Q
 ;
 ; Loop through transaction that are 31 per cent
 F  S IEN59=$$NEXT59^BPSOSQ2(IEN59,31) Q:'IEN59  D
 . ; if $$NEXT59() returned us an IEN59, then the waiting time
 . ; has expired or this is the Prober - or better yet, the insurer has awakened
 . ;
 . ; Get the payer sheet for the transaction
 . S PAYERSH=$$PAYERSH(IEN59)
 . I PAYERSH="" D LOG^BPSOSL(IEN59,$T(+0)_"-No payersheet was found") Q
 . ;
 . S ^TMP("BPSOSQF",$J,PAYERSH,IEN59)=""
 D UNLOCK59^BPSOSQ2(31)
 ;
 ; Loop through payer sheet and transactions and change status to 30%
 S PAYERSH="" F  S PAYERSH=$O(^TMP("BPSOSQF",$J,PAYERSH)) Q:'PAYERSH  D
 . S IEN59="" F  S IEN59=$O(^TMP("BPSOSQF",$J,PAYERSH,IEN59)) Q:'IEN59  D
 . . D SETSTAT^BPSOSU(IEN59,30) ; reset to status 30
 . . D LOG^BPSOSL(IEN59,$T(+0)_"-Retrying Asleep Claim. BPS TRANSACTION IEN: "_IEN59)
 Q
 ;
 ; Function to get the payer sheet for a given transaction
PAYERSH(IEN59) ;
 N POS
 S POS=$P($G(^BPST(IEN59,9)),U,1)
 I POS="" Q ""
 Q $$GET1^DIQ(9002313.59902,POS_","_IEN59_",",902.02,"I")
 ;
 ; Function to check if Payer is asleep. This function will remove an asleep payer if it has woken up and will queue
 ; other asleep claims if needed.
 ; Input:
 ; GRPLAN = GROUP INSURANCE PLAN file IEN
 ; Returns:
 ; 1 = Yes, payer is asleep
 ; 0 = No, payer is not asleep
ISASLEEP(GRPLAN) ;
 N PROBER,BPAIEN,BPSRETRY,IEN59,IEN77,BPQ,RETV
 S (IEN59,IEN77,BPQ,RETV)=0
 S BPAIEN=$O(^BPS(9002313.15,"B",$G(GRPLAN),0))
 Q:'BPAIEN RETV
 I $$IGNORE(GRPLAN) Q RETV
 ; Prober has completed, clear the sleeping condition
 S PROBER=$$PROBER(GRPLAN) I PROBER<1 D CLRSLEEP^BPSOSQ4(GRPLAN) Q RETV
 F  S IEN59=$O(^BPS(9002313.77,"C",IEN59)) Q:IEN59=""!BPQ  D  Q:BPQ
 . F  S IEN77=$O(^BPS(9002313.77,"C",IEN59,IEN77)) Q:IEN77=""  D  Q:BPQ
 . . I IEN77=PROBER S BPQ=1 D
 . . . I $$STATUS59^BPSOSRX(IEN59)'=99 S RETV=1 Q
 . . . D CLRSLEEP^BPSOSQ4(GRPLAN)
 ;
 Q RETV
 ;
 ; Function to check if IGNORE ASLEEP flag set for Plan
 ; Input:
 ; GRPLAN = Group Insurance Plan file IEN
 ; Returns:
 ; 1 = Ignore
 ; 0 = Don't Ignore
IGNORE(GRPLAN) ;
 N BPAIEN
 S BPAIEN=$O(^BPS(9002313.15,"B",$G(GRPLAN),0))
 Q:'BPAIEN 0
 Q $S($P($G(^BPS(9002313.15,BPAIEN,0)),U,3)=1:1,1:0)
 ;
 ; Function to return the PROBER CLAIM for an insurer
 ; Input:
 ; GRPLAN = Group Insurance Plan file IEN
 ; Returns:
 ; PROBER CLAIM - Pointer to BPS REQUESTS file
PROBER(GRPLAN) ;
 N BPAIEN
 S BPAIEN=$O(^BPS(9002313.15,"B",$G(GRPLAN),0))
 Q:'BPAIEN 0
 Q $P($G(^BPS(9002313.15,BPAIEN,0)),U,4)
 ;
