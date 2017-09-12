PSO7P421 ;ALB/EWL - Patch 421 Post Install routine ;02/04/2013
 ;;7.0;OUTPATIENT PHARMACY;**421**;DEC 1997;Build 15
 ;
 ;   ICR   Type          Description
 ; -----   ----------    ---------------
 ; 10013   Supported  -  ^DIK
 ; 10141   Supported  -  XPDUTL
 Q
 ;
POST ;post-install functions are coded here.
 ; 10141   Supported  -  XPDUTL
 D BMES^XPDUTL("  Starting post-install of PSO*7*421")
 D DELAA ; delete ALLOW ALL REJECTS & any 79/88 reject codes from file 52.86
 D BMES^XPDUTL("  Finished post-install of PSO*7*421")
 Q
 ;
DELAA ; This updates the 52.86 file - EPHARMACY SITE PARAMETERS
 ; It will delete ALLOW ALL REJECTS & any 79/88 reject codes
 ;
 ; Delete the ALLOW ALL REJECTS data first
 ; Loop through all entries and delete data from node 0 piece 2
 N IEN,RCIEN,DA,DIK S IEN=0
 F  S IEN=$O(^PS(52.86,IEN)) Q:'IEN  D
 . ;
 . ; Delete any data in node 0 piece 2 as it is no longer used
 . S $P(^PS(52.86,IEN,0),U,2)=""
 . ;
 . ; delete any Transfer Reject codes with a value of 79
 . I $D(^PS(52.86,IEN,1,"B",79)) D
 . . S RCIEN=0
 . . F  S RCIEN=$O(^PS(52.86,IEN,1,"B",79,RCIEN)) Q:'RCIEN  D
 . . . K DA,DIK S DA=RCIEN,DA(1)=IEN,DIK="^PS(52.86,"_IEN_",1," D ^DIK
 . ; 
 . ; delete any Transfer Reject codes with a value of 88
 . I $D(^PS(52.86,IEN,1,"B",88)) D
 . . S RCIEN=0
 . . F  S RCIEN=$O(^PS(52.86,IEN,1,"B",88,RCIEN)) Q:'RCIEN  D
 . . . K DA,DIK S DA=RCIEN,DA(1)=IEN,DIK="^PS(52.86,"_IEN_",1," D ^DIK
 ;
 ; Once the ALLOW ALL REJECTS data is deleted, 
 ; Delete the ALLOW ALL REJECTS field from the dictionary
 ; 10013   Supported  -  ^DIK
 S DIK="^DD(52.86,",DA=1,DA(1)=52.86 D ^DIK
 ; 10141   Supported  -  XPDUTL
 ; Send a message confirming the field deletion
 D MES^XPDUTL("ALLOW ALL REJECT field (#1) has been deleted from")
 D MES^XPDUTL("the EPHARMACY SITE PARAMETERS file (52.86)")
 Q
