ICD125PT ;ALB/ABR - RESTORE NAME TO ICD (DRG) GLOBAL - AUG 9 1996
 ;;12.0;DRG GROUPER;**5**;APR 12, 1995
 ;This routine will restore the .01 name value in file 80.2
 ;
EN ;
 N X,Y,DA,DR,DIE
 D BMES^XPDUTL("Cleaning up DRG file.")
 S DA=0
 S DIE="^ICD("
 F  S DA=$O(^ICD(DA)) Q:'DA  I $E(^(DA,0))="^" D
 . S DR=".01///DRG"_DA D ^DIE
 D MES^XPDUTL(">> DONE!")
 Q
