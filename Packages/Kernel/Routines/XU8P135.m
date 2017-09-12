XU8P135 ;SF/KLD - Post-Install for Reindexing File #200 Field #16 ;02/01/2000  09:35
 ;;8.0;KERNEL;**135**;Nov 26, 1999
 ;
 ; REINDEX
 ; This sub-routine will be used to Reindex the DIVISION field #16 of
 ; the NEW PERSON file #200.  A new index was created "AH".
 ;
 ; REMOVE
 ; This sub-routine will be used to remove bogus X-Ref introduced
 ; at test sites for this patch.
 ;
EN ;
 D REMOVE
 D REINDEX
 Q
 ;
REMOVE ;
 D DELIX^DDMOD(200,.01,7)
 D DELIX^DDMOD(200,53.5,1)
 Q
 ;
REINDEX ;
 W !,"Reindexing FILE 200, Field 16...."
 N IEN,DIK,DA,NME
 S (IEN,NME)=0
 F  S NME=$O(^VA(200,"B",NME)) Q:NME=""  D
 . F  S IEN=$O(^VA(200,"B",NME,IEN)) Q:'IEN  D
 . . I $D(^VA(200,IEN,2,0))=1 D
 . . . S DIK="^VA(200,"_IEN_",2,",DIK(1)=".01^AH",DA(1)=IEN
 . . . D ENALL^DIK
 W !,"Finished."
 Q
