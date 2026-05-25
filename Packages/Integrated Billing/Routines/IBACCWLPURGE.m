IBACCWLPURGE ;EDE/TAZ - ACC (Automated Community Care) Claims - Purge ; 20-MAR-2024
 ;;2.0;INTEGRATED BILLING;**770**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ;Initialize Variables
 ;Loop through "CLOSED" (2) STATUS X-ref
 ;CLAIM NUMBER (#2.02) eXISTS?
 ;  YES = REASONS NOT AUTOBILLED (#5) Exist?
 ;    Yes = Manual
 ;    No  = Auto
 ;  NO = Failed
 ;
EN ;Entry point from Option
 N DIR
 S DIR(0)="Y"
 S DIR("A")="Do you want to continue?"
 S DIR("A",1)="This will purge the Automated Community Care Encounter File"
 S DIR("A",2)=""
 S DIR("B")="N"
 D ^DIR
 I $D(DIRUT) G PURGEQ
 I 'Y G PURGEQ
 W !!,"Purging.  Please stand by."
 ;
EN1 ; Entry point from scheduled
 N CLAIM,IEN,FINALCLONE
 ;Loop though each encounter that is CLOSED
 S IEN=0
 F  S IEN=$O(^IBA(364.9,"AD",2,IEN)) Q:'IEN  D
 . S CLAIM=$$GET1^DIQ(364.9,IEN_",",2.02,"I")   ;IEN of File 399
 . I 'CLAIM D PURGE("F") Q  ;Failed to create claim
 . S FINALCLONE=$$FINDCLONES(CLAIM)  ;MJL;EBILL-6180
 . I $$ACTIVE^IBJTU4(FINALCLONE) Q  ;Claim is still active - drills down to find the last cloned version of this claim just to be safe ;MJL;EBILL-6180
 . ;I $$ACTIVE^IBJTU4(CLAIM) Q  ;Claim is still active
 . I $$GET1^DIQ(364.95,"1,"_IEN_",",.01,"I") D PURGE("M") Q  ; Billed after manual intervention
 . D PURGE("A")  ;Auto-generated claims
 Q
 ;
PURGE(TYPE) ;Purge record based on Purge Time in IB Site Parameters
 N CNT,DATE,DAYS,FIELD,IBVAR,STR
 ;
 ; S FIELD=$S(TYPE="F":277,TYPE="M":276,1:275)
 ; S DAYS=$$GET1^DIQ(350.9,"1,",FIELD)   ; Number of days to wait before purge
 S FIELD=$S(TYPE="F":"ACCFAILEDPUR",TYPE="M":"ACCMIPUR",1:"ACCAGPUR")
 S IBVAR=$$FIND1^DIC(364.991,,"X",FIELD)
 I IBVAR S DAYS=$$GET1^DIQ(364.991,IBVAR_",",.1)   ;WCJ;V42;
 Q:$G(DAYS)=""
 ;
 S DATE=$$GET1^DIQ(364.9,IEN_",",.22,"I")  ; STATUS DATE CHANGED
 I $$FMADD^XLFDT(DATE,DAYS)>DT  G PURGEQ            ; Not eligible to purge
 S CNT=0
 F  S CNT=$O(^IBA(364.9,IEN,1,CNT)) Q:'CNT  S STR=^(CNT,0) D
 . N DA,DR,DIE
 . I $P(STR,"*",1,2)="REF*D9" Q  ;Do not remove this node.
 . S DIE="^IBA(364.9,"_IEN_",1,",DA=CNT,DA(1)=IEN,DR=".01///@"
 . D ^DIE
 ;Update STATUS to PURGED
 S DIE="^IBA(364.9,",DA=IEN,DR=".16///3"
 D ^DIE
PURGEQ ;
 Q
FINDCLONES(CLAIM) ;Find all the times this claim has been cloned, so we're only looking at the most recent one  ;MJL;EBILL-6180
 N STOP,LASTCLONE,CLONEDTO
 I $$GET1^DIQ(399,CLAIM_",",29,"I")="" Q CLAIM  ;There are no clones, no need to run this loop
 S LASTCLONE=CLAIM
 S STOP=""
 F  D  Q:STOP=1
 . S CLONEDTO=$$GET1^DIQ(399,LASTCLONE_",",29,"I")
 . I CLONEDTO="" S STOP=1 Q  ;Nothing left, take the last clone and exit
 . S LASTCLONE=CLONEDTO
 Q LASTCLONE
