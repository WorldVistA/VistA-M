OOPSXP5 ;WCIOFO/LLH - INIT ROUTINE FOR VISN 2 INTEGRATION; 09/20/99
 ;;1.0;ASISTS;**5**;Jun 01, 1998
 ;
 ;  This is the Pre-Init for OOPS*1*5
 ;  It will be used to populate blank STATION NUMBER fields in 
 ;  ^OOPS(2260 file.
 ;
PRE ; Pre-Init to Convert Station Number
 ; First assure ^DD(2260,13 has not been changed - implies conv run
 D FIELD^DID(2260,13,"","TYPE","ARR")
 I ARR("TYPE")'="FREE TEXT" QUIT
 S FAC=XPDQUES("PRE1")
 I $G(FAC)="" QUIT
 S IEN=0
 ; Loop thru file, if Station # blank, stuff with FAC
 ; if Station has a value, convert to pointer
 F  S IEN=$O(^OOPS(2260,IEN)) Q:IEN'>0  D
 . D GETS^DIQ(2260,IEN,13,"IE","ARR")
 . S STA=$G(ARR(2260,IEN_",",13,"I"))
 . I $G(STA)'="" D
 .. I ARR(2260,IEN_",",13,"E")'=ARR(2260,IEN_",",13,"I") Q
 .. I $O(^DIC(4,"D",STA,""))="" D
 ... S CASE=$$GET1^DIQ(2260,IEN,.01,"E")
 ... S MES="Station # for Case #: "_CASE_", could not be Converted, "
 ... S MES=MES_"Update Manually."
 ... D MES^XPDUTL(MES)
 .. I $O(^DIC(4,"D",STA,""))'="" S STA=$O(^DIC(4,"D",STA,""))
 . I '$G(STA) D
 .. S STA=FAC
 . K DA,DIE,DR
 . S DA=IEN,DIE="^OOPS(2260,",DR="13////"_STA
 . D ^DIE K DA,DIE,DR
 S MES="ASISTS Cases have been Updated with Station Number."
 D BMES^XPDUTL(MES)
 D MES^XPDUTL(" ")
 Q
 ;
POST ; Post-init used to Update Table files
 ; Load Dictionary with changed descriptions
 K DIE,DA,DR
 S DIE="^OOPS(2261.2,"
 S DA=11,DR=".01///^S X=""Hollow Bore Needlestick""" D ^DIE
 S DA=13,DR=".01///^S X=""Exposure to Body Fluids/Splash""" D ^DIE
 K DIE,DA,DR
 ; Need to do something about Suture Needlestick - being ADDED
 K DIC,DA,DR
 S (DIC,DIE)="^OOPS(2261.2,",DIC(0)="L",DLAYGO=2261.2
 S DINUM=14
 I $D(@(DIC_DINUM_")"))=0 D
 . S X="Suture Needlestick"
 . D FILE^DICN
 . S DA=+Y
 . S DR="1///^S X=DA"
 . D ^DIE
 E  D
 . S DA=14,DR=".01///^S X=""Suture Needlestick""" D ^DIE
 . S DR="1///^S X=DA" D ^DIE
 K DIC,DIE,DA,DR
 ;
 S DIE="^OOPS(2261.7,"
 S DA=39,DR=".01///^S X=""Drill bit/burr""" D ^DIE
 ; Need to do something about Blunt Suture Needle
 K DIC,DA,DR
 S (DIC,DIE)="^OOPS(2261.7,",DIC(0)="L",DLAYGO=2261.7
 S DINUM=66
 I $D(@(DIC_DINUM_")"))=0 D
 . S X="Blunt Suture Needle"
 . D FILE^DICN
 . S DA=+Y
 . S DR="1///^S X=50" D ^DIE
 . S DR="2///^S X=""N""" D ^DIE
 E  D
 . S DA=66,DR=".01///^S X=""Blunt Suture Needle""" D ^DIE
 . S DR="1///^S X=50" D ^DIE
 . S DR="2///^S X=""N""" D ^DIE
 K DIC,DIE,DA,DR
 S MES="Table Files have been Updated."
 D BMES^XPDUTL(MES)
 D MES^XPDUTL(" ")
 ; Update X-Reference for Station Number
 S DIK="^OOPS(2260,",DIK(1)="13^D" D ENALL^DIK
 QUIT
