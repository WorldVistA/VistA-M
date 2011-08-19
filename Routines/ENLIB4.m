ENLIB4 ;(WASH IRMFO)/DH-Package Utilities (Facility Equip) ;9.29.98
 ;;7.0;ENGINEERING;**55**;Aug 17,1993
 ;
ADDUS ;  Maintain the utility system field down the parent/child hierarchy
 ;  Called at set of field #82 in file #6914
 ;  Uses recursion to climb up and down the "AE" x-ref
 ;  Will not maintain local x-refs on field #82
 N COUNT,PARNT,PRECRSR
 S COUNT=0,PRECRSR="" I $O(^ENG(6914,"AE",DA,0)) D ADRCRSN(DA,PRECRSR)
 I COUNT D EN^DDIOL(COUNT_" subsidiary records were set.") I $D(DJJ(21)) H 5 ; causes the old eng dj screen handler to pause
 Q
 ;
ADRCRSN(PARNT,PRECRSR) ;  navigate the "AE" x-ref
 N CHILD
 S CHILD=0 F  S CHILD=$O(^ENG(6914,"AE",PARNT,CHILD)) Q:'CHILD  D
 . Q:","_PRECRSR_PARNT_","[(","_CHILD_",")  ; avoid the endless loop
 . S $P(^ENG(6914,CHILD,9),U,12)=X,COUNT=COUNT+1
 . ;  if child has children then keep digging
 . I $O(^ENG(6914,"AE",CHILD,0)) D ADRCRSN(CHILD,PRECRSR_PARNT_",")
 Q
 ;
KILLUS ;  Maintain the utility system field down the parent/child hierarchy
 ;  Called at kill
 N PARNT,PRECRSR
 S PRECRSR="" I $O(^ENG(6914,"AE",DA,0)) D KLRCRSN(DA,PRECRSR)
 Q
 ;
KLRCRSN(PARNT,PRECRSR) ;  navigate the "AE" x-ref, deleting utility systems field of all the children
 N CHILD
 S CHILD=0 F  S CHILD=$O(^ENG(6914,"AE",PARNT,CHILD)) Q:'CHILD  D
 . Q:","_PRECRSR_PARNT_","[(","_CHILD_",")  ; avoid the endless loop
 . S $P(^ENG(6914,CHILD,9),U,12)=""
 . ;  if child has children then keep digging
 . I $O(^ENG(6914,"AE",CHILD,0)) D KLRCRSN(CHILD,PRECRSR_PARNT_",")
 Q
 ;
EDITY2 ; called upon edit of Y2K category, restricts screen edits
 Q:$P($G(DJJ(25)),U,3)'=71  ; quit if not screen edit
 I $G(V(25))="","FC^NA"[X Q  ; for screen edit to work, existing entry must be null and selected entry must be NA or FC
 D EN^DDIOL("You must use the Y2K module for this edit.")
 S X=$$GET1^DIQ(6914,DA,71,"I") H 5
 Q
 ;ENLIB4
