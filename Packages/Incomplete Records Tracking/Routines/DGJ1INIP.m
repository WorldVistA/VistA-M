DGJ1INIP ;ALB/MRY - Post-install of DGJ v1.0 ;[ 11/21/01 13:20 pm]
 ;;1.0;Incomplete Records Tracking;;Jun 25,  2001
 ;
 ; Update PACKAGE (#2) File fields not updated by the KIDS install.
 ; Used for documentation purposes.
 ;
 D BMES^XPDUTL(" ")
 D MES^XPDUTL("   Updating PACKAGE File...")
 ;
PKG ; Retrieve 'DGJ' Package name
 ; Get Package IEN
 D FIND^DIC(9.4,"","@;1","P","DGJ","","C","","","DGJARRY")
 S (DGJI,DGJIEN)=0
 F  S DGJI=$O(DGJARRY("DILIST",DGJI)) Q:'DGJI  D
 . Q:$P($G(DGJARRY("DILIST",DGJI,0)),"^",2)'="DGJ"
 . S DGJIEN=$P($G(DGJARRY("DILIST",DGJI,0)),"^",1)
 I 'DGJIEN D  G ABRT^DGJ1INIT
 . D BMES^XPDUTL(" ")
 . D MES^XPDUTL("   No Package entry defined - Cannot update!")
 ;
UPD ; - Update fields not updated by the KIDS install.
 ; fields:
 ;       Short Description (#2); required field
 ;       Description (#3)      ; word processing field
 ;       File (#6)             ; multiple
 ;         Fields              ; multiple
 ;
 ; - Replace Short Description (#2) field.
 K FDATA S FDATA(9.4,DGJIEN_",",2)="IRT"
 D FILE^DIE("E","FDATA","ERR")
 D BMES^XPDUTL(" ")
 D MES^XPDUTL("     SHORT DESCRIPTION field complete.")
 K FDATA,ERR
 ;
 ; - Replace Description (#3) field. Leave blank.
 D WP^DIE(9.4,DGJIEN_",",3,"K","")
 D BMES^XPDUTL(" ")
 D MES^XPDUTL("     DESCRIPTION field complete.")
 ;
FILE ; - Replace File (#9.44) field.
 ;   first remove (delete) existing fields.
 N DIC K DGJARRY
 D LIST^DIC(9.44,","_DGJIEN_",","@;.01","P","","","","","","","DGJARRY")
 S DGJII=0
 F  S DGJII=$O(DGJARRY("DILIST",DGJII)) Q:'DGJII  D
 . S DGJFIEN=$P(DGJARRY("DILIST",DGJII,0),"^",1)
 . S DIE="^DIC(9.4,",DA(1)=DGJIEN,DIE=DIE_DA(1)_",4,"
 . S DA=+DGJFIEN,DR=".01///@" D ^DIE
 ;   after old entries deleted, add current File entries
 F X="40.8","43","405","393","393.1","393.2","393.3","393.41" D
 . S DIC="^DIC(9.4,",DA(1)=DGJIEN
 . S DIC=DIC_DA(1)_",4,",DIC(0)="L",DIC("P")=$P(^DD(9.4,6,0),"^",2)
 . D ^DIC
 D BMES^XPDUTL(" ")
 D MES^XPDUTL("     FILE field complete.")
 ; - Add fields.
FLDS ; Add FIELD entries to File entries #40.8, #43, #405.
 ; Add ASSIGN A VERSION NUMBER? entries to File entries #393-393.41.
 S DIC="^DIC(9.4,",DA(1)=DGJIEN,DIC(0)="X"
 S DIC=DIC_DA(1)_",4,",DIC("P")=$P(^DD(9.4,6,0),"^",2)
 F X="40.8","43","405","393","393.1","393.2","393.3","393.41" D
 . D ^DIC
 . S DIE=DIC,DA=+Y
 . I X="40.8" F FLD="100.01","100.02","100.03","100.04","100.05","100.06","100.07","100.08","100.09","100.1","100.2","100.3" S DR="2///"_FLD D ^DIE
 . I X="43" F FLD="401","513" S DR="2///"_FLD D ^DIE
 . I X=405 S FLD=60.01 S DR="2///"_FLD D ^DIE
 . I X[393 S DR="222.2///Y" D ^DIE
 D BMES^XPDUTL(" ")
 D MES^XPDUTL("     FIELD field complete.")
 ;
XPREF ; Add 'DGJZ' entry to the EXCLUDED NAME SPACE (#919) field of DGJ.
 S DIC="^DIC(9.4,",DA(1)=DGJIEN
 S DIC=DIC_DA(1)_",""EX"",",DIC(0)="L",DIC("P")=$P(^DD(9.4,919,0),"^",2)
 S X="DGJZ" D ^DIC
 ;
 ; Add 'DGJ' entry to the EXCLUDED NAME SPACE (#919) field of DG.
 S DIC="^DIC(9.4,",DIC(0)="X",X="REGISTRATION"
 D ^DIC I Y<0 D  G ABRT^DGJ1INIT
 . D BMES^XPDUTL("REGISTRATION PACKAGE HAS NOT BEEN FOUND")
 . D MES^XPDUTL("CONTACT - PIMS National VISTA Support Team for assistance!")
 S DA(1)=+Y,DIC=DIC_DA(1)_",""EX"",",DIC(0)="L",DIC("P")=$P(^DD(9.4,919,0),"^",2)
 S X="DGJ" D ^DIC
 ;
EXIT K DIC,DIE,DGJII,DGJFIEN,DGJIEN,X,DA,DGJARRY
 Q
