DG53765P ;ALB/LBD - Patch DG*5.3*765 Post-Install Routine ; 7/25/07 12:53pm
 ;;5.3;Registration;**765**;AUG 13, 1993;Build 3
 Q
 ;
EN ; This routine will update the USE FOR Z07 CHECK field #6
 ; in the INCONSISTENT DATA ELEMENTS file #38.6 for CC 72, 74 and 81
 N RULE,DA,DIE,DR
 F RULE=72,74,81 D
 .D BMES^XPDUTL("Modifying entry #"_RULE_" in 38.6 file.")
 .S DIE=38.6,DA=$$FIND1^DIC(DIE,"","X",RULE)
 .I 'DA D  Q
 ..D MES^XPDUTL("    *** Entry not found! Nothing Updated!! ***") Q
 .S DR="6////0" D ^DIE
 .D MES^XPDUTL("    *** Update Complete ***")
 D BMES^XPDUTL("")
 Q
 ;
