SD53P515 ;bpoifo/swo post init 8.7.2007
 ;;5.3;Scheduling;**515**;Aug 13, 1993;Build 14
 Q  ;no entry from top
POST ;entry point post init
 N DA,DIE,DR,SCMCV1,SCMCV2,SCMCV3
 S SCMCV1=$$KSP^XUPARAM("INST")
 I SCMCV1="" D  Q
 .D BMES^XPDUTL("Cannot determine your station.  Post Init will abort, contact IRM")
 S SCMCV2=$O(^HL(771,"B","PCMM-515",""))
 I SCMCV2="" D  Q
 .D BMES^XPDUTL("Cannot find HL7 APPLICATION PARAMETER ""PCMM-515"" Post Init will abort, contact IRM")
 D BMES^XPDUTL("Setting FACILITY NAME field of PCMM-515 application parameter to")
 D MES^XPDUTL(SCMCV1)
 S DIE="^HL(771,",DA=SCMCV2,DR="3///"_SCMCV1 D ^DIE
 S SCMCV3=$O(^ORD(101,"B","PCMM SEND CLIENT FOR ADT-A08",""))
 I SCMCV3="" D  Q
 .D BMES^XPDUTL("Cannot find PROTOCOL ""PCMM SEND CLIENT FOR ADT-A08"" Post Init will abort, contact IRM")
 Q
PRE ;entry point pre init
 I $D(^XTMP("SCMCHL")) D  S XPDABORT=1 Q
 .D BMES^XPDUTL("PCMM HL7 transmission in progress.  Patch cannot be installed at this time.")
 Q
