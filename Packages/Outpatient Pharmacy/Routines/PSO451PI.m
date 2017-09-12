PSO451PI ;BIRM/MFR - PSO*7*451 Post-install routine ;10/26/15
 ;;7.0;OUTPATIENT PHARMACY;**451**;DEC 1997;Build 114
 ;
PRE ; Pre-Install Entry Point
 ; Killing off the old ASAP Definition - New ASAP Definition will be loaded with the Build (Preserving Customizations)
 N DIK,DA
 S DIK="^PS(58.4," S DA=0 F  S DA=$O(^PS(58.4,DA)) Q:'DA  D
 . I $$GET1^DIQ(58.4,DA,.01)="ASAP RECORD DEFINITION" D ^DIK
 . I $$GET1^DIQ(58.4,DA,.01)="STANDARD ASAP DEFINITION" D ^DIK
 Q
 ;
POST ; Post-Install Entry Point
 ; Enabling all access for all 3 files below 
 N SECURITY
 S SECURITY("RD")=""
 S SECURITY("DD")=""
 S SECURITY("RD")=""
 S SECURITY("WR")=""
 S SECURITY("DEL")=""
 S SECURITY("LAYGO")=""
 S SECURITY("AUDIT")=""
 D FILESEC^DDMOD(58.4,.SECURITY)
 D FILESEC^DDMOD(58.42,.SECURITY)
 ;
 ; Updating the following NEW fields in the SPMP STATE PARAMETERS file (#58.41):
 ; RENAME FILE AFTER UPLOAD (#17), SFTP SSH KEY FORMAT (#18) & SFTP SSH KEY ENCRYPTION (#19)
 N DIE,DA,ENCR,USERNAME,DR
 S DIE="^PS(58.41,",DA=0 F  S DA=$O(^PS(58.41,DA)) Q:'DA  D
 . S ENCR="DSA" S:$$DECRYP^XUSRB1($G(^PS(58.41,DA,"PRVKEY",3,0)))["rsa" ENCR="RSA"
 . S DR="" I $$GET1^DIQ(58.41,DA,17)="" S DR="17///1;"
 . S DR=DR_"18///SSH2;19///"_ENCR
 . ; Fix for Appriss Sites that had to tweak the IP ADDRESS and USERNAME parameters to make it work
 . I $$UP^XLFSTR($$GET1^DIQ(58.41,DA,7))["PRODPMPSFTP",$$UP^XLFSTR($$GET1^DIQ(58.41,DA,8))["USER=" D
 . . S USERNAME=$P($$GET1^DIQ(58.41,DA,8),"=",2)_"@prodpmpsftp"
 . . S DR=DR_";7///sftp.pmpclearinghouse.net;8///"_USERNAME
 . D ^DIE
 ;
 ; Deleting unused field ERRORS (#200) from SPMP EXPORT BATCH file (#58.42)
 S DIK="^DD(58.42,",DA=200,DA(1)=58.42 D ^DIK
 ;
 ; Change Mail Group PSO SPMP NOTIFICATIONS to PUBLIC
 N DIC,X,Y,DA,DIE,DR
 S DIC=3.8,X="PSO SPMP NOTIFICATIONS" D ^DIC I '($G(Y)>0) Q
 S DIE=3.8,DA=+Y,DR="4///PU" D ^DIE
 Q
