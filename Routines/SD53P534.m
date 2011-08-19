SD53P534 ; ALB/ESW - POST INSTALL; 2/11/03 12:49pm
 ;;5.3;Scheduling;**534**;AUG 13, 1993;Build 8
 ;
 Q
POST ;
 ; Add/edit PCMM HL7 ERROR CODE '850'
 N DIC,DIE,DA,DLAYGO,DR,X,Y,SDARRY,SDIENS
 S DIC="^SCPT(404.472,",DIC(0)=""
 S X="850"
 D ^DIC I Y>0 D  Q
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("Unsuccessful update!  ** Code 850 already exists. **")
 . D MES^XPDUTL("*****")
 .; S XPDABORT=2  <----disable abort; send only a message
 S DIC="^SCPT(404.472,",DIC(0)="" D FILE^DICN
 S DA=+Y,DR=".02///PV1;.03///4;.04///Admit type is invalid (table SD009)"
 S SDIENS=+Y_","
 S DIE=DIC D ^DIE
 S SDARRY(1)="Error code indicates that the Admission Type does not match values from"
 S SDARRY(2)="the Table SD009 - Purpose of Visit & appointment Type."
 D WP^DIE(404.472,SDIENS,10,"","SDARRY")
 D BMES^XPDUTL("*****")
 D MES^XPDUTL("   The PCMM HL7 ERROR CODE (#404.472) File has been updated")
 D MES^XPDUTL("   with the '850' Error Code.")
 D MES^XPDUTL("*****")
 Q
