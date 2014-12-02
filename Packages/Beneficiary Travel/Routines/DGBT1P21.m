DGBT1P21 ;ALB/DBE - BENEFICIARY TRAVEL DEFAULT MILEAGE DELETION ; 6/5/13 11:47am
 ;;1.0;Beneficiary Travel;**21**;September 25, 2001;Build 7
 ;
 ;this routine is used as a post-init to remove all entries in the 
 ;BENEFICIARY TRAVEL DISTANCE (#392.1) file
 ;
 ;  ICR#   SUPPORTED
 ;  -----  -----------
 ;  2055   PRD^DILFD
 ;  2056   $$GET1^DIQ
 ;  10013  ^DIK
 ;  10103  ^XLFDT
 ;  10141  BMES^XPDUTL
 ;
 Q
 ;
START ;* entry point for post install
 ;
 I $$GET1^DID(392.1,"","","PACKAGE REVISION DATA")["DGBT*1.0*21" D  Q
  .D BMES^XPDUTL("Entries in the BENEFICIARY TRAVEL DISTANCE (#392.1) file have already been removed.")
 D BACKUP
 D MILEDEL
 D PRD^DILFD(392.1,"DGBT*1.0*21")
 Q
 ;
BACKUP ;* backup ^DGBT(392.1) global data to an XTMP array
 ;
 D BMES^XPDUTL("Backing up BENEFICIARY TRAVEL DISTANCE (#392.1) file to ^XTMP(""DGBT1P21"")...")
 S ^XTMP("DGBT1P21",0)=$$FMADD^XLFDT($$DT^XLFDT,90)_"^"_$$DT^XLFDT_"^"_"Backup of BENEFICIARY TRAVEL DISTANCE (#392.1) file"
 M ^XTMP("DGBT1P21","DATA")=^DGBT(392.1)
 D BMES^XPDUTL("    ...backup complete.")
 ;
 Q
 ;
MILEDEL ;* delete all entries from the BENEFICIARY TRAVEL DISTANCE (#392.1) file
 ;
 N DA,DIK
 D BMES^XPDUTL("Deleting entries in the BENEFICIARY TRAVEL DISTANCE (#392.1) file...")
 S DA=0,DIK="^DGBT(392.1," F  S DA=$O(^DGBT(392.1,DA)) Q:'DA  D ^DIK
 D BMES^XPDUTL("    ..entries deleted.")
 ;
 Q
