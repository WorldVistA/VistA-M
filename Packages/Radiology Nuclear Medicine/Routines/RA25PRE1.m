RA25PRE1 ;HOIFO/CRT - Pre-install routine for Rad patch 25
 ;;5.0;Radiology/Nuclear Medicine;**25**;Mar 16, 1998
 ;
 ; This routine will remove an existing option from menu
 ; because it will be added to a new menu later.
 ;
 ; Also changes Country Code to USA, from US for RA apps.
 ;
EN1 ;
 D MENU
 D USA
 Q
 ;
MENU N DA,DIK
 ;
 S DA(1)=$O(^DIC(19,"B","RA MAINTENANCEP",0)) Q:DA(1)=""
 S DA=$O(^DIC(19,"B","RA HL7 VOICE REPORTING ERRORS",0)) Q:DA=""
 ;
 S DA=$O(^DIC(19,DA(1),10,"B",DA,0)) Q:DA=""
 ;
 S DIK="^DIC(19,"_DA(1)_",10,"
 ;
 D EN^DDIOL("Removing 'Rad/Nuc Med HL7 Voice Reporting Errors'",,"!!?5")
 D EN^DDIOL("option from 'Maintenance Files Print Menu'...",,"!?5")
 ;
 D ^DIK
 Q
 ;
USA ; Change Country Code to USA
 ;
 N RAIENS,RAFDA,RAOUT,RACNTRY
 ;
 S RACNTRY=$O(^HL(779.004,"B","USA",0))
 Q:'RACNTRY
 ;
 F HL771="RA-TALK","RA-PSC","RA-VOICE" D 
 .S Y=HL771
 .F  S Y=$O(^HL(771,"B",Y)) Q:Y=""!(Y'[HL771)  D
 ..S RAIENS=$O(^HL(771,"B",Y,0))
 ..Q:RAIENS=""
 ..S RAIENS=RAIENS_","
 ..S RAFDA(771,RAIENS,7)=RACNTRY
 ..D FILE^DIE(,"RAFDA","RAOUT")
 ..I $G(RAFDA)'="" D  Q
 ...D EN^DDIOL("Failed to Update Country Code for Application '"_Y_"' to 'USA'",,"!?5")
 ..D EN^DDIOL("Updated Country Code for Application '"_Y_"' to 'USA'",,"!?5")
 Q
