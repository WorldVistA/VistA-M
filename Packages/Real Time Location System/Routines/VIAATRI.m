VIAATRI ;ALB/CR - RTLS Triggers General Utility ;5/4/16 10:06am
 ;;1.0;RTLS;**3**;April 22, 2013;Build 20
 ;
 Q
 ; Engineering call to this routine covered by IA #6069
 ;
 ; ------- collect record changes for RTLS -------
 ; this tag is called from multiple fields in files #6914 and #6928
 ; to capture data changes as they happen, a record ID is added in
 ; file #6930 (PENDING RTLS EVENTS) for the queue process
 ;
 ; ============================================================
WC(FILE,ENTRY) ; FILE = either #6914 or #6928, ENTRY = IEN of the record
 ;
 ; All the triggered fields in files #6914 and #6928 have been added
 ; the 'NOREINDEX' flag to prevent flooding file #6930 if re-indexing
 ; of any of the M X-Refs is attempted.
 ;
 I $G(FILE)=""!($G(ENTRY)="") Q
 N DA,DATA,DIC,DO,D0,DLAYGO,IEN,FDA,MATCH,X,Y
 N DEFSITE,SITE,SITEIEN,TMSTMP
 ; don't store the same record multiple times
 S MATCH=0
 S IEN="" F  S IEN=$O(^VIAA(6930,IEN)) Q:IEN=""  D  Q:MATCH
 . S DATA=$G(^VIAA(6930,IEN,0))
 . I $P(DATA,U,2)=FILE,$P(DATA,U,3)=ENTRY S MATCH=1
 I MATCH Q
 ;
 S TMSTMP=$$NOW^XLFDT
 ; get station number for equipment or space
 I FILE=6914!(FILE=6928) S SITE=$P($G(^DIC(6910,1,0)),U,2)
 S DIC(0)="L",DLAYGO=6930,DIC="^VIAA(6930,",X=SITE
 D FILE^DICN
 S DA=+Y
 L +^VIAA(6930,DA):5 I '$T D EN^DDIOL("File is in use - try again later.","","!") Q
 S FDA(6930,DA_",",1)=FILE
 S FDA(6930,DA_",",2)=ENTRY
 S FDA(6930,DA_",",3)=TMSTMP
 D UPDATE^DIE(,"FDA")
 L -^VIAA(6930,DA)
 Q
 ;
 ; =============================================================
DEL(COUNT) ; clean up file PENDING RTLS EVENTS after transmission to Mule
 ; called from VIAAQUE after transmission of a record
 N DA,DIK
 S DIK="^VIAA(6930,"
 S DA=COUNT D ^DIK
 Q
