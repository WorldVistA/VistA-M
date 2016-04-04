SDRPSTOP ;ALB/TXH - STOP PAIT HL7 TRANSMISSIONS;07/09/15
 ;;5.3;Scheduling;**639**;AUG 13, 1993;Build 7
 ;
 ; This post-init routine 
 ; - disable the SD-PAIT Logical Link
 ; - unschedule the PAIT transmission task
 ; - place PAIT options Out of Order
 ; - inactivate PAIT related HL7 Application Parameters
 ;
 Q
 ;
EN ; Entry Point
 D BMES^XPDUTL("SD*5.3*639 Post-Init Started...")
 D LOGLNK
 D DELETE
 D OPTOUT
 D INACT
 D BMES^XPDUTL("SD*5.3*639 Post-Init Finished.")
 D MES^XPDUTL(" ")
 Q
 ;
LOGLNK ; Disable the SD-PAIT Logical Link
 ;
 D BMES^XPDUTL("* Disabling SD-PAIT Logical Link...")
 N SDLNK,SDMCL,DA,DR
 S SDLNK="SD-PAIT"
 S SDMCL=$O(^HLCS(870,"B",SDLNK,""))
 I SDMCL="" D MES^XPDUTL("     "_SDLNK_" not found. It's okay.") Q
 ; get AUTOSTART disabled and set SHUTDOWN LLP to YES.
 N DIE S DIE="^HLCS(870,",DA=SDMCL,DR="4.5///0;14///1"
 D ^DIE
 D MES^XPDUTL("  Done.")
 Q
 ;
DELETE ; Remove the PAIT transmission task in Option Schedule
 ;
 ; IA #6121 Remove Scheduled options from #19.2
 ; IA #2051 Database Server API: Lookup Utilities (DIC)
 ;
 D BMES^XPDUTL("* Removing PAIT Transmission Task...")
 N SDRPTSK,SDOPT,DA,DIK
 S SDRPTSK="SD-PAIT TASKED TRANSMISSION"
 S SDOPT=$O(^DIC(19,"B",SDRPTSK,""))
 I SDOPT="" D MES^XPDUTL("     "_SDRPTSK_" not found. It's okay.") Q
 S DA="" F  S DA=$O(^DIC(19.2,"B",SDOPT,DA)) Q:'+DA  D
 . S ^XTMP("SDRPTSK",$J,0)=$$FMADD^XLFDT(DT+90)_"^"_DT_"^copy of SD-PAIT TASKED TRANSMISSION in #19.2^"_DA
 . M ^XTMP("SDRPTSK",$J,"DIC",19.2,DA)=^DIC(19.2,DA)
 . S DIK="^DIC(19.2,"
 . D ^DIK
 D MES^XPDUTL("  Done.")
 Q
 ;
OPTOUT ; Set options out of order
 ;
 ; IA #1157 OUT^XPDMENU(OPT,TXT)
 ;
 D BMES^XPDUTL("* Placing the following PAIT options out of order...")
 N SDMCN,SDOPT,SDTXT,OPTMSG
 S SDTXT="This functionality is now accomplished by CDW/VSSC."
 F SDMCN=1:1 S SDOPT=$P($TEXT(OPTLIST+SDMCN),";;",2) Q:SDOPT="$$END"!(SDOPT="")  D
 . D OUT^XPDMENU(SDOPT,SDTXT)  ;Mark option out-of-order
 . S OPTMSG="    "_SDOPT
 . D MES^XPDUTL(OPTMSG)
 D MES^XPDUTL("  Done.")
 Q
 ; 
INACT ; Make PAIT related HL7 APPLICATION PARAMETERs inactive
 ;
 D BMES^XPDUTL("* Inactivating PAIT HL7 Application Parameter...")
 N SDMCN,SDPARA,SDIEN,INACT,SDMSG1,INACTMG
 F SDMCN=1:1 S SDPARA=$P($TEXT(NAME771+SDMCN),";;",2) Q:SDPARA="$$END"!(SDPARA="")  D
 . S SDIEN=$O(^HL(771,"B",SDPARA,"")) D
 . . I SDIEN="" S SDMSG1="     "_SDPARA_" not found. It's okay." D MES^XPDUTL(SDMSG1) Q
 . . N DIE S DIE="^HL(771,",DA=SDIEN,DR="2///i"
 . . D ^DIE
 . . S INACTMG="     "_SDPARA
 . . D MES^XPDUTL(INACTMG)
 D MES^XPDUTL("  Done.")
 Q
 ;
OPTLIST ; PAIT options
 ;;SD-PAIT MANUAL BATCH REJECT
 ;;SD-PAIT MANUAL TRANSMISSION
 ;;SD-PAIT TASKED TRANSMISSION
 ;;SD-PAIT REPAIR
 ;;$$END
 ;
NAME771 ; HL7 Application Parameter
 ;;SD-AAC-PAIT
 ;;SD-SITE-PAIT
 ;;$$END
