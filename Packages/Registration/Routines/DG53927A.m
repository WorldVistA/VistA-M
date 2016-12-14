DG53927A ;ALB/BG - TREATING SPECIALTIE UPDATES ; 5/11/16 10:51AM
 ;;5.3;Registration;**927**;Aug 13, 1993;Build 2
 ;
 Q
INACT ;inactivate treating specialties
 N DA,DIE,DR,X,DGTSP
 F DGTSP=23,31,33,35,57,87 D
 . S DIC="^DIC(42.4,"_DGTSP_",""E"","
 . S DA(1)=DGTSP
 . S DIC(0)="LX"
 . S DIC("P")=$P(^DD(42.4,10,0),"^",2)
 . S X=3161001
 . D ^DIC
 . S DA=+Y
 . I +Y=-1 D BMES^XPDUTL(">>>Inactive date not added to TS code "_DGTSP_" in the Specialty file.<<<") Q
 . D BMES^XPDUTL(">>>Inactive date added to TS code "_DGTSP_" in the Specialty file.<<<")
 . S DIE=DIC
 . S DR=".02///N"
 . D ^DIE
 . ;check for CODES in the Facility Treating Specialty File (45.7
 . ;add inactivation date of 2/1/2010
 . D BMES^XPDUTL("  ")
 . D MES^XPDUTL("     FACILITY TREATING SPECIALTY FILE being checked to see if any entries are")
 . D MES^XPDUTL("     pointing to "_DGTSP_".  If so, they will be inactivated.>>>")
 .N DAA F DAA=0:0 S DAA=$O(^DIC(45.7,"ASPEC",DGTSP,DAA)) Q:'DAA  D
 .. N DIE,DR,TS,X S TS=""
 ..S TS=$P($G(^DIC(45.7,DAA,0)),"^")
 ..S DIC="^DIC(45.7,"_DAA_",""E"","
 ..S DA(1)=DAA
 ..S DIC(0)="LX"
 ..S X=3161001
 ..D ^DIC
 ..S DA=+Y
 ..I +Y=-1 D BMES^XPDUTL("     Inactive date not added to "_TS_"in the Facility Treating Specialty file.") Q
 ..D BMES^XPDUTL("     Inactive date added to "_TS_" in the Facility Treating Specialty file.<<<")
 ..S DIE=DIC
 ..S DR=".02///N"
 ..D ^DIE
 Q
