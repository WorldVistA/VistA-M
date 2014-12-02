LR430PST ;Post-init Routine for LR*5.2*430 ; 2/18/04 9:29am
 ;;5.2;LAB SERVICE;**430**;Dec 30, 1994;Build 2
 ;
PRE ; initiate pre-init process
 Q
 ;
POST ; initiate post-init process
 ;
 D 768005
 ;
 D EN^DDIOL("Post-init routine for patch LR*5.2*430 completed.",,"!!!!")
 ;
 Q
 ;
768005 ; Check Howdy Site file (#69.86) for collection type to exclude of "IC"
 ; If found, replace with "I"
 ;
 N LRHYSITE,LRHYSQ,LRHYTYPE,LRTYPEIC
 S LRTYPEI="I"
 S LRHYSITE=""
 F  S LRHYSITE=$O(^LRHY(69.86,LRHYSITE)) Q:LRHYSITE=""  Q:LRHYSITE'?.N  D
 . S LRHYSEQ=0
 . F  S LRHYSEQ=$O(^LRHY(69.86,LRHYSITE,8,LRHYSEQ)) Q:LRHYSEQ=""  Q:LRHYSEQ'?.N  D
 . . S LRHYTYPE=$G(^LRHY(69.86,LRHYSITE,8,LRHYSEQ,0)) Q:LRHYTYPE=""
 . . ;
 . . I LRHYTYPE="IC" D
 . . . S DA=LRHYSEQ,DA(1)=LRHYSITE,DIK="^LRHY(69.86,"_DA(1)_",8,"
 . . . D ^DIK
 . . . K DA,DIK
 . . . ;
 . . . S DA=LRHYSEQ,DA(1)=LRHYSITE,DIC="^LRHY(69.86,"_DA(1)_",8,",X=LRTYPEI,DIC(0)=""
 . . . D FILE^DICN
 . . . K DA,DIC
 ;
 Q
 ;
