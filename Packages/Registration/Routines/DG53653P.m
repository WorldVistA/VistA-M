DG53653P ;TDM - Patch DG*5.3*653 Pre-Install Utility Routine ; 11/22/05 9:06am
 ;;5.3;Registration;**653**;AUG 13, 1993;Build 2
 Q
 ;
EN N DIE,DA,DR
 D MOD386 Q:$G(XPDABORT)=2          ;Check file 38.6 entries
 D MOD30192 Q:$G(XPDABORT)=2        ;Edit file 301.92 entries
 Q
 ;
MOD386 ; Update entry in INCONSISTENT DATA ELEMENTS file (#38.6)
 N ERR
 K XPDABORT
 F RULE=4,7,9,11,13,15,16,19,24,29,30,31,34,60,72,74,75,76,78,81,83,85,86 D  Q:$G(XPDABORT)=2
 . D BMES^XPDUTL("Checking entry #"_RULE_" in 38.6 file.")
 . S DIE=38.6,DA=$$FIND1^DIC(DIE,"","X",RULE) I 'DA D  Q
 . . S XPDABORT=2
 . . D MES^XPDUTL("    *** Entry not found! ***")
 . . D BMES^XPDUTL("    *** Please contact EVS for assistance ***")
 . . D BMES^XPDUTL("    *** INSTALLATION ABORTED ***")
 . . D BMES^XPDUTL("")
 . D MES^XPDUTL("    *** Complete ***")
 D BMES^XPDUTL("")
 Q
 ;
MOD30192 ; Update entry in IVM DEMOGRAPHIC UPLOAD FIELDS file (#301.92)
 N ERR
 K XPDABORT
 S DIE=301.92
 D BMES^XPDUTL("Modifying 'RATED INCOMPETENT?' entry in 301.92 file.")
 S DA=$$FIND1^DIC(DIE,"","X","RATED INCOMPETENT?") I 'DA D  Q
 . S XPDABORT=2
 . D MES^XPDUTL("    *** Entry not found! ***")
 . D BMES^XPDUTL("    *** Please contact EVS for assistance ***")
 . D BMES^XPDUTL("    *** INSTALLATION ABORTED ***")
 . D BMES^XPDUTL("")
 S DR=".09////0" D ^DIE
 D MES^XPDUTL("    *** Update Complete ***")
 D BMES^XPDUTL("")
 Q
