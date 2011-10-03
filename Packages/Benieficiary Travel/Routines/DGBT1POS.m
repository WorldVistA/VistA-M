DGBT1POS ;ALB/LEB - Post-install of DGBT v1.0 ;[ 11/21/01 13:20 pm]
 ;;1.0;Beneficiary Travel;;Jun 25,  2001
 ;
 ; Update PACKAGE (#2) File fields not updated by the KIDS install.
 ; Used for documentation purposes.
 ;
 D BMES^XPDUTL(" ")
 D MES^XPDUTL("   Updating PACKAGE File...")
 ;
PKG ; Retrieve 'DGBT' Package name
 ; Get Package IEN
 D FIND^DIC(9.4,"","@;1","P","DGBT","","C","","","DGBTARRY")
 S (DGBTI,DGBTIEN)=0
 F  S DGBTI=$O(DGBTARRY("DILIST",DGBTI)) Q:'DGBTI  D
 . Q:$P($G(DGBTARRY("DILIST",DGBTI,0)),"^",2)'="DGBT"
 . S DGBTIEN=$P($G(DGBTARRY("DILIST",DGBTI,0)),"^",1)
 I 'DGBTIEN D  G EXIT
 . D BMES^XPDUTL(" ")
 . D MES^XPDUTL("  No PACKAGE entry defined - Cannot update!")
 ;
UPD ; - Update fields not updated by the KIDS install.
 ; fields:
 ;       Short Description (#2); required field
 ;       Description (#3)      ; word processing field
 ;       File (#6)             ; multiple
 ;         Fields              ; multiple
 ;
 ; - Replace Short Description (#2) field.
 K FDATA S FDATA(9.4,DGBTIEN_",",2)="Beneficiary Travel"
 D FILE^DIE("E","FDATA","ERR")
 D BMES^XPDUTL(" ")
 D MES^XPDUTL("     SHORT DESCRIPTION field complete.")
 K FDATA,ERR
 ;
 ; - Replace Description (#3) field. Leave blank.
 D WP^DIE(9.4,DGBTIEN_",",3,"K","")
 D BMES^XPDUTL(" ")
 D MES^XPDUTL("     DESCRIPTION field complete.")
 ;
FILE ; - Replace File (#9.44) field.
 ;   first remove (delete) existing fields.
 N DIC K DGBTARRY
 D LIST^DIC(9.44,","_DGBTIEN_",","@;.01","P","","","","","","","DGBTARRY")
 S (DGBTII,DGBTFIL)=0
 F  S DGBTII=$O(DGBTARRY("DILIST",DGBTII)) Q:'DGBTII  D
 . S DGBTFIEN=$P(DGBTARRY("DILIST",DGBTII,0),"^",1)
 . S DIE="^DIC(9.4,",DA(1)=DGBTIEN,DIE=DIE_DA(1)_",4,"
 . S DA=+DGBTFIEN,DR=".01///@" D ^DIE
 ;   after old entries deleted, add current File entries
 F X="43","43.1","392","392.1","392.2","392.3","392.4" D
 . S DIC="^DIC(9.4,",DA(1)=DGBTIEN
 . S DIC=DIC_DA(1)_",4,",DIC(0)="L",DIC("P")=$P(^DD(9.4,6,0),"^",2)
 . D ^DIC
 D BMES^XPDUTL(" ")
 D MES^XPDUTL("     FILE field complete.")
 ; - Add fields.
FLDS ; Add FIELD entries to File entries #43, #43.1
 ; Add ASSIGN A VERSION NUMBER? entries to File entries #392-392.4
 S DIC="^DIC(9.4,",DA(1)=DGBTIEN,DIC(0)="X"
 S DIC=DIC_DA(1)_",4,",DIC("P")=$P(^DD(9.4,6,0),"^",2)
 F X="43","43.1","392","392.1","392.2","392.3","392.4" D
 . D ^DIC
 . S DIE=DIC,DA=+Y
 . I X=43 F FLD=720,721,722 S DR="2///"_FLD D ^DIE
 . I X=43.1 F FLD=30.01,30.02,30.03,30.04,30.05 S DR="2///"_FLD D ^DIE
 . I X[392 S DR="222.2///Y" D ^DIE
 D BMES^XPDUTL(" ")
 D MES^XPDUTL("     FIELD field complete.")
 ;
XPREF ; Add 'DGBTZ' entry to the EXCLUDED NAME SPACE (#919) field.
 S DIC="^DIC(9.4,",DA(1)=DGBTIEN
 S DIC=DIC_DA(1)_",""EX"",",DIC(0)="L",DIC("P")=$P(^DD(9.4,919,0),"^",2)
 S X="DGBTZ" D ^DIC
 ;
EXIT K DIC,DIE,DGBTII,DGBTFIL,DGBTFIEN,DGBTIEN,X,DA,DGBTARRY
 Q
