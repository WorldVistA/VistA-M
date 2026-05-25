IB2P796 ;BAH/MBS - Claims Tracking IB 796 Post Filing Routine ; Nov 14, 2024@14:12
 ;;2.0;INTEGRATED BILLING;**796**;21-MAR-94;Build 34
 ;
 Q
POST ; Post-Install Logic
 ;Run data migration for the CLAIMS TRACKING (#356) file
 D CMTMIG
 Q
CMTMIG ; Migrate claims tracking comments to new multiple
 N CMT,IBFDA,IEN,PMAN
 S PMAN=.5
 S IEN=0 F  S IEN=$O(^IBT(356,IEN)) Q:'+IEN  D
 .;If record has an existing comment and additional comments entries do NOT already exist, create move comment to additional comments
 .S CMT=$P($G(^IBT(356,IEN,1)),U,8) I CMT]"",'+$O(^IBT(356,IEN,4,0)) D
 ..S IBFDA(356.04,"+1,"_IEN_",",.01)=DT,IBFDA(356.04,"+1,"_IEN_",",.02)=PMAN,IBFDA(356.04,"+1,"_IEN_",",1)=CMT
 ..D UPDATE^DIE(,"IBFDA")
 Q
 ;
CMTRB ;CMT RollBack
 ;Rollback of the comment migration done in CMTMIG during the post install.
 ;Removes File 356 Field 4 (Multiple File 356.04) and the associated data.
 N DIU
 S DIU=356.04,DIU(0)="SD" D EN^DIU2
 Q
