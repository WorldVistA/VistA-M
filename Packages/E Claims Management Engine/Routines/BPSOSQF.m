BPSOSQF ;BHAM ISC/FCS/DRS/FLS - Insurer asleep - status 31 ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,10**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ; Check for insurer asleep claims
 ;
STATUS31 ;EP - BPSOSQ2
 ; Loop through claims at 31%
 ; Reset to 30% if:
 ;   a) This is a prober and it is time to retry
 ;   b) The insurer is awake
 N IEN59,GRPLAN
 ;
 ; Make sure we can get the lock
 I '$$LOCK59^BPSOSQ2(31) Q
 ;
 ; Loop through transactions that are 31%
 S IEN59=""
 F  S IEN59=$O(^BPST("AD",31,IEN59)) Q:'IEN59  D
 . ;
 . ; Get the Group Plan for the transaction
 . S GRPLAN=+$$GETPLN59^BPSUTIL2(IEN59)
 . I GRPLAN=0 D LOG^BPSOSL(IEN59,$T(+0)_"-No Group Plan was found") Q
 . ;
 . ; If this is the prober and it is time to retry, reset the status
 . I $$PROBER(GRPLAN)=IEN59,$$RETRY(GRPLAN) D RESET(IEN59,"-Prober Transaction") Q
 . ;
 . ; If the plan is no longer asleep, reset the status
 . I '$$ISASLEEP(GRPLAN) D RESET(IEN59,"-Payer is awake")
 ;
 D UNLOCK59^BPSOSQ2(31)
 Q
 ;
RESET(IEN59,MSG) ;
 ; Procedure to set status to 30% and log a message
 ; Input:
 ;   IEN59 - BPS Transaction IEN59
 ;   PROBER - Flag indicating whether this is a prober
 I '$G(IEN59) Q
 ; Clear pointer to Asleep Payer
 N DIE,DA,DR,DTOUT
 S DIE=9002313.59,DA=IEN59,DR="801///@" D ^DIE
 ; Set status to 30%
 D SETSTAT^BPSOSU(IEN59,30)
 ; Log message
 D LOG^BPSOSL(IEN59,$T(+0)_"-Retrying Asleep Claim"_$G(MSG))
 Q
 ;
ISASLEEP(GRPLAN) ;
 ; Function to check if Payer is asleep.
 ; Input:
 ;   GRPLAN = GROUP INSURANCE PLAN file IEN
 ; Returns:
 ;   1 = Yes, payer is asleep
 ;   0 = No, payer is not asleep
 I '$G(GRPLAN) Q 0
 N BPAIEN,BPSSITE
 ;
 ; If the plan is not in the Insurer Asleep file, asleep is off
 S BPAIEN=$O(^BPS(9002313.15,"B",GRPLAN,0))
 Q:'BPAIEN 0
 ;
 ; If the plan is set to ignore, asleep is off
 I $$IGNORE(GRPLAN) Q 0
 ;
 ; Check is the site parameters have disabled sleep
 S BPSSITE=$G(^BPS(9002313.99,1,0))
 I '$P(BPSSITE,"^",5)!('$P(BPSSITE,"^",6)) Q 0
 ;
 Q 1
 ;
IGNORE(GRPLAN) ;
 ; Function to check if IGNORE ASLEEP flag set for Plan
 ; Input:
 ;   GRPLAN = Group Insurance Plan file IEN
 ; Returns:
 ;   1 = Ignore
 ;   0 = Don't Ignore
 I '$G(GRPLAN) Q 0
 N BPAIEN
 S BPAIEN=$O(^BPS(9002313.15,"B",GRPLAN,0))
 Q:'BPAIEN 0
 Q $S($P($G(^BPS(9002313.15,BPAIEN,0)),U,3)=1:1,1:0)
 ;
PROBER(GRPLAN) ;
 ; Function to return the PROBER CLAIM for an insurer
 ; Input:
 ;   GRPLAN = Group Insurance Plan file IEN
 ; Returns:
 ;   PROBER CLAIM - Pointer to BPS TRANSACTION file
 I '$G(GRPLAN) Q ""
 N BPAIEN
 S BPAIEN=$O(^BPS(9002313.15,"B",GRPLAN,0))
 Q:'BPAIEN ""
 Q $P($G(^BPS(9002313.15,BPAIEN,0)),U,4)
 ;
RETRY(GRPLAN) ;
 ; Function to return a flag indicating whether it is time to rerun the prober
 ; Input:
 ;   GRPLAN = Group Insurance Plan file IEN
 ; Returns:
 ;   RETRY = Flag indicating it is time to retry the prober
 I '$G(GRPLAN) Q 0
 N BPAIEN,RETRY
 S BPAIEN=$O(^BPS(9002313.15,"B",GRPLAN,0))
 Q:'BPAIEN 0
 S RETRY=$$GET1^DIQ(9002313.15,BPAIEN_",",.05,"I")
 I RETRY'>$$NOW^XLFDT Q 1
 Q 0
