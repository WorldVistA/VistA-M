ACKQIPRE ;AUG/JLTP BIR/PTD-QUASAR Version 2.0 Pre-Install Routine ; 02/26/96 14:22
V ;;2.0;QUASAR;;JUN 5,1996
 ;Setup checkpoints for KIDS.
 N %
 S %=$$NEWCP^XPDUTL("CHKPT1","MGRP^ACKQIPRE"),%=$$NEWCP^XPDUTL("CHKPT2","OPTN^ACKQIPRE")
 S %=$$NEWCP^XPDUTL("CHKPT3","TMPL^ACKQIPRE"),%=$$NEWCP^XPDUTL("CHKPT4","KILLDD^ACKQIPRE")
 ;Return to KIDS, and let KIDS run the checkpoints.
 Q
 ;
MGRP ;Delete obsolete mail group.
 Q:'$D(XPDQUES("PRE1"))  Q:'XPDQUES("PRE1")
 I '$O(^XMB(3.8,"B","ACKQ WORKLOAD",0)) D BMES^XPDUTL("Workload mail group already deleted.") Q
 S DA=$O(^XMB(3.8,"B","ACKQ WORKLOAD",0)),DIK="^XMB(3.8," D ^DIK K DA,DIK
 D BMES^XPDUTL("Obsolete mail group, ACKQ WORKLOAD, deleted.")
 K DA,DIK
 Q
 ;
OPTN ;Delete obsolete QUASAR options.
 Q:'$D(XPDQUES("PRE2"))  Q:'XPDQUES("PRE2")
 S DIK="^DIC(19," F JJ=1:1 S ACKOPTN=$P($T(TEXT+JJ),";;",2) Q:ACKOPTN=""  D
 .I '$O(^DIC(19,"B",ACKOPTN,0)) D BMES^XPDUTL("Option, "_ACKOPTN_", not found on this system.") Q
 .S DA=$O(^DIC(19,"B",ACKOPTN,0)) D ^DIK
 .D BMES^XPDUTL("Obsolete option, "_ACKOPTN_", deleted.")
 K ACKOPTN,DA,DIK,JJ
 Q
 ;
TMPL ;Remove obsolete input template.
 Q:'$O(^DIE("B","ACKQ CANDP ENTRY",0))
 S DA=$O(^DIE("B","ACKQ CANDP ENTRY",0)),DIK="^DIE(" D ^DIK K DA,DIK
 D BMES^XPDUTL("Obsolete input template, ACKQ CANDP ENTRY, deleted.")
 K DA,DIK
 Q
 ;
KILLDD ;Delete DDs for all QUASAR files and DATA for 509850.
 F ACKFILE=509850,509850.1,509850.2,509850.3,509850.4,509850.6,509850.7,509850.8 I $D(^DD(ACKFILE,0,"NM")) D
 .S ACKNM=$O(^DD(ACKFILE,0,"NM",""))
 .I (ACKFILE=509850.1),($$VERSION^XPDUTL("QUASAR")<2) D
 ..S DIE="^ACK(ACKFILE,8771,1,",DA=4,DA(1)=8771,DR=".01///@" D ^DIE K DA,DIE,DR
 ..S DIE="^ACK(ACKFILE,9778,1,",DA=3,DA(1)=9778,DR=".01///@" D ^DIE K DA,DIE,DR
 .S DIU="^ACK("_ACKFILE_",",DIU(0)=""
 .I ACKFILE=509850 S DIU(0)="D"
 .D EN^DIU2 K DIU
 .D MES^XPDUTL("   ...DD deletion completed for "_ACKNM_"."),MES^XPDUTL(" ")
 K ACKFILE,ACKNM,DA,DIE,DIU,DR
 Q
 ;
TEXT ;List of obsolete QUASAR options.
 ;;ACKQAS CDR ACCOUNT EDIT
 ;;ACKQAS CP ENTRY
 ;;ACKQAS MOD EDIT
 ;;ACKQAS STAFF ENTRY
 ;;ACKQAS SUPER MASTER
 ;;ACKQAS WKLD GEN TASKMAN
 ;;ACKQAS WKLD MENU
