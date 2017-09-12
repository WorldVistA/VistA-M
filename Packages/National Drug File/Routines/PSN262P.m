PSN262P ;BIR/MR Set missing CREATE DEFAULT POSSIBLE DOSAGE field (#40) in VA PRODUCT file (#50.68) ;06/09/10
 ;;4.0; NATIONAL DRUG FILE;**262**; 30 Oct 98;Build 6
 ;
 D BMES^XPDUTL(" Please wait...")
 ;
 N DIE,DR,DA
 S DIE="^PSNDF(50.68,",DR="40////Y"
 S DA=0 F  S DA=$O(^PSNDF(50.68,DA)) Q:'DA  D
 . I '$D(^PSNDF(50.68,+DA,0)) Q
 . I $P($G(^PSNDF(50.68,+DA,"DOS")),"^")'="" Q
 . D ^DIE
 Q
