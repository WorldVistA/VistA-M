PRCXSTOP ;ALB/TXH - STOP FPDS HL7 TRANSMISSIONS;10/08/20
 ;;5.1;IFCAP;**220**;AUG 13, 1993;Build 23
 ;
 ; This post-init routine will
 ; - disable the IFCAP_FPDS Logical Link
 ; - purge outstanding entries in files 773/772 for logical link "IFCAP_FPDS
 ;
 Q
 ;
EN ; Entry Point
 D BMES^XPDUTL("PRC*5.1*220 Post-Init Started...")
 D LOGLNK
 Q
 ;
LOGLNK ; Disable the IFCAP_FPDS Logical Link
 ;
 D BMES^XPDUTL("   * Disabling the following Logical Link...")
 N PRCLOG,PRCLOGN,PRCLOGLK,DR,PRCLKMSG,PRCLNK,PRCTT,PRCHL7TX,PRCII
 S PRCLOG=0,PRCTT=0,U="^"
 F PRCLOGN=1:1 S PRCLOGLK=$P($TEXT(LOGLIST+PRCLOGN),";;",2) Q:PRCLOGLK="$$END"!(PRCLOGLK="")  D
 . S PRCLNK=+$$FIND1^DIC(870,"","BX",PRCLOGLK,"","","")
 . I PRCLNK="" D MES^XPDUTL("    "_PRCLOGLK_" not found. It's okay.") Q
 . ; Get AUTOSTART disabled and set SHUTDOWN LLP to YES.
 . ; Get STATE "SHUTDOWN" and set TIME STOPPED to date/time.
 . N DIE S DIE="^HLCS(870,",DA=PRCLNK,DR="4.5///0;14///1"
 . D ^DIE
 . S PRCLKMSG="     "_PRCLOGLK
 . D MES^XPDUTL(PRCLKMSG)
 D MES^XPDUTL("     Done.")
PURGHL7 ;purge any pending FPDS HL7 messages from file 773
 D BMES^XPDUTL("   * Purging all HL7 pending messages for FPDS Logical Link 'IFCAP_FPDS'...")
 F PRCII="I","O" S PRCHL7TX=0 F  S PRCHL7TX=$O(^HLMA("AC",PRCII,PRCLNK,PRCHL7TX)) Q:'PRCHL7TX  D
 . S DA=$P($G(^HLMA(PRCHL7TX,0)),U) I DA S DIK="^HL(772," D ^DIK
 . S PRCTT=PRCTT+1
 . S DA=PRCHL7TX,DIK="^HLMA(" D ^DIK K ^HLMA("AC",PRCII,PRCLNK,PRCHL7TX)
 K DA,DIK
 D MES^XPDUTL("     Done.  "_PRCTT_" HL7 FPDS ENTRIES PURGED")
 Q
 ;
LOGLIST ; Logical Links
 ;;IFCAP_FPDS
 ;;$$END
 ;
